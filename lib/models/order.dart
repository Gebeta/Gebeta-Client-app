import 'package:gebeta_food/models/item.dart';

class Order {
  final int id;
  final String restaurantId;
  final String clientId;
  final String clientName;
  final double totalPrice;
  final double shippingFee;
  final bool isAcitive;
  final List<dynamic> items;
  // final String date;

  Order({
    required this.id,
    required this.restaurantId,
    required this.clientId,
    required this.clientName,
    required this.totalPrice,
    required this.shippingFee,
    required this.isAcitive,
    // required this.date,
    required this.items,
  });
}
