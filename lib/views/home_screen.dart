import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/animated_card.dart';
import 'test_page.dart';
import 'dedicatoria_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>> filteredCards = [];

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
                        leading: Icon(Icons.home, color: iconColor),
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
                        leading: Icon(Icons.favorite, color: Colors.pinkAccent),
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
                        leading: Icon(Icons.monitor_heart, color: Colors.teal),
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
                  icon: Icon(Icons.home),
                  label: languageProvider.translate("home")), // ✅ Traducido
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label:
                      languageProvider.translate("dedication")), // ✅ Traducido
              BottomNavigationBarItem(
                  icon: Icon(Icons.monitor_heart),
                  label: languageProvider.translate("test")), // ✅ Traducido
            ],
          ),
        );
      },
    );
  }
}
