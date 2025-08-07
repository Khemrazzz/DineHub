import 'package:flutter/material.dart';

class AddRestaurantScreen extends StatelessWidget {
  const AddRestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Restaurant')),
      body: const Center(child: Text('Add Restaurant Form')),
    );
  }
}
