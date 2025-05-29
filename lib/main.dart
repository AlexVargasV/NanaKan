import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';
import 'views/splash_screen.dart';
import 'providers/language_provider.dart';
import 'providers/theme_provider.dart';
import 'package:nanakan/providers/notification_service.dart'; //
import 'package:timezone/data/latest_all.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initializeNotifications() async {
  // Configuración Android
  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  // Configuración iOS (Darwin)
  final DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  // Inicialización general
  final InitializationSettings initSettings = InitializationSettings(
    android: androidSettings,
    iOS: iosSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(initSettings);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  await initializeNotifications();
  final languageProvider = LanguageProvider();
  await languageProvider.loadLanguage(); // ✅ Cargar idioma antes de runApp
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LanguageProvider()..loadLanguage(),
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 🔥 Aquí se asegura de que languageProvider ya esté inicializado
      scheduleDailyNotification(
          languageProvider); // ✅ Notificación diaria a las 12:00 PM
    });
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: languageProvider.locale,
      themeMode: themeProvider.themeMode,
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
