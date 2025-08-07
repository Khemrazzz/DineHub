import 'package:flutter/material.dart';

class AddRestaurantScreen extends StatefulWidget {
  const AddRestaurantScreen({super.key});

  @override
  State<AddRestaurantScreen> createState() => _AddRestaurantScreenState();
}

class _AddRestaurantScreenState extends State<AddRestaurantScreen> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cuisineController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Restaurant')),
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
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
