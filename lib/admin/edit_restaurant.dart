import 'package:flutter/material.dart';

class EditRestaurantScreen extends StatelessWidget {
  const EditRestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Restaurant')),
      body: const Center(child: Text('Edit Restaurant Form')),
    );
  }
}
