import 'package:flutter/material.dart';

class ManageRestaurantsScreen extends StatelessWidget {
  const ManageRestaurantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Restaurants')),
      body: const Center(child: Text('Manage Restaurants')),
    );
  }
}
