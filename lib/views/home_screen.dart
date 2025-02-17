import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart'; // AppBar personalizado
import '../widgets/animated_card.dart'; // Tarjetas animadas
import 'configuracion_page.dart';
import 'dedicatoria_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> titles = [
    "Cáncer en Gatos",
    "Cálculos En Los Riñones",
    "Carta 3"
  ];
  final List<String> descriptions = [
    "Información importante sobre carcinoma en gatos.",
    "Información detallada sobre cálculos renales en gatos.",
    "Contenido detallado de la carta 3."
  ];
  final List<String> assetImages = [
    'assets/images/1.webp',
    'assets/images/2.webp',
    'assets/images/3.webp',
  ];
  final List<Map<String, String>> allCards = [
    {
      "title": "Cáncer en Gatos",
      "description": "Carcinoma de células escamosas.",
      "image": 'assets/images/1.webp'
    },
    {
      "title": "Cálculos Renales",
      "description": "Cómo afectan a los gatos.",
      "image": 'assets/images/2.webp'
    },
    {
      "title": "Enfermedades Dentales",
      "description": "Placa y gingivitis felina.",
      "image": 'assets/images/3.webp'
    },
  ];

  List<Map<String, String>> filteredCards = [];

  @override
  void initState() {
    super.initState();
    filteredCards = List.from(allCards);
  }

  void filterCards(String query) {
    setState(() {
      filteredCards = query.isEmpty
          ? List.from(allCards)
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

    if (index == 0) {
      // Pantalla actual: Inicio
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DedicatoriaPage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ConfiguracionPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onSearch: filterCards, // ✅ Pasamos la función de búsqueda
      ), // AppBar personalizado
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
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Colors.blue),
              title: Text('Inicio'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite, color: Colors.red),
              title: Text('Dedicatoria'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DedicatoriaPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.grey),
              title: Text('Configuración'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ConfiguracionPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: filteredCards.length, // ✅ Usamos la lista filtrada
        itemBuilder: (context, index) {
          return AnimatedCard(
            title: filteredCards[index]
                ["title"]!, // ✅ Usamos los datos filtrados
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
            label: "Inicio",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Dedicatoria",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Configuración",
          ),
        ],
      ),
    );
  }
}
