import 'dart:io' as io;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../models/restaurant.dart';
import '../providers/restaurant_provider.dart';

class AddRestaurantScreen extends StatefulWidget {
  const AddRestaurantScreen({super.key});

  @override
  State<AddRestaurantScreen> createState() => _AddRestaurantScreenState();
}

class _AddRestaurantScreenState extends State<AddRestaurantScreen> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cuisineController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Restaurant')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
              if (_imageFile != null)
                SizedBox(
                  height: 150,
                  child: kIsWeb
                      ? Image.network(_imageFile!.path)
                      : Image.file(io.File(_imageFile!.path)),
                ),
              ElevatedButton(
                onPressed: () async {
                  final picked =
                      await _picker.pickImage(source: ImageSource.gallery);
                  if (picked != null) {
                    setState(() {
                      _imageFile = picked;
                    });
                  }
                },
                child: const Text('Pick Image'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final restaurant = Restaurant(
                    name: _nameController.text,
                    address: _addressController.text,
                    cuisine: _cuisineController.text,
                    latitude: 0.0,
                    longitude: 0.0,
                    imageUrl: _imageFile?.path ?? '',
                    description: '',
                  );
                  await Provider.of<RestaurantProvider>(context, listen: false)
                      .addRestaurant(restaurant, context);
                  Navigator.pop(context);
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
