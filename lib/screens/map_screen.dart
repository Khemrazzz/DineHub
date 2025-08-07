import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../models/restaurant.dart';
import '../providers/restaurant_provider.dart';
import '../services/location_service.dart';
import '../widgets/bottom_navigation.dart';
import 'home_screen.dart';
import 'about_screen.dart';

class MapScreen extends StatefulWidget {
  final Restaurant? restaurant;

  const MapScreen({super.key, this.restaurant});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  LatLng _initialPosition = const LatLng(-20.1609, 57.5012); // Port Louis, Mauritius

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    if (widget.restaurant != null) {
      // Show single restaurant
      _initialPosition = LatLng(widget.restaurant!.latitude, widget.restaurant!.longitude);
      _markers = {
        Marker(
          markerId: MarkerId('restaurant_${widget.restaurant!.id}'),
          position: LatLng(widget.restaurant!.latitude, widget.restaurant!.longitude),
          infoWindow: InfoWindow(
            title: widget.restaurant!.name,
            snippet: widget.restaurant!.cuisine,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      };
    } else {
      // Show all restaurants
      final restaurants = Provider.of<RestaurantProvider>(context, listen: false).restaurants;
      _markers = restaurants.map((restaurant) {
        return Marker(
          markerId: MarkerId('restaurant_${restaurant.id}'),
          position: LatLng(restaurant.latitude, restaurant.longitude),
          infoWindow: InfoWindow(
            title: restaurant.name,
            snippet: '${restaurant.cuisine} • ${restaurant.rating.toStringAsFixed(1)}⭐',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        );
      }).toSet();
    }

    // Try to get user's current location
    try {
      final position = await LocationService().getCurrentPosition();
      if (position != null && widget.restaurant == null) {
        _initialPosition = LatLng(position.latitude, position.longitude);
        _markers.add(
          Marker(
            markerId: const MarkerId('current_location'),
            position: LatLng(position.latitude, position.longitude),
            infoWindow: const InfoWindow(title: 'Your Location'),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error getting location: $e');
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurant?.name ?? 'Restaurant Locations'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFF6B6B), Color(0xFFFF8E8E)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: widget.restaurant != null ? 16.0 : 12.0,
            ),
            markers: _markers,
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            compassEnabled: true,
            mapType: MapType.normal,
          ),
          if (widget.restaurant != null)
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.restaurant!.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.restaurant!.address,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                // In a real app, you would open the default maps app
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Opening directions in maps app...'),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.directions),
                              label: const Text('Directions'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // In a real app, you would open the phone dialer
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Opening phone dialer...'),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.phone),
                              label: const Text('Call'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).colorScheme.secondary,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: widget.restaurant == null
          ? BottomNavigation(
              currentIndex: 1,
              onTap: (index) {
                switch (index) {
                  case 0:
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    );
                    break;
                  case 2:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AboutScreen()),
                    );
                    break;
                }
              },
            )
          : null,
    );
  }
}
