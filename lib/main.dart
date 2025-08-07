import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const DineHubApp());
}

class DineHubApp extends StatelessWidget {
  const DineHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DineHub',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const SplashScreen(),
    );
  }
}
