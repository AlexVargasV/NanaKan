import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../widgets/image_zoom_widget.dart';
import 'package:flutter_animate/flutter_animate.dart';
//import 'package:lottie/lottie.dart';

class DentalesInfoPage extends StatefulWidget {
  @override
  _DentalesInfoPageState createState() => _DentalesInfoPageState();
}

class _DentalesInfoPageState extends State<DentalesInfoPage> {
  final List<Map<String, String>> sections = [
    {
      "title": "⚠️ ¿Qué son las enfermedades dentales en gatos?",
      "content":
          "Las enfermedades dentales son extremadamente comunes en gatos, pero muchas veces pasan desapercibidas hasta que el dolor o los problemas de salud son graves. La acumulación de placa y sarro puede provocar infecciones, pérdida de dientes y afectar órganos internos si no se trata a tiempo.",
      "gif": "assets/images/cancer.gif",
      "image": "assets/images/1ed.webp"
    },
    {
      "title": "¿Qué es la enfermedad periodontal?",
      "content":
          "Es una inflamación progresiva de las encías y estructuras de soporte del diente debido a la acumulación de placa y sarro. Si no se trata a tiempo, puede derivar en infecciones graves, pérdida de dientes e incluso afectar órganos como el corazón, riñones e hígado.",
      "gif": "assets/images/sun.gif",
      "image": "assets/images/2ed.webp"
    },
    {
      "title": "Etapas de la enfermedad periodontal",
      "content": "1️⃣ Gingivitis (Etapa 1 - Reversible): Inflamación de las encías sin pérdida ósea. Síntomas: Encías enrojecidas, mal aliento leve.\n\n"
          "2️⃣ Periodontitis Temprana (Etapa 2): Inflamación severa con inicio de destrucción del tejido de soporte. Síntomas: Mal aliento moderado, sangrado de encías al comer o al frotar la boca.\n\n"
          "3️⃣ Periodontitis Moderada (Etapa 3): Pérdida ósea evidente y formación de bolsas periodontales. Síntomas: Dolor, babeo, pérdida de dientes, dificultad para comer.\n\n"
          "4️⃣ Periodontitis Severa (Etapa 4 - Irreversible): Infección profunda con pérdida masiva de hueso y dientes. Puede generar abscesos y bacterias en el torrente sanguíneo.",
      "gif": "assets/images/atencion.gif",
      "image": "assets/images/3ed.webp"
    },
    {
      "title": "Factores de riesgo",
      "content": "• Falta de higiene dental: Principal causa de la acumulación de placa.\n"
          "• Dieta inadecuada: Alimentación exclusivamente blanda favorece el sarro.\n"
          "• Predisposición genética: Razas como el Persa y Siamés son más propensas.\n"
          "• Edad avanzada: Gatos mayores de 5 años tienen mayor riesgo.\n"
          "• Sistema inmunológico debilitado: Enfermedades como FeLV y FIV predisponen a infecciones bucales.",
      "gif": "assets/images/tipos.gif",
      "image": "assets/images/4ed.webp"
    },
    {
      "title": "Síntomas de alerta en gatos",
      "content": "🚨 Señales de advertencia:\n\n"
          "📌 Mal aliento (halitosis).\n"
          "📌 Encías rojas, inflamadas o sangrantes.\n"
          "📌 Dificultad para comer o preferencia por comida blanda.\n"
          "📌 Babeo excesivo (a veces con sangre).\n"
          "📌 Frotarse la cara o sacudir la cabeza con frecuencia.\n"
          "📌 Dientes flojos o ausentes.\n"
          "📌 Pérdida de peso por reducción en la ingesta de alimento.\n\n"
          "🔴 Importante: Los gatos ocultan el dolor, por lo que los dueños no suelen notar el problema hasta que está avanzado.",
      "gif": "assets/images/guia.gif",
      "image": "assets/images/5ed.webp"
    },
    {
      "title": "Prevención según la etapa de vida del gato",
      "content": "🐱 Gatos jóvenes (hasta 1 año):\n"
          "• Introducir el cepillado dental de forma gradual.\n"
          "• Dieta equilibrada con croquetas dentales.\n"
          "• Revisión veterinaria anual para control dental.\n\n"
          "🐈 Gatos adultos (1-7 años):\n"
          "• Cepillado dental regular (mínimo 3 veces por semana).\n"
          "• Alimentación adecuada con croquetas dentales y snacks específicos.\n"
          "• Revisiones veterinarias cada 6-12 meses.\n\n"
          "🐈‍⬛ Gatos mayores (>7 años):\n"
          "• Limpieza dental profesional cuando sea necesario.\n"
          "• Aditivos en el agua o geles dentales como apoyo.\n"
          "• Controles de salud frecuentes para detectar problemas bucales.",
      "gif": "assets/images/guia.gif",
      "image": "assets/images/6ed.webp"
    }
  ];

  final List<bool> visibilityStatus = [true, false, false, false, false, false];
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
