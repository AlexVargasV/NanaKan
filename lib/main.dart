import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';
import 'views/splash_screen.dart';
import 'providers/language_provider.dart';
import 'providers/theme_provider.dart';
import 'package:nanakan/providers/notification_service.dart'; //

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

void startNotificationTimer(LanguageProvider langProvider) {
  Timer.periodic(Duration(minutes: 1), (_) {
    showRepeatedNotification(langProvider);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      startNotificationTimer(languageProvider);
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
