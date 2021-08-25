import 'package:gebeta_food/models/item.dart';

class Cart {
  final String id;
  final Item item;
  final int noOfItem;

  Cart({
    required this.id,
    required this.item,
    required this.noOfItem
  });
}