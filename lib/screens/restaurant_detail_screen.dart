import 'package:flutter/material.dart';
import '../models/restaurant_model.dart';
import '../widgets/bottom_nav.dart';
import 'map_view_screen.dart';
import 'add_review_dialog.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantDetailScreen({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(restaurant.name)),
      bottomNavigationBar: const DineHubNavBar(currentIndex: 0),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            restaurant.name,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(restaurant.address),
          const SizedBox(height: 8),
          Text('Rating: ${restaurant.rating.toStringAsFixed(1)}'),
          const SizedBox(height: 16),
          const Text('Menu', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ...restaurant.menu.map((item) => ListTile(
                title: Text(item.name),
                trailing: Text('\\${item.price.toStringAsFixed(2)}'),
              )),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AddReviewDialog(restaurant: restaurant),
              );
            },
            child: const Text('Add Review'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MapViewScreen(restaurant: restaurant),
                ),
              );
            },
            child: const Text('View on Map'),
          ),
        ],
      ),
    );
  }
}
