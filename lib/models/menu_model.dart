class MenuItem {
  final String id;
  final String name;
  final double price;
  final bool available;

  MenuItem({
    required this.id,
    required this.name,
    required this.price,
    this.available = true,
  });
}
