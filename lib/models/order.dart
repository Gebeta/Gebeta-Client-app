import 'package:gebeta_food/models/item.dart';


class Order {
  final String id;
  final String restaurantId;
  final String clientId;
  final double totalPrice;
  final bool isAcitive;
  final List<Item> items;
  late String date;

  Order({
    required this.id,
    required this.restaurantId,
    required this.clientId,
    required this.totalPrice,
    required this.isAcitive,
    required this.items,
    required this.date
  });
}