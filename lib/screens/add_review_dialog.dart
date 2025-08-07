import 'package:flutter/material.dart';
import '../models/restaurant_model.dart';

class AddReviewDialog extends StatefulWidget {
  final Restaurant restaurant;
  const AddReviewDialog({super.key, required this.restaurant});

  @override
  State<AddReviewDialog> createState() => _AddReviewDialogState();
}

class _AddReviewDialogState extends State<AddReviewDialog> {
  double _rating = 5;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Review ${widget.restaurant.name}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Slider(
            value: _rating,
            min: 0,
            max: 10,
            divisions: 10,
            label: _rating.round().toString(),
            onChanged: (v) => setState(() => _rating = v),
          ),
          TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: 'Comment (optional)'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
