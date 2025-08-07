import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/map_view_screen.dart';
import '../screens/about_page.dart';

class DineHubNavBar extends StatelessWidget {
  final int currentIndex;
  const DineHubNavBar({super.key, required this.currentIndex});

  void _navigate(BuildContext context, int index) {
    if (index == currentIndex) return;
    Widget destination;
    switch (index) {
      case 0:
        destination = const HomeScreen();
        break;
      case 1:
        destination = const MapViewScreen();
        break;
        default:
          destination = const AboutPage();
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => destination),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (i) => _navigate(context, i),
      selectedItemColor: const Color(0xFFFF6B6B),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
        BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About'),
      ],
    );
  }
}
