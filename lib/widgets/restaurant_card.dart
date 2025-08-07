import 'package:flutter/material.dart';
import '../models/restaurant_model.dart';
import '../screens/restaurant_detail_screen.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantCard({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(restaurant.name.substring(0, 1)),
        ),
        title: Text(restaurant.name),
        subtitle: Row(
          children: [
            Text('${restaurant.rating.toStringAsFixed(1)}★'),
            const SizedBox(width: 8),
            Text(restaurant.cuisine),
            const SizedBox(width: 8),
            Text(restaurant.distance),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => RestaurantDetailScreen(restaurant: restaurant),
            ),
          );
        },
      ),
    );
  }
}
