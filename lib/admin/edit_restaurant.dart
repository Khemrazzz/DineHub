import 'package:flutter/material.dart';
import '../models/restaurant_model.dart';

class EditRestaurantScreen extends StatefulWidget {
  final Restaurant restaurant;
  const EditRestaurantScreen({super.key, required this.restaurant});

  @override
  State<EditRestaurantScreen> createState() => _EditRestaurantScreenState();
}

class _EditRestaurantScreenState extends State<EditRestaurantScreen> {
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _cuisineController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.restaurant.name);
    _addressController = TextEditingController(text: widget.restaurant.address);
    _cuisineController = TextEditingController(text: widget.restaurant.cuisine);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Restaurant')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: _cuisineController,
              decoration: const InputDecoration(labelText: 'Cuisine'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
