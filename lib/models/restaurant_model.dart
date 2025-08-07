import 'menu_model.dart';

class Restaurant {
  final String id;
  final String name;
  final String cuisine;
  final double rating;
  final String distance;
  final String address;
  final List<MenuItem> menu;

  Restaurant({
    required this.id,
    required this.name,
    required this.cuisine,
    required this.rating,
    required this.distance,
    required this.address,
    this.menu = const [],
  });
}
