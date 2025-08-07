import 'package:flutter/material.dart';
import '../models/restaurant_model.dart';
import '../services/restaurant_service.dart';
import '../widgets/restaurant_card.dart';
import '../widgets/bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RestaurantService _service = RestaurantService();
  List<Restaurant> _restaurants = [];
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final data = await _service.fetchRestaurants();
    setState(() => _restaurants = data);
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _restaurants
        .where((r) => r.name
            .toLowerCase()
            .contains(_searchText.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF6B6B),
        elevation: 0,
        toolbarHeight: 100,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'DineHub',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              'Find your next favorite meal',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const DineHubNavBar(currentIndex: 0),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: const Color(0xFFFF6B6B),
            child: TextField(
              onChanged: (value) => setState(() => _searchText = value),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search restaurants...',
                hintStyle: const TextStyle(color: Colors.white70),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                filled: true,
                fillColor: Colors.white.withOpacity(0.2),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: _restaurants.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : filtered.isEmpty
                    ? const Center(child: Text('No restaurants found'))
                    : ListView.builder(
                        itemCount: filtered.length,
                        padding: const EdgeInsets.all(16),
                        itemBuilder: (context, index) {
                          return RestaurantCard(restaurant: filtered[index]);
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
