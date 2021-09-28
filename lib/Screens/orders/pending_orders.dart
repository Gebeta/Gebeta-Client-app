import 'package:flutter/material.dart';
import 'package:gebeta_food/Screens/orders/order_card.dart';
import 'package:gebeta_food/Screens/orders/pending_order_list.dart';
import 'package:gebeta_food/scoped-models/main.dart';

class PendingOrder extends StatelessWidget {
  final MainModel model;
  PendingOrder(this.model);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pending Order"),
        ),
        body: ListView(
          children: [
            PendingOrderList(model),
          ],
        ));
  }
}
