import 'package:flutter/material.dart';

class AddReviewDialog extends StatefulWidget {
  final String restaurantName;

  const AddReviewDialog({super.key, required this.restaurantName});

  @override
  State<AddReviewDialog> createState() => _AddReviewDialogState();
}

class _AddReviewDialogState extends State<AddReviewDialog> {
  double _rating = 8;
  final TextEditingController _commentController = TextEditingController();

  void _submitReview() {
    final review = {
      'rating': _rating.toInt(),
      'comment': _commentController.text,
    };
    Navigator.pop(context, review);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 100),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.restaurantName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3748),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Rate your experience',
              style: TextStyle(fontSize: 12, color: Color(0xFF718096)),
            ),
            const SizedBox(height: 16),
            Text(
              '${_rating.toInt()}/10',
              style: const TextStyle(
                fontSize: 24,
                color: Color(0xFFFF6B6B),
                fontWeight: FontWeight.bold,
              ),
            ),
            Slider(
              value: _rating,
              min: 0,
              max: 10,
              divisions: 10,
              label: _rating.toInt().toString(),
              onChanged: (value) {
                setState(() => _rating = value);
              },
              activeColor: const Color(0xFFFF6B6B),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _commentController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Share your thoughts...',
                contentPadding: const EdgeInsets.all(12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitReview,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF6B6B),
                minimumSize: const Size.fromHeight(45),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Submit Review'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel',
                  style: TextStyle(color: Color(0xFF4A5568))),
            )
          ],
        ),
      ),
    );
  }
}
