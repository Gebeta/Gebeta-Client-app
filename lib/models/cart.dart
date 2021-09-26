import 'package:gebeta_food/models/restaurant.dart';

class Cart {
  final String id;
  final String name;
  final String description;
  final String image;
  final String restaurantId;
  final double price;
  late int quantity;

  Cart({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.restaurantId,
    required this.price,
    required this.quantity,
  });
}
