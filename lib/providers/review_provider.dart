import 'package:flutter/material.dart';
import '../models/review.dart';
import '../services/database_service.dart';

class ReviewProvider with ChangeNotifier {
  List<Review> _reviews = [];
  bool _isLoading = false;

  List<Review> get reviews => _reviews;
  bool get isLoading => _isLoading;

  final DatabaseService _databaseService = DatabaseService();

  Future<void> loadReviews(int restaurantId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _reviews = await _databaseService.getReviews(restaurantId);
    } catch (e) {
      debugPrint('Error loading reviews: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> addReview(Review review) async {
    try {
      await _databaseService.addReview(review);
      // Reload reviews to get the updated list
      await loadReviews(review.restaurantId);
      return true;
    } catch (e) {
      debugPrint('Error adding review: $e');
      return false;
    }
  }
}
