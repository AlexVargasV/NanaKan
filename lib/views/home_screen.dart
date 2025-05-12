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
    final languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);
    filteredCards = languageProvider.getTranslatedCards();
  }

  void filterCards(String query) {
    final languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);
    List<Map<String, String>> allCards = languageProvider.getTranslatedCards();

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
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade300, Colors.purple.shade300],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Text(
                    languageProvider
                        .translate("menu"), // ✅ Traducido dinámicamente
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home, color: Colors.blue),
                  title:
                      Text(languageProvider.translate("home")), // ✅ Traducido
                  onTap: () => Navigator.pop(context),
                ),
                ListTile(
                  leading: Icon(Icons.favorite, color: Colors.red),
                  title: Text(
                      languageProvider.translate("dedication")), // ✅ Traducido
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DedicatoriaPage())),
                ),
                ListTile(
                  leading: Icon(Icons.monitor_heart, color: Colors.grey),
                  title:
                      Text(languageProvider.translate("test")), // ✅ Traducido
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TestPage())),
                ),
              ],
            ),
          ),
          body: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: translatedCards.length,
            itemBuilder: (context, index) {
              return AnimatedCard(
                id: translatedCards[index]["id"]!,
                title: translatedCards[index]["title"]!,
                description: translatedCards[index]["description"]!,
                imageAsset: translatedCards[index]["image"]!,
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
