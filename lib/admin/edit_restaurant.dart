import 'dart:io' as io;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../models/restaurant.dart';
import '../providers/restaurant_provider.dart';

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
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

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
                )
              else if (widget.restaurant.imageUrl.isNotEmpty)
                SizedBox(
                  height: 150,
                  child: kIsWeb
                      ? Image.network(widget.restaurant.imageUrl)
                      : Image.file(io.File(widget.restaurant.imageUrl)),
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
                  final updated = Restaurant(
                    id: widget.restaurant.id,
                    name: _nameController.text,
                    address: _addressController.text,
                    cuisine: _cuisineController.text,
                    latitude: widget.restaurant.latitude,
                    longitude: widget.restaurant.longitude,
                    imageUrl: _imageFile?.path ?? widget.restaurant.imageUrl,
                    description: widget.restaurant.description,
                    rating: widget.restaurant.rating,
                    reviewCount: widget.restaurant.reviewCount,
                  );
                  await Provider.of<RestaurantProvider>(context, listen: false)
                      .updateRestaurant(updated, context);
                  Navigator.pop(context);
                },
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
