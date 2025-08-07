import '../models/menu_model.dart';
import '../models/restaurant_model.dart';

class RestaurantService {
  Future<List<Restaurant>> fetchRestaurants() async {
    // Simulated network delay
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      Restaurant(
        id: '1',
        name: 'Pizza Palace',
        cuisine: 'Italian',
        rating: 4.5,
        distance: '2.1km',
        address: '123 Main Street, Downtown',
        menu: [
          MenuItem(id: 'm1', name: 'Margherita Pizza', price: 12.99),
          MenuItem(id: 'm2', name: 'Pepperoni Pizza', price: 14.99),
          MenuItem(id: 'm3', name: 'Caesar Salad', price: 8.50, available: false),
        ],
      ),
      Restaurant(
        id: '2',
        name: 'Ramen Corner',
        cuisine: 'Japanese',
        rating: 4.2,
        distance: '1.8km',
        address: '456 Elm Street',
        menu: [
          MenuItem(id: 'm4', name: 'Shoyu Ramen', price: 10.99),
          MenuItem(id: 'm5', name: 'Miso Ramen', price: 11.99),
        ],
      ),
      Restaurant(
        id: '3',
        name: 'Green Garden',
        cuisine: 'Healthy',
        rating: 4.7,
        distance: '0.5km',
        address: '789 Oak Avenue',
        menu: [
          MenuItem(id: 'm6', name: 'Quinoa Salad', price: 9.99),
          MenuItem(id: 'm7', name: 'Veggie Bowl', price: 12.50),
        ],
      ),
    ];
  }
}
