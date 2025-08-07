import 'package:flutter/material.dart';
import '../models/restaurant_model.dart';
import '../services/restaurant_service.dart';
import 'add_restaurant.dart';
import 'edit_restaurant.dart';
import 'manage_menus.dart';

class ManageRestaurantsScreen extends StatefulWidget {
  const ManageRestaurantsScreen({super.key});

  @override
  State<ManageRestaurantsScreen> createState() => _ManageRestaurantsScreenState();
}

class _ManageRestaurantsScreenState extends State<ManageRestaurantsScreen> {
  final RestaurantService _service = RestaurantService();
  List<Restaurant> _restaurants = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final data = await _service.fetchRestaurants();
    setState(() => _restaurants = data);
  }

  void _confirmDelete(Restaurant restaurant) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Restaurant?'),
        content: Text('Remove ${restaurant.name}?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Delete')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Restaurants')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddRestaurantScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: _restaurants.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _restaurants.length,
              itemBuilder: (context, index) {
                final r = _restaurants[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(r.name),
                    subtitle: Text(r.cuisine),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.restaurant_menu),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ManageMenusScreen(restaurant: r),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditRestaurantScreen(restaurant: r),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _confirmDelete(r),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
