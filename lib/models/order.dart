import 'package:gebeta_food/models/item.dart';
import 'package:gebeta_food/models/user.dart';

class Order {
  final String id;
  final String date;
  final int quantity;
  final Item food;
  final User user;

  Order({
    required this.id,
    required this.date,
    required this.quantity,
    required this.food,
    required this.user,
  });
}