import 'package:flutter/material.dart';
import 'views/splash_screen.dart';

void main() {
  runApp(ModernApp());
}

class ModernApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
