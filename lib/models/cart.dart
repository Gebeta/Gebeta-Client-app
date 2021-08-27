import 'package:gebeta_food/models/item.dart';

class Cart {
  final String id;
  final String name;
  final String image;
  final double price;
  late int quantity;
  // final String size;

  Cart({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
    // required this.size
  });
}