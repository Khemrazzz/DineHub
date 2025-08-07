import 'package:flutter/material.dart';
import '../models/review_model.dart';

class ReviewTile extends StatelessWidget {
  final Review review;

  const ReviewTile({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(review.comment),
      subtitle: Text('Rating: ${review.rating}'),
    );
  }
}
