class MenuItem {
  final int? id;
  final int restaurantId;
  final String name;
  final String description;
  final double price;
  final String category;
  final bool available;

  MenuItem({
    this.id,
    required this.restaurantId,
    required this.name,
    this.description = '',
    required this.price,
    this.category = 'Main',
    this.available = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'restaurantId': restaurantId,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'available': available ? 1 : 0,
    };
  }

  factory MenuItem.fromMap(Map<String, dynamic> map) {
    return MenuItem(
      id: map['id'],
      restaurantId: map['restaurantId'],
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      category: map['category'] ?? 'Main',
      available: map['available'] == 1,
    );
  }
}
