import 'package:flutter/material.dart';

class ReviewManagementScreen extends StatefulWidget {
  const ReviewManagementScreen({super.key});

  @override
  State<ReviewManagementScreen> createState() => _ReviewManagementScreenState();
}

class _ReviewManagementScreenState extends State<ReviewManagementScreen> {
  final List<Map<String, dynamic>> _reviews = [
    {'user': 'John Doe', 'rating': 8, 'comment': 'Great food!'},
    {'user': 'Sarah Smith', 'rating': 9, 'comment': 'Amazing service!'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Review Management')),
      body: ListView.builder(
        itemCount: _reviews.length,
        itemBuilder: (context, index) {
          final review = _reviews[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(review['user']),
              subtitle: Text(review['comment']),
              leading: CircleAvatar(child: Text(review['rating'].toString())),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.check, color: Colors.green),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
