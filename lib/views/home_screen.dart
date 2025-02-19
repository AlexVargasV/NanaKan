import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/animated_card.dart';
import 'configuracion_page.dart';
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
    setState(() {
      filteredCards = languageProvider.getTranslatedCards();
    });
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
    setState(() {
      _currentIndex = index;
    });

    if (index == 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DedicatoriaPage()));
    } else if (index == 2) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ConfiguracionPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

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
                languageProvider.translate("menu"), // ✅ Traducido dinámicamente
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Colors.blue),
              title: Text(languageProvider.translate("home")), // ✅ Traducido
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite, color: Colors.red),
              title: Text(
                  languageProvider.translate("dedicatoria")), // ✅ Traducido
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DedicatoriaPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.grey),
              title: Text(
                  languageProvider.translate("configuracion")), // ✅ Traducido
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ConfiguracionPage()));
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: filteredCards.length,
        itemBuilder: (context, index) {
          return AnimatedCard(
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
              label: languageProvider.translate("dedicatoria")), // ✅ Traducido
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label:
                  languageProvider.translate("configuracion")), // ✅ Traducido
        ],
      ),
    );
  }
}
