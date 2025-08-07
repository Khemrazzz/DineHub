import 'package:flutter/material.dart';
import '../models/restaurant_model.dart';
import 'map_view_screen.dart';
import 'add_review_dialog.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantDetailScreen({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF6B6B),
        title: const Text('Restaurant Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: 120,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF6B6B), Color(0xFF4ECDC4)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              restaurant.emoji,
              style: const TextStyle(fontSize: 48),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            restaurant.name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3748),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '📍 ${restaurant.address}',
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF718096),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.star, color: Color(0xFFFEC057), size: 20),
              const SizedBox(width: 6),
              Text(
                '${restaurant.rating} (127 reviews)',
                style: const TextStyle(fontSize: 12, color: Color(0xFF718096)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Menu',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3748),
            ),
          ),
          const SizedBox(height: 8),
          ...restaurant.menu.map((item) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7FAFC),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item.name,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                    Text('\\$${item.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFF6B6B))),
                  ],
                ),
              )),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (_) => AddReviewDialog(restaurantName: restaurant.name),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6B6B),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Add Review'),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MapViewScreen(restaurant: restaurant),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4ECDC4),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('View on Map'),
          ),
        ],
      ),
    );
  }
}
