class Cart {
  final String id;
  final String name;
  final String description;
  final String image;
  final double price;
  late int quantity;

  Cart({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.quantity,
  });
}
