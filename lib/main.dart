import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'providers/restaurant_provider.dart';
import 'providers/review_provider.dart';
import 'services/database_service.dart';
import 'screens/login_page.dart';
import 'screens/register_page.dart';
import 'screens/home_screen.dart';
import 'admin/admin_dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize database
  await DatabaseService().database;

  runApp(const DineHubApp());
}

class DineHubApp extends StatelessWidget {
  const DineHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RestaurantProvider()),
        ChangeNotifierProvider(create: (_) => ReviewProvider()),
      ],
      child: MaterialApp(
        title: 'DineHub',
        theme: ThemeData(
          primarySwatch: Colors.red,
          primaryColor: const Color(0xFFFF6B6B),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFFF6B6B),
            secondary: const Color(0xFF4ECDC4),
          ),
          fontFamily: 'Inter',
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFFF6B6B),
            foregroundColor: Colors.white,
            elevation: 0,
          ),
        ),
        home: const SplashScreen(),
        routes: {
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          '/home': (context) => const HomeScreen(),
          '/adminDashboard': (context) => const AdminDashboard(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
