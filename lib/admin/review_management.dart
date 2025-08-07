import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/restaurant.dart';
import '../services/database_service.dart';
import '../providers/review_provider.dart';

class ReviewManagementScreen extends StatefulWidget {
  final int? restaurantId;
  const ReviewManagementScreen({super.key, this.restaurantId});

  @override
  State<ReviewManagementScreen> createState() => _ReviewManagementScreenState();
}

class _ReviewManagementScreenState extends State<ReviewManagementScreen> {
  final DatabaseService _service = DatabaseService();
  late final ReviewProvider _reviewProvider;
  List<Restaurant> _restaurants = [];
  int? _selectedRestaurantId;

  @override
  void initState() {
    super.initState();
    _reviewProvider = ReviewProvider();
    _loadRestaurants();
  }

  Future<void> _loadRestaurants() async {
    final data = await _service.getRestaurants();
    setState(() {
      _restaurants = data;
      _selectedRestaurantId =
          widget.restaurantId ?? (data.isNotEmpty ? data.first.id : null);
    });
    if (_selectedRestaurantId != null) {
      await _reviewProvider.loadReviews(_selectedRestaurantId!, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ReviewProvider>.value(
      value: _reviewProvider,
      child: Scaffold(
        appBar: AppBar(title: const Text('Review Management')),
        body: Consumer<ReviewProvider>(
          builder: (context, provider, _) {
            if (_selectedRestaurantId == null) {
              return const Center(child: Text('No restaurants available'));
            }
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<int>(
                    value: _selectedRestaurantId,
                    items: _restaurants
                        .map(
                          (r) => DropdownMenuItem<int>(
                            value: r.id,
                            child: Text(r.name),
                          ),
                        )
                        .toList(),
                    onChanged: (id) {
                      if (id == null) return;
                      setState(() => _selectedRestaurantId = id);
                      provider.loadReviews(id, context);
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: provider.reviews.length,
                    itemBuilder: (context, index) {
                      final review = provider.reviews[index];
                      return Card(
                        margin: const EdgeInsets.all(8),
                        child: ListTile(
                          title: Text(review.userName),
                          subtitle: Text(review.comment),
                          leading: CircleAvatar(
                            child: Text(review.rating.toString()),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon:
                                    const Icon(Icons.check, color: Colors.green),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.close, color: Colors.red),
                                onPressed: () {
                                  provider.deleteReview(
                                      review.id!, review.restaurantId, context);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

