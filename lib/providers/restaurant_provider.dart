import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../models/menu_item.dart';
import '../services/database_service.dart';

class RestaurantProvider with ChangeNotifier {
  List<Restaurant> _restaurants = [];
  List<Restaurant> _filteredRestaurants = [];
  List<MenuItem> _currentMenuItems = [];
  bool _isLoading = false;
  String _searchQuery = '';

  List<Restaurant> get restaurants => _filteredRestaurants;
  List<MenuItem> get currentMenuItems => _currentMenuItems;
  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;

  final DatabaseService _databaseService = DatabaseService();

  Future<void> loadRestaurants(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      _restaurants = await _databaseService.getRestaurants();
      _filteredRestaurants = _restaurants;
    } catch (e, stack) {
      debugPrint('Error loading restaurants: $e');
      debugPrintStack(stackTrace: stack);
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        const SnackBar(content: Text('Failed to load restaurants')),
      );
    }

    _isLoading = false;
    notifyListeners();
  }

  void searchRestaurants(String query) {
    _searchQuery = query;
    if (query.isEmpty) {
      _filteredRestaurants = _restaurants;
    } else {
      _filteredRestaurants = _restaurants
          .where((restaurant) =>
              restaurant.name.toLowerCase().contains(query.toLowerCase()) ||
              restaurant.cuisine.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  Future<void> loadMenuItems(int restaurantId, BuildContext context) async {
    try {
      _currentMenuItems = await _databaseService.getMenuItems(restaurantId);
      notifyListeners();
    } catch (e, stack) {
      debugPrint('Error loading menu items: $e');
      debugPrintStack(stackTrace: stack);
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        const SnackBar(content: Text('Failed to load menu items')),
      );
    }
  }

  Future<Restaurant?> getRestaurant(int id, BuildContext context) async {
    try {
      return await _databaseService.getRestaurant(id);
    } catch (e, stack) {
      debugPrint('Error getting restaurant: $e');
      debugPrintStack(stackTrace: stack);
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        const SnackBar(content: Text('Failed to load restaurant')),
      );
      return null;
    }
  }

  Future<void> addRestaurant(Restaurant restaurant, BuildContext context) async {
    try {
      int id = await _databaseService.insertRestaurant(restaurant);
      if (id > 0) {
        final newRestaurant = Restaurant(
          id: id,
          name: restaurant.name,
          address: restaurant.address,
          cuisine: restaurant.cuisine,
          latitude: restaurant.latitude,
          longitude: restaurant.longitude,
          imageUrl: restaurant.imageUrl,
          description: restaurant.description,
          rating: restaurant.rating,
          reviewCount: restaurant.reviewCount,
        );
        _restaurants.add(newRestaurant);
        searchRestaurants(_searchQuery);
      }
    } catch (e, stack) {
      debugPrint('Error adding restaurant: $e');
      debugPrintStack(stackTrace: stack);
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        const SnackBar(content: Text('Failed to add restaurant')),
      );
    }
  }

  Future<void> updateRestaurant(Restaurant restaurant, BuildContext context) async {
    try {
      await _databaseService.updateRestaurant(restaurant);
      int index = _restaurants.indexWhere((r) => r.id == restaurant.id);
      if (index != -1) {
        _restaurants[index] = restaurant;
        searchRestaurants(_searchQuery);
      }
    } catch (e, stack) {
      debugPrint('Error updating restaurant: $e');
      debugPrintStack(stackTrace: stack);
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        const SnackBar(content: Text('Failed to update restaurant')),
      );
    }
  }

  Future<void> deleteRestaurant(int id, BuildContext context) async {
    try {
      await _databaseService.deleteRestaurant(id);
      _restaurants.removeWhere((r) => r.id == id);
      searchRestaurants(_searchQuery);
    } catch (e, stack) {
      debugPrint('Error deleting restaurant: $e');
      debugPrintStack(stackTrace: stack);
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        const SnackBar(content: Text('Failed to delete restaurant')),
      );
    }
  }

  void updateRestaurantRating(int restaurantId, double newRating, int newReviewCount) {
    int index = _restaurants.indexWhere((r) => r.id == restaurantId);
    if (index != -1) {
      _restaurants[index].rating = newRating;
      _restaurants[index].reviewCount = newReviewCount;
      
      int filteredIndex = _filteredRestaurants.indexWhere((r) => r.id == restaurantId);
      if (filteredIndex != -1) {
        _filteredRestaurants[filteredIndex].rating = newRating;
        _filteredRestaurants[filteredIndex].reviewCount = newReviewCount;
      }
      notifyListeners();
    }
  }
}
