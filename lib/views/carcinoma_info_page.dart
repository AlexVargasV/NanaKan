import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/image_zoom_widget.dart';

class CarcinomaInfoPage extends StatefulWidget {
  @override
  _CarcinomaInfoPageState createState() => _CarcinomaInfoPageState();
}

class _CarcinomaInfoPageState extends State<CarcinomaInfoPage> {
  final List<Map<String, String>> sections = [
    {
      "title":
          "\u26A0\ufe0f ¿Qué es el Carcinoma de Células Escamosas en Gatos?",
      "content":
          "El carcinoma de células escamosas (CCE) es un tipo de tumor agresivo en gatos, que a pesar de los tratamientos disponibles, tiene un pronóstico grave debido a que generalmente no se detecta hasta que está en una etapa avanzada. Esta forma de cáncer afecta principalmente a gatos mayores y es una de las principales causas de tumores en la piel, nariz y boca de los felinos.",
      "gif": "assets/images/cancer.gif",
      "image": "assets/images/parra1.jpg"
    },
    {
      "title": "Factores de Riesgo",
      "content":
          "\u2605 Exposición al sol: La radiación ultravioleta es uno de los principales factores que pueden causar este tipo de cáncer.\n\n\u2605 Falta de pigmentación: Los gatos con piel blanca o áreas sin pigmento son más vulnerables.\n\n\u2605 Escaso pelaje: Los gatos con poco pelo están más expuestos al daño solar en las zonas descubiertas.\n\n\u2605 Virus del papiloma: La infección por este virus puede aumentar el riesgo.\n\n\u2605 Sistema inmunológico débil: Una inmunosupresión o enfermedades crónicas de la piel pueden hacer que el gato sea más susceptible.",
      "gif": "assets/images/sun.gif",
      "image": "assets/images/pa2.jpg"
    },
    {
      "title": "\u2022 Zonas Afectadas",
      "content":
          "\u2605 Orejas: Los pabellones auriculares son las áreas más afectadas, representando el 72% de los casos.\n\n\u2605 Alrededor de los ojos: Esta zona es vulnerable y constituye el 22% de los casos.\n\n\u2605 Hocico: El dorso del hocico también puede verse afectado, aunque menos frecuentemente (6% de los casos).",
      "gif": "assets/images/atencion.gif",
      "image": "assets/images/pa3.jpg"
    },
    {
      "title": "\u2728 Tipos de CCE",
      "content":
          "\u2605 CCE Oral: Este tipo de carcinoma afecta la boca del gato, dificultando su alimentación y causando molestias visibles.\n\n\u2605 CCE Ocular: Afecta los ojos del gato, pudiendo provocar inflamación, irritación o cambios en su visión.\n\n\u2605 **CCE Cutáneo (CCSC): Este carcinoma se desarrolla en la piel, especialmente en áreas con poca cobertura de pelo, como orejas, nariz y alrededor de los ojos.",
      "gif": "assets/images/tipos.gif",
      "image": "assets/images/pa4.jpg"
    },
    {
      "title": "\u2714\ufe0f Prevención y Detección Temprana",
      "content":
          "Proteger a tu gato de la exposición prolongada al sol es una de las mejores formas de prevenir estos tumores, especialmente en zonas sensibles como orejas y nariz. Además, llevarlo regularmente al veterinario permite detectar posibles anomalías a tiempo, aumentando las posibilidades de un tratamiento exitoso.",
      "gif": "assets/images/guia.gif",
      "image": "assets/images/pa5.jpg"
    }
  ];

  final List<bool> visibilityStatus = [true, false, false, false, false];
  bool showCarousel = false;

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
                  "Advertencia",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Las imágenes a continuación contienen contenido gráfico sensible. ¿Desea continuar?",
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
                        "Cancelar",
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
                        "Aceptar",
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
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final position = renderBox.localToGlobal(Offset.zero);
      return position.dy < MediaQuery.of(context).size.height * 0.8;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🔹 Aplicamos el mismo AppBar con gradiente
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0), // Ajuste de altura
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
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
                    "Carcinoma en Gatos",
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
                            color: Colors.black87,
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
                              // Abrir una nueva pantalla con zoom habilitado
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ImageZoomWidget(
                                    imagePath: section["image"]!,
                                  ),
                                ),
                              );
                            },
                            child: Hero(
                              tag: section["image"]!,
                              child: Image.asset(
                                section["image"]!,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )
                                  // Efecto de pulso usando flutter_animate
                                  .animate(
                                      onPlay: (controller) => controller
                                          .repeat()) // Continuous repeat
                                  .scale(
                                    begin: Offset(1, 1),
                                    end: Offset(1.1, 1.1),
                                    duration: Duration(seconds: 1),
                                  )
                                  .then()
                                  .scale(
                                    begin: Offset(1.1, 1.1),
                                    end: Offset(1, 1),
                                    duration: Duration(seconds: 1),
                                  ),
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
                  'assets/images/ca1.jpg',
                  'assets/images/ca2.jpg',
                  'assets/images/ca3.jpeg',
                  'assets/images/ca4.jpg',
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
                          "Imágenes con la enfermedad en etapa avanzada",
                          style: TextStyle(
                            color: Colors.white, // Color del texto
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          overflow:
                              TextOverflow.ellipsis, // Recorta si es muy largo
                          maxLines: 2, // Limita a dos líneas
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
