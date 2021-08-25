class Item {
  final String id;
  final List<dynamic> imageUrl;
  final String description;
  final String name;
  final int price;
  final bool menuStatus;
  int quantity =1;

  Item({
    required this.id,
    required this.imageUrl,
    required this.description,
    required this.name,
    required this.price,
    required this.menuStatus,
    required this.quantity,
  });
}
