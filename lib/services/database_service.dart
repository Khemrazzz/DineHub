import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import '../models/restaurant.dart';
import '../models/menu_item.dart';
import '../models/review.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;

  DatabaseService._internal();

  factory DatabaseService() => _instance;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<Database?> _initDatabase() async {
    if (kIsWeb) {
      // sqflite is not supported on the web
      return null;
    }

    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      // Initialize FFI for desktop platforms
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'dinehub.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create restaurants table
    await db.execute('''
      CREATE TABLE restaurants(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        address TEXT NOT NULL,
        cuisine TEXT NOT NULL,
        latitude REAL NOT NULL,
        longitude REAL NOT NULL,
        imageUrl TEXT,
        description TEXT,
        rating REAL DEFAULT 0.0,
        reviewCount INTEGER DEFAULT 0
      )
    ''');

    // Create menu items table
    await db.execute('''
      CREATE TABLE menu_items(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        restaurantId INTEGER NOT NULL,
        name TEXT NOT NULL,
        description TEXT,
        price REAL NOT NULL,
        category TEXT DEFAULT 'Main',
        available INTEGER DEFAULT 1,
        FOREIGN KEY (restaurantId) REFERENCES restaurants (id)
      )
    ''');

    // Create reviews table
    await db.execute('''
      CREATE TABLE reviews(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        restaurantId INTEGER NOT NULL,
        userName TEXT NOT NULL,
        rating INTEGER NOT NULL,
        comment TEXT,
        createdAt TEXT NOT NULL,
        FOREIGN KEY (restaurantId) REFERENCES restaurants (id)
      )
    ''');

    // Insert sample data
    await _insertSampleData(db);
  }

  Future<void> _insertSampleData(Database db) async {
    // Sample restaurants
    List<Restaurant> sampleRestaurants = [
      Restaurant(
        name: 'Pizza Palace',
        address: '123 Main Street, Downtown',
        cuisine: 'Italian',
        latitude: -20.1609,
        longitude: 57.5012,
        description: 'Authentic Italian pizza with fresh ingredients',
        rating: 4.5,
        reviewCount: 127,
      ),
      Restaurant(
        name: 'Ramen Corner',
        address: '456 Elm Street, Chinatown',
        cuisine: 'Japanese',
        latitude: -20.1589,
        longitude: 57.4982,
        description: 'Traditional Japanese ramen and noodles',
        rating: 4.2,
        reviewCount: 89,
      ),
      Restaurant(
        name: 'Green Garden',
        address: '789 Oak Avenue, Green District',
        cuisine: 'Healthy',
        latitude: -20.1629,
        longitude: 57.5042,
        description: 'Fresh organic meals and healthy options',
        rating: 4.7,
        reviewCount: 156,
      ),
      Restaurant(
        name: 'Spice Route',
        address: '321 Cedar Road, Spice Quarter',
        cuisine: 'Indian',
        latitude: -20.1569,
        longitude: 57.5072,
        description: 'Authentic Indian spices and flavors',
        rating: 4.3,
        reviewCount: 203,
      ),
    ];

    for (Restaurant restaurant in sampleRestaurants) {
      await db.insert('restaurants', restaurant.toMap());
    }

    // Sample menu items
    List<MenuItem> sampleMenuItems = [
      // Pizza Palace menu
      MenuItem(restaurantId: 1, name: 'Margherita Pizza', description: 'Fresh tomato, mozzarella, basil', price: 12.99, category: 'Pizza'),
      MenuItem(restaurantId: 1, name: 'Pepperoni Pizza', description: 'Pepperoni, mozzarella, tomato sauce', price: 14.99, category: 'Pizza'),
      MenuItem(restaurantId: 1, name: 'Caesar Salad', description: 'Romaine lettuce, parmesan, croutons', price: 8.50, category: 'Salad'),
      
      // Ramen Corner menu
      MenuItem(restaurantId: 2, name: 'Shoyu Ramen', description: 'Soy-based broth with pork and vegetables', price: 11.99, category: 'Ramen'),
      MenuItem(restaurantId: 2, name: 'Miso Ramen', description: 'Miso-based broth with corn and egg', price: 12.99, category: 'Ramen'),
      MenuItem(restaurantId: 2, name: 'Gyoza', description: 'Pan-fried pork dumplings', price: 6.99, category: 'Appetizer'),
      
      // Green Garden menu
      MenuItem(restaurantId: 3, name: 'Quinoa Bowl', description: 'Quinoa, avocado, mixed vegetables', price: 13.50, category: 'Bowl'),
      MenuItem(restaurantId: 3, name: 'Green Smoothie', description: 'Spinach, banana, apple, almond milk', price: 5.99, category: 'Beverage'),
      MenuItem(restaurantId: 3, name: 'Buddha Bowl', description: 'Brown rice, tofu, vegetables, tahini', price: 14.50, category: 'Bowl'),
      
      // Spice Route menu
      MenuItem(restaurantId: 4, name: 'Chicken Tikka Masala', description: 'Chicken in creamy tomato sauce', price: 16.99, category: 'Curry'),
      MenuItem(restaurantId: 4, name: 'Biryani', description: 'Fragrant rice with spiced meat', price: 15.99, category: 'Rice'),
      MenuItem(restaurantId: 4, name: 'Naan', description: 'Traditional Indian bread', price: 3.99, category: 'Bread'),
    ];

    for (MenuItem menuItem in sampleMenuItems) {
      await db.insert('menu_items', menuItem.toMap());
    }

    // Sample reviews
    List<Review> sampleReviews = [
      Review(restaurantId: 1, userName: 'John Doe', rating: 9, comment: 'Amazing pizza! The crust was perfect.'),
      Review(restaurantId: 1, userName: 'Sarah Smith', rating: 8, comment: 'Great atmosphere and delicious food.'),
      Review(restaurantId: 2, userName: 'Mike Johnson', rating: 7, comment: 'Good ramen, authentic taste.'),
      Review(restaurantId: 3, userName: 'Emily Brown', rating: 10, comment: 'Love the healthy options here!'),
    ];

    for (Review review in sampleReviews) {
      await db.insert('reviews', review.toMap());
    }
  }

  // Restaurant CRUD operations
  Future<List<Restaurant>> getRestaurants() async {
    final db = await database;
    if (db == null) return [];
    final List<Map<String, dynamic>> maps = await db.query('restaurants');
    return List.generate(maps.length, (i) => Restaurant.fromMap(maps[i]));
  }

  Future<List<Restaurant>> searchRestaurants(String query) async {
    final db = await database;
    if (db == null) return [];
    final List<Map<String, dynamic>> maps = await db.query(
      'restaurants',
      where: 'name LIKE ? OR cuisine LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
    );
    return List.generate(maps.length, (i) => Restaurant.fromMap(maps[i]));
  }

  Future<Restaurant?> getRestaurant(int id) async {
    final db = await database;
    if (db == null) return null;
    final List<Map<String, dynamic>> maps = await db.query(
      'restaurants',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Restaurant.fromMap(maps.first);
    }
    return null;
  }

  Future<int> insertRestaurant(Restaurant restaurant) async {
    final db = await database;
    if (db == null) return 0;
    return await db.insert('restaurants', restaurant.toMap());
  }

  Future<void> updateRestaurant(Restaurant restaurant) async {
    final db = await database;
    if (db == null || restaurant.id == null) return;
    await db.update(
      'restaurants',
      restaurant.toMap(),
      where: 'id = ?',
      whereArgs: [restaurant.id],
    );
  }

  Future<void> deleteRestaurant(int id) async {
    final db = await database;
    if (db == null) return;
    await db.delete(
      'restaurants',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Menu items operations
  Future<List<MenuItem>> getMenuItems(int restaurantId) async {
    final db = await database;
    if (db == null) return [];
    final List<Map<String, dynamic>> maps = await db.query(
      'menu_items',
      where: 'restaurantId = ?',
      whereArgs: [restaurantId],
    );
    return List.generate(maps.length, (i) => MenuItem.fromMap(maps[i]));
  }

  // Review operations
  Future<List<Review>> getReviews(int restaurantId) async {
    final db = await database;
    if (db == null) return [];
    final List<Map<String, dynamic>> maps = await db.query(
      'reviews',
      where: 'restaurantId = ?',
      whereArgs: [restaurantId],
      orderBy: 'createdAt DESC',
    );
    return List.generate(maps.length, (i) => Review.fromMap(maps[i]));
  }

  Future<int> addReview(Review review) async {
    final db = await database;
    if (db == null) return 0;
    int reviewId = await db.insert('reviews', review.toMap());

    // Update restaurant rating
    await _updateRestaurantRating(review.restaurantId);

    return reviewId;
  }

  Future<void> deleteReview(int id) async {
    final db = await database;
    if (db == null) return;

    // Get the restaurant ID before deleting the review
    final result = await db.query(
      'reviews',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) return;
    final int restaurantId = result.first['restaurantId'] as int;

    await db.delete(
      'reviews',
      where: 'id = ?',
      whereArgs: [id],
    );

    await _updateRestaurantRating(restaurantId);
  }

  Future<void> _updateRestaurantRating(int restaurantId) async {
    final db = await database;
    if (db == null) return;
    final List<Map<String, dynamic>> reviews = await db.rawQuery('''
      SELECT AVG(rating) as avgRating, COUNT(*) as reviewCount
      FROM reviews
      WHERE restaurantId = ?
    ''', [restaurantId]);

    if (reviews.isNotEmpty) {
      double avgRating = reviews[0]['avgRating'] ?? 0.0;
      int reviewCount = reviews[0]['reviewCount'] ?? 0;

      await db.update(
        'restaurants',
        {'rating': avgRating, 'reviewCount': reviewCount},
        where: 'id = ?',
        whereArgs: [restaurantId],
      );
    }
  }
}
