import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/animated_card.dart';
import 'test_page.dart';
import 'dedicatoria_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>> filteredCards = [];
  @override
  void initState() {
    super.initState();
    _checkNotificationPermission();
  }

  Future<void> _checkNotificationPermission() async {
    var status = await Permission.notification.status;
    if (!status.isGranted) {
      _showNotificationPermissionDialog();
    }
  }

  void _showNotificationPermissionDialog() {
    final langProvider = Provider.of<LanguageProvider>(context, listen: false);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // 🔥 Variable para controlar el estado de los botones
    bool isButtonDisabled = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: isDark ? Colors.grey[900] : Colors.white,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.9,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.notifications_active,
                          color: isDark ? Colors.amber : Colors.deepPurple,
                          size: 60),
                      const SizedBox(height: 16),
                      Text(
                        langProvider.translate('notification_permission_title'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        langProvider.translate('notification_permission_desc'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: isDark ? Colors.grey[300] : Colors.black87,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          ElevatedButton.icon(
                            onPressed: isButtonDisabled
                                ? null // 🔥 Desactiva botón si ya se presionó
                                : () async {
                                    setState(() => isButtonDisabled = true);
                                    await Permission.notification.request();
                                    Navigator.of(context).pop();
                                  },
                            icon: Icon(Icons.check,
                                size: 20, color: Colors.white),
                            label: Flexible(
                              child: Text(
                                langProvider
                                    .translate('btn_allow_notifications'),
                                style: TextStyle(fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: isButtonDisabled
                                ? null // 🔥 Desactiva botón si ya se presionó
                                : () {
                                    setState(() => isButtonDisabled = true);
                                    Navigator.of(context).pop();
                                  },
                            icon: Icon(Icons.close,
                                size: 20, color: Colors.white),
                            label: Flexible(
                              child: Text(
                                langProvider.translate('btn_skip'),
                                style: TextStyle(fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final languageProvider = Provider.of<LanguageProvider>(context);
    final allCards = languageProvider.getTranslatedCards();
    setState(() {
      filteredCards = allCards;
    });
  }

  void filterCards(String query) {
    final languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);
    final allCards = languageProvider.getTranslatedCards();
    final normalizedQuery = _normalize(query);

    setState(() {
      filteredCards = query.isEmpty
          ? allCards
          : allCards.where((card) {
              final title = _normalize(card["title"]!);
              final description = _normalize(card["description"]!);
              return title.contains(normalizedQuery) ||
                  description.contains(normalizedQuery);
            }).toList();
    });
  }

  /// 🔹 Método auxiliar para normalizar cadenas (elimina tildes, convierte a minúsculas)
  String _normalize(String input) {
    return input
        .toLowerCase()
        .replaceAll(RegExp(r'[áàäâ]'), 'a')
        .replaceAll(RegExp(r'[éèëê]'), 'e')
        .replaceAll(RegExp(r'[íìïî]'), 'i')
        .replaceAll(RegExp(r'[óòöô]'), 'o')
        .replaceAll(RegExp(r'[úùüû]'), 'u')
        .replaceAll(
            RegExp(r'[^a-z0-9 ]'), ''); // elimina símbolos si es necesario
  }

  int _currentIndex = 0;

  void _onNavBarTap(int index) {
    if (index == 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DedicatoriaPage()));
    } else if (index == 2) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => TestPage()));
    }
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        final translatedCards = languageProvider.getTranslatedCards();

        return Scaffold(
          appBar: CustomAppBar(onSearch: filterCards),
          drawer: Drawer(
            child: Consumer<LanguageProvider>(
              builder: (context, languageProvider, child) {
                final isDark = Theme.of(context).brightness == Brightness.dark;
                final textColor = isDark ? Colors.white : Colors.black87;
                final iconColor = isDark ? Colors.white70 : Colors.grey[800];

                return Container(
                  color: isDark ? Colors.grey[900] : Colors.grey[100],
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      DrawerHeader(
                        decoration: BoxDecoration(
                          gradient: isDark
                              ? LinearGradient(
                                  colors: [
                                    Colors.black87,
                                    Colors.grey.shade800
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                )
                              : LinearGradient(
                                  colors: [
                                    Colors.blue.shade300,
                                    Colors.purple.shade300
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  AssetImage("assets/images/kan1.jpg"),
                            ),
                            SizedBox(height: 12),
                            Text(
                              "Nana Kan",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              languageProvider.translate("menu"),
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        leading: SvgPicture.asset(
                          'assets/svg/home.svg',
                          height: 26,
                          width: 26,
                          colorFilter: ColorFilter.mode(
                            isDark ? Colors.white : Colors.black,
                            BlendMode.srcIn,
                          ),
                        ),
                        title: Text(
                          languageProvider.translate("home"),
                          style: TextStyle(
                            fontSize: 16,
                            color: textColor,
                          ),
                        ),
                        onTap: () => Navigator.pop(context),
                      ),
                      Divider(thickness: 1, color: Colors.grey.shade400),
                      ListTile(
                        leading: SvgPicture.asset(
                          'assets/svg/dedicatoria.svg',
                          height: 26,
                          width: 26,
                          colorFilter: ColorFilter.mode(
                            isDark ? Colors.white : Colors.black,
                            BlendMode.srcIn,
                          ),
                        ),
                        title: Text(
                          languageProvider.translate("dedication"),
                          style: TextStyle(
                            fontSize: 16,
                            color: textColor,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DedicatoriaPage()),
                          );
                        },
                      ),
                      ListTile(
                        leading: SvgPicture.asset(
                          'assets/svg/test.svg',
                          height: 26,
                          width: 26,
                          colorFilter: ColorFilter.mode(
                            isDark ? Colors.white : Colors.black,
                            BlendMode.srcIn,
                          ),
                        ),
                        title: Text(
                          languageProvider.translate("test"),
                          style: TextStyle(
                            fontSize: 16,
                            color: textColor,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TestPage()),
                          );
                        },
                      ),
                      Divider(thickness: 1, color: Colors.grey.shade400),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "© 2025 Nana Kan",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark ? Colors.grey[400] : Colors.grey[700],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          body: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: filteredCards.length,
            itemBuilder: (context, index) {
              return AnimatedCard(
                id: filteredCards[index]["id"]!,
                title: filteredCards[index]["title"]!,
                description: filteredCards[index]["description"]!,
                imageAsset: filteredCards[index]["image"]!,
              );
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: _onNavBarTap,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/svg/home.svg',
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : const Color.fromARGB(255, 14, 13, 13),
                      BlendMode.srcIn,
                    ),
                  ),
                  label: languageProvider.translate("home")), // ✅ Traducido
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/svg/dedicatoria.svg',
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : const Color.fromARGB(255, 247, 3, 3),
                      BlendMode.srcIn,
                    ),
                  ),
                  label:
                      languageProvider.translate("dedication")), // ✅ Traducido
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/svg/test.svg',
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : const Color.fromARGB(255, 2, 2, 2),
                      BlendMode.srcIn,
                    ),
                  ),
                  label: languageProvider.translate("test")), // ✅ Traducido
            ],
          ),
        );
      },
    );
  }
}
