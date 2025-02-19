import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Map<String, dynamic> _localizedData = {};
  Locale _locale = Locale('es'); // 🔹 Idioma por defecto

  Locale get locale => _locale;

  Future<void> loadLanguage(Locale locale) async {
    try {
      String jsonString = await rootBundle.loadString(
          'assets/lang/${locale.languageCode}.json'); // 🔹 Cargar archivo de idioma
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      _localizedData =
          jsonMap.map((key, value) => MapEntry(key, value.toString()));
      _locale = locale;
      notifyListeners(); // 🔹 Notificar cambios a la UI
    } catch (e) {
      print("Error al cargar el idioma: $e");
    }
  }

  /// 🔹 Método para obtener la traducción de una clave
  String translate(String key) {
    return _localizedData[key] ?? key;
  }

  /// 🔹 Obtener lista traducida de tarjetas del HomeScreen
  List<Map<String, String>> getTranslatedCards() {
    return [
      {
        "title": translate("card_cancer"),
        "description": translate("card_cancer_desc"),
        "image": 'assets/images/1.webp'
      },
      {
        "title": translate("card_calculos"),
        "description": translate("card_calculos_desc"),
        "image": 'assets/images/2.webp'
      },
      {
        "title": translate("card_dentales"),
        "description": translate("card_dentales_desc"),
        "image": 'assets/images/3.webp'
      },
    ];
  }

  /// 🔹 Cambiar idioma y recargar datos correctamente
  Future<void> changeLanguage(String languageCode) async {
    if (_locale.languageCode != languageCode) {
      await loadLanguage(Locale(languageCode));
      notifyListeners(); // 🔹 Asegura que la UI se actualice con las nuevas traducciones
    }
  }
}
