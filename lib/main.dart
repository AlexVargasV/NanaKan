import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nanakan/views/splash_screen.dart';
import 'providers/language_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LanguageProvider()..loadLanguage(Locale('es')),
      child: ModernApp(),
    ),
  );
}

class ModernApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: languageProvider.locale,
      home: SplashScreen(),
    );
  }
}
