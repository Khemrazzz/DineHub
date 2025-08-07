import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      bottomNavigationBar: const DineHubNavBar(currentIndex: 2),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('DineHub', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Discover Amazing Restaurants'),
            SizedBox(height: 16),
            Text('Features:'),
            Text('• Restaurant discovery'),
            Text('• Location-based search'),
            Text('• User reviews & ratings'),
          ],
        ),
      ),
    );
  }
}
