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

    setState(() {
      filteredCards = query.isEmpty
          ? allCards
          : allCards
              .where((card) =>
                  card["title"]!.toLowerCase().contains(query.toLowerCase()) ||
                  card["description"]!
                      .toLowerCase()
                      .contains(query.toLowerCase()))
              .toList();
    });
  }

  int _currentIndex = 0;

  void _onNavBarTap(int index) {
    if (index == 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DedicatoriaPage()));
    } else if (index == 2) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ConfiguracionPage()));
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
                  leading: Icon(Icons.settings, color: Colors.grey),
                  title: Text(
                      languageProvider.translate("settings")), // ✅ Traducido
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ConfiguracionPage())),
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
                  icon: Icon(Icons.settings),
                  label: languageProvider.translate("settings")), // ✅ Traducido
            ],
          ),
        );
      },
    );
  }
}
