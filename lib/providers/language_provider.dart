import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  Map<String, dynamic> _localizedData = {};
  Locale _locale = Locale('es'); // 🔹 Idioma por defecto

  Locale get locale => _locale;

  Future<void> loadLanguage([Locale? locale]) async {
    try {
      // 🔹 Obtenemos idioma guardado en cache (SharedPreferences)
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? savedLangCode = prefs.getString('selected_language');

      // 🔹 Si hay idioma guardado, lo usamos; si no, usamos el argumento o 'es'
      String langCode = savedLangCode ?? locale?.languageCode ?? 'es';

      _locale = Locale(langCode);

      // 🔹 Cargamos el archivo JSON correspondiente
      String jsonString = await rootBundle
          .loadString('assets/lang/${_locale.languageCode}.json');
      Map<String, dynamic> jsonMap = json.decode(jsonString);

      _localizedData =
          jsonMap.map((key, value) => MapEntry(key, value.toString()));
      notifyListeners();
    } catch (e) {
      print("Error al cargar el idioma: $e");
    }
  }

  /// 🔹 Método para obtener la traducción de una clave
  String translate(String key) {
    return _localizedData[key] ?? key;
  }

  /// 🔹 Obtener lista traducida de secciones de Carcinoma
  List<Map<String, String>> getTranslatedCarcinomaSections() {
    return [
      {
        "title": translate("carcinoma_que_es"),
        "content": translate("carcinoma_que_es_desc"),
        "gif": "assets/images/cancer.gif",
        "image": "assets/images/parra1.jpg"
      },
      {
        "title": translate("factores_riesgo"),
        "content": translate("factores_riesgo_desc"),
        "gif": "assets/images/sun.gif",
        "image": "assets/images/pa2.jpg"
      },
      {
        "title": translate("zonas_afectadas"),
        "content": translate("zonas_afectadas_desc"),
        "gif": "assets/images/atencion.gif",
        "image": "assets/images/pa3.jpg"
      },
      {
        "title": translate("tipos_cce"),
        "content": translate("tipos_cce_desc"),
        "gif": "assets/images/tipos.gif",
        "image": "assets/images/pa4.jpg"
      },
      {
        "title": translate("prevencion"),
        "content": translate("prevencion_desc"),
        "gif": "assets/images/guia.gif",
        "image": "assets/images/pa5.jpg"
      }
    ];
  }

  List<Map<String, String>> getTranslatedCalculosSections() {
    return [
      {
        "title": translate("calculos_que_son"),
        "content": translate("calculos_que_son_desc"),
        "gif": "assets/images/cancer.gif",
        "image": "assets/images/1cr.jpg"
      },
      {
        "title": translate("calculos_formacion"),
        "content": translate("calculos_formacion_desc"),
        "gif": "assets/images/sun.gif",
        "image": "assets/images/2cr.jpg"
      },
      {
        "title": translate("calculos_riesgo"),
        "content": translate("calculos_riesgo_desc"),
        "gif": "assets/images/atencion.gif",
        "image": "assets/images/3cr.jpg"
      },
      {
        "title": translate("calculos_signos"),
        "content": translate("calculos_signos_desc"),
        "gif": "assets/images/tipos.gif",
        "image": "assets/images/4cr.jpg"
      },
      {
        "title": translate("calculos_prevencion"),
        "content": translate("calculos_prevencion_desc"),
        "gif": "assets/images/guia.gif",
        "image": "assets/images/cr5.jpg"
      }
    ];
  }

  List<Map<String, String>> getTranslatedDentalesSections() {
    return [
      {
        "title": translate("dentales_que_son"),
        "content": translate("dentales_que_son_desc"),
        "gif": "assets/images/cancer.gif",
        "image": "assets/images/1ed.webp"
      },
      {
        "title": translate("dentales_periodontal"),
        "content": translate("dentales_periodontal_desc"),
        "gif": "assets/images/sun.gif",
        "image": "assets/images/2ed.webp"
      },
      {
        "title": translate("dentales_etapas"),
        "content": translate("dentales_etapas_desc"),
        "gif": "assets/images/atencion.gif",
        "image": "assets/images/3ed.webp"
      },
      {
        "title": translate("dentales_riesgo"),
        "content": translate("dentales_riesgo_desc"),
        "gif": "assets/images/tipos.gif",
        "image": "assets/images/4ed.webp"
      },
      {
        "title": translate("dentales_signos"),
        "content": translate("dentales_signos_desc"),
        "gif": "assets/images/guia.gif",
        "image": "assets/images/5ed.webp"
      },
      {
        "title": translate("dentales_prevencion"),
        "content": translate("dentales_prevencion_desc"),
        "gif": "assets/images/guia.gif",
        "image": "assets/images/6ed.webp"
      }
    ];
  }

  /// 🔹 Obtener lista traducida de tarjetas del HomeScreen
  List<Map<String, String>> getTranslatedCards() {
    return [
      {
        "id": "cancer",
        "title": translate("card_cancer"),
        "description": translate("card_cancer_desc"),
        "image": 'assets/images/1.webp'
      },
      {
        "id": "calculos",
        "title": translate("card_calculos"),
        "description": translate("card_calculos_desc"),
        "image": 'assets/images/2.webp'
      },
      {
        "id": "dentales",
        "title": translate("card_dentales"),
        "description": translate("card_dentales_desc"),
        "image": 'assets/images/3.webp'
      },
    ];
  }

  List<Map<String, String>> getNotificationMessages() {
    List<Map<String, String>> messages = [];
    int i = 1;
    while (true) {
      String titleKey = 'notification_${i}_title';
      String bodyKey = 'notification_${i}_body';
      if (_localizedData.containsKey(titleKey) &&
          _localizedData.containsKey(bodyKey)) {
        messages.add({
          'title': _localizedData[titleKey]!,
          'body': _localizedData[bodyKey]!,
        });
        i++;
      } else {
        break;
      }
    }
    return messages;
  }

  Future<void> changeLanguage(String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_language', languageCode);
    await loadLanguage(Locale(languageCode)); // Cargar idioma actualizado
  }
}
