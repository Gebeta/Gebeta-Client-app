import 'package:flutter/material.dart';
import 'package:gebeta_food/Screens/orders/order_card.dart';
import 'package:gebeta_food/models/order.dart';
import 'package:gebeta_food/scoped-models/main.dart';

class PendingOrderScreen extends StatefulWidget {
  final MainModel model;
  const PendingOrderScreen(this.model);

  @override
  _PendingOrderScreenState createState() => _PendingOrderScreenState();
}

class _PendingOrderScreenState extends State<PendingOrderScreen> {
    @override
  void initState() {
    widget.model.getActiveOrders();
    super.initState();
    // print("name "+widget.model.getActiveOrderList[0].restaurantId);
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (BuildContext context, int index) => OrderCard(index),
        itemCount: widget.model.getActiveOrderList.length);
  }
}
