class Restaurant {
  final int? id;
  final String name;
  final String address;
  final String cuisine;
  final double latitude;
  final double longitude;
  final String imageUrl;
  final String description;
  double rating;
  int reviewCount;

  Restaurant({
    this.id,
    required this.name,
    required this.address,
    required this.cuisine,
    required this.latitude,
    required this.longitude,
    this.imageUrl = '',
    this.description = '',
    this.rating = 0.0,
    this.reviewCount = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'cuisine': cuisine,
      'latitude': latitude,
      'longitude': longitude,
      'imageUrl': imageUrl,
      'description': description,
      'rating': rating,
      'reviewCount': reviewCount,
    };
  }

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      id: map['id'],
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      cuisine: map['cuisine'] ?? '',
      latitude: map['latitude']?.toDouble() ?? 0.0,
      longitude: map['longitude']?.toDouble() ?? 0.0,
      imageUrl: map['imageUrl'] ?? '',
      description: map['description'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
      reviewCount: map['reviewCount']?.toInt() ?? 0,
    );
  }

  String get distance => '${(rating * 0.5).toStringAsFixed(1)}km';
}
