import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../models/menu_item.dart';
import '../services/database_service.dart';

class ManageMenusScreen extends StatefulWidget {
  final Restaurant restaurant;
  const ManageMenusScreen({super.key, required this.restaurant});

  @override
  State<ManageMenusScreen> createState() => _ManageMenusScreenState();
}

class _ManageMenusScreenState extends State<ManageMenusScreen> {
  final DatabaseService _db = DatabaseService();
  List<MenuItem> _menu = [];

  @override
  void initState() {
    super.initState();
    _loadMenu();
  }

  Future<void> _loadMenu() async {
    final restaurantId = widget.restaurant.id;
    if (restaurantId != null) {
      final items = await _db.getMenuItems(restaurantId);
      setState(() => _menu = items);
    }
  }

  void _addItem() {
    setState(() {
      _menu.add(
        MenuItem(
          restaurantId: widget.restaurant.id ?? 0,
          name: 'New Item',
          price: 0.0,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage Menu - ${widget.restaurant.name}')),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: _menu.length,
        itemBuilder: (context, index) {
          final item = _menu[index];
          return ListTile(
            title: Text(item.name),
            subtitle: Text('\\${item.price.toStringAsFixed(2)}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => setState(() => _menu.removeAt(index)),
            ),
          );
        },
      ),
    );
  }
}
