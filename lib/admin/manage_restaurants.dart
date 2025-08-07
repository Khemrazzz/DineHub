import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/restaurant.dart';
import '../providers/restaurant_provider.dart';
import 'add_restaurant.dart';
import 'edit_restaurant.dart';
import 'manage_menus.dart';

class ManageRestaurantsScreen extends StatefulWidget {
  const ManageRestaurantsScreen({super.key});

  @override
  State<ManageRestaurantsScreen> createState() => _ManageRestaurantsScreenState();
}

class _ManageRestaurantsScreenState extends State<ManageRestaurantsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _load();
    });
  }

  Future<void> _load() async {
    await Provider.of<RestaurantProvider>(context, listen: false)
        .loadRestaurants(context);
  }

  void _confirmDelete(Restaurant restaurant) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Restaurant?'),
        content: Text('Remove ${restaurant.name}?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await Provider.of<RestaurantProvider>(context, listen: false)
                  .deleteRestaurant(restaurant.id!, context);
              await _load();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Restaurants')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddRestaurantScreen()),
          );
          await _load();
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<RestaurantProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          final restaurants = provider.restaurants;
          if (restaurants.isEmpty) {
            return const Center(child: Text('No restaurants'));
          }
          return ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              final r = restaurants[index];
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
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditRestaurantScreen(restaurant: r),
                            ),
                          );
                          await _load();
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
          );
        },
      ),
    );
  }
}
