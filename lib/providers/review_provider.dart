import 'package:flutter/material.dart';
import '../models/review.dart';
import '../services/database_service.dart';

class ReviewProvider with ChangeNotifier {
  List<Review> _reviews = [];
  bool _isLoading = false;

  List<Review> get reviews => _reviews;
  bool get isLoading => _isLoading;

  final DatabaseService _databaseService = DatabaseService();

  Future<void> loadReviews(int restaurantId, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      _reviews = await _databaseService.getReviews(restaurantId);
    } catch (e, stack) {
      debugPrint('Error loading reviews: $e');
      debugPrintStack(stackTrace: stack);
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        const SnackBar(content: Text('Failed to load reviews')),
      );
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> addReview(Review review, BuildContext context) async {
    try {
      await _databaseService.addReview(review);
      // Reload reviews to get the updated list
      await loadReviews(review.restaurantId, context);
      return true;
    } catch (e, stack) {
      debugPrint('Error adding review: $e');
      debugPrintStack(stackTrace: stack);
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        const SnackBar(content: Text('Failed to add review')),
      );
      return false;
    }
  }
}
