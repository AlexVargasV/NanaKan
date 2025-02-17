import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../widgets/image_zoom_widget.dart';
import 'package:flutter_animate/flutter_animate.dart';
//import 'package:lottie/lottie.dart';

class CalculosInfoPage extends StatefulWidget {
  @override
  _CalculosInfoPageState createState() => _CalculosInfoPageState();
}

class _CalculosInfoPageState extends State<CalculosInfoPage> {
  final List<Map<String, String>> sections = [
    {
      "title": "\u26A0\ufe0f ¿Qué son los cálculos renales en gatos?",
      "content": "Los cálculos renales, o piedras en los riñones, son acumulaciones sólidas de minerales que pueden formarse en los riñones o las vías urinarias. En los gatos, el 98% de estos cálculos están compuestos por oxalato de calcio.\n\n"
          "Tipos de cálculos de oxalato de calcio:\n\n"
          "• Monohidrato: Relacionado con exceso de oxalato en la orina (hiperoxaluria).\n"
          "• Dihidrato: Asociado con niveles altos de calcio en la orina (hipercalciuria).\n\n"
          "En gatos, casi todos los cálculos son del tipo monohidrato, lo que sugiere que el exceso de oxalato es la principal causa.",
      "gif": "assets/images/cancer.gif",
      "image": "assets/images/1cr.jpg"
    },
    {
      "title": "¿Por qué se forman los cálculos renales?",
      "content": "Causas principales:\n\n"
          "• Dieta: Consumo exclusivo de comida seca o alimentos que acidifican mucho la orina.\n"
          "• Factores metabólicos: Niveles altos de calcio u oxalato.\n"
          "• Genética: Algunas razas tienen mayor predisposición.\n"
          "• Infecciones urinarias.",
      "gif": "assets/images/sun.gif",
      "image": "assets/images/2cr.jpg"
    },
    {
      "title": "Factores de riesgo",
      "content": "• Dieta seca exclusiva: Reduce la ingesta de agua y concentra la orina.\n"
          "• Ser macho castrado: Mayor riesgo de obstrucciones por su uretra estrecha.\n"
          "• Razas predispuestas: Persas, Himalayos, Birmanos, Ragdoll, American Shorthair y Scottish Fold.\n"
          "• Problemas metabólicos: Hipercalcemia e hiperoxaluria.",
      "gif": "assets/images/atencion.gif",
      "image": "assets/images/3cr.jpg"
    },
    {
      "title": "¿Cómo saber si mi gato tiene cálculos?",
      "content": "Señales de alerta:\n\n"
          "• Dificultad o dolor al orinar.\n"
          "• Orina con sangre.\n"
          "• Lamido excesivo del área genital.\n"
          "• Pérdida de apetito o decaimiento.\n"
          "• Inflamación abdominal.\n\n"
          "Importante: Si notas estos signos, acude de inmediato al veterinario.",
      "gif": "assets/images/tipos.gif",
      "image": "assets/images/4cr.jpg"
    },
    {
      "title": "Prevención según la etapa de vida del gato",
      "content": "Gatos cachorros (hasta 1 año):\n"
          "• Dieta adecuada: Alimentos húmedos ricos en nutrientes.\n"
          "• Hidrátalo: Agua fresca constantemente.\n"
          "• Chequeos regulares: Detecta problemas tempranamente.\n\n"
          "Gatos adultos (1-7 años):\n"
          "• Combina comida seca y húmeda: Fomenta la hidratación.\n"
          "• Alimentos para gatos castrados: Controlan el peso y reducen riesgos urinarios.\n\n"
          "Gatos mayores (>7 años):\n"
          "• Dieta para riñones: Reduce la carga renal con alimentos específicos.\n"
          "• Control de salud: Chequeos frecuentes para vigilar función renal y urinaria.",
      "gif": "assets/images/guia.gif",
      "image": "assets/images/cr5.jpg"
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
                  'assets/images/cr1c.jpg',
                  'assets/images/cr2c.jpeg',
                  'assets/images/cr3c.jpg',
                  'assets/images/cr4c.webp',
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
