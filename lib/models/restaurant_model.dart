import 'menu_model.dart';

class Restaurant {
  final String id;
  final String emoji;
  final String name;
  final String cuisine;
  final double rating;
  final String distance;
  final String address;
  final double latitude;
  final double longitude;
  final List<MenuItem> menu;

  Restaurant({
    required this.id,
    required this.emoji,
    required this.name,
    required this.cuisine,
    required this.rating,
    required this.distance,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.menu = const [],
  });
}
