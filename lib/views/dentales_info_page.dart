import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../widgets/image_zoom_widget.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/language_provider.dart';
import 'package:provider/provider.dart';
//import 'package:lottie/lottie.dart';

class DentalesInfoPage extends StatefulWidget {
  @override
  _DentalesInfoPageState createState() => _DentalesInfoPageState();
}

class _DentalesInfoPageState extends State<DentalesInfoPage> {
  late List<Map<String, String>> sections;
  late List<bool> visibilityStatus;
  bool showCarousel = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final languageProvider = Provider.of<LanguageProvider>(context);
    sections = languageProvider.getTranslatedDentalesSections();
    // 🔹 Sincronizar el array de visibilidad con la cantidad de secciones
    visibilityStatus = List.generate(sections.length, (_) => false);
    visibilityStatus[0] = true; // La primera carta se muestra por defecto
  }

  void _showWarningDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey.shade300, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.orangeAccent,
                  size: 50,
                ),
                SizedBox(height: 16),
                Text(
                  Provider.of<LanguageProvider>(context).translate("warning"),
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  Provider.of<LanguageProvider>(context)
                      .translate("graphic_warning"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        Provider.of<LanguageProvider>(context)
                            .translate("btn_cancel"),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          showCarousel = true;
                        });
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        Provider.of<LanguageProvider>(context)
                            .translate("btn_acept"),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool _isElementVisible(BuildContext context, int index) {
    final RenderObject? renderObject = context.findRenderObject();
    if (renderObject is RenderBox) {
      final position = renderObject.localToGlobal(Offset.zero);
      final screenHeight = MediaQuery.of(context).size.height;
      return position.dy < screenHeight * 0.9; // Mayor tolerancia para mostrar
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // 🔹 Aplicamos el mismo AppBar con gradiente
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0), // Ajuste de altura
        child: Container(
          decoration: BoxDecoration(
            gradient: isDark
                ? LinearGradient(
                    colors: [Colors.grey.shade900, Colors.grey.shade800],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : LinearGradient(
                    colors: [Colors.blue.shade300, Colors.purple.shade300],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Botón de retroceso con diseño redondeado
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                  // Título centrado
                  Text(
                    languageProvider.translate("card_dentales"),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                  // Espacio para balancear la UI (sin botón de búsqueda aquí)
                  SizedBox(width: 40),
                ],
              ),
            ),
          ),
        ),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollUpdateNotification) {
            for (int i = 0; i < sections.length; i++) {
              if (!visibilityStatus[i] && _isElementVisible(context, i)) {
                setState(() {
                  visibilityStatus[i] = true;
                });
                break;
              }
            }
          }
          return true;
        },
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            ...sections.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, String> section = entry.value;

              return AnimatedOpacity(
                opacity: visibilityStatus[index] ? 1.0 : 0.0,
                duration: Duration(milliseconds: 800),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          section["title"]!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          section["content"]!,
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[700]),
                        ),
                        if (section["image"] != null) SizedBox(height: 12),
                        if (section["image"] != null)
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ImageZoomWidget(
                                    imagePath: section["image"]!,
                                  ),
                                ),
                              );
                            },
                            child: Stack(
                              children: [
                                Hero(
                                  tag: section["image"]!,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.asset(
                                      section["image"]!,
                                      height: 200,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 12,
                                  right: 12,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.5),
                                      shape: BoxShape.circle,
                                    ),
                                    padding: const EdgeInsets.all(8),
                                    child: Icon(Icons.zoom_in,
                                        color: Colors.white, size: 24),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
            if (showCarousel)
              CarouselSlider(
                options: CarouselOptions(
                  height: 200,
                  autoPlay: true,
                ),
                items: [
                  'assets/images/ed1c.jpg',
                  'assets/images/ed2c.jpg',
                  'assets/images/ed3c.jpg',
                  'assets/images/ed4c.webp',
                ].map((image) {
                  return Image.asset(image);
                }).toList(),
              )
            else
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 20),
                    backgroundColor: const Color(0xFFFF9800), // Color de fondo
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30), // Bordes redondeados
                    ),
                    elevation: 5,
                  ),
                  onPressed: _showWarningDialog,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.white, // Color del ícono
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          Provider.of<LanguageProvider>(context)
                              .translate("carrousel_message"),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
