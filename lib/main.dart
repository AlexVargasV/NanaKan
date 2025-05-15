import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nanakan/views/splash_screen.dart';
import 'providers/language_provider.dart';
import 'providers/theme_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LanguageProvider()..loadLanguage(Locale('es')),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
      ],
      child: ModernApp(),
    ),
  );
}

class ModernApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: languageProvider.locale,
      themeMode: themeProvider.themeMode, // 👈 modo claro u oscuro dinámico
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.grey[850],
        cardColor: Colors.grey[900],
        textTheme: ThemeData.dark().textTheme.apply(bodyColor: Colors.white),
      ),
      home: SplashScreen(),
    );
  }
}
