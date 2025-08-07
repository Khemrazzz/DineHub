import 'package:flutter/material.dart';
import '../models/restaurant_model.dart';
import '../widgets/bottom_nav.dart';

class MapViewScreen extends StatelessWidget {
  final Restaurant? restaurant;
  const MapViewScreen({super.key, this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(restaurant != null ? restaurant!.name : 'Map View')),
      bottomNavigationBar: const DineHubNavBar(currentIndex: 1),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.map, size: 100, color: Colors.grey),
            const SizedBox(height: 16),
            Text(restaurant?.address ?? 'Map placeholder'),
          ],
        ),
      ),
    );
  }
}
