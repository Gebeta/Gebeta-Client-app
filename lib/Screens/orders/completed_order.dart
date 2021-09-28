import 'package:flutter/material.dart';
import 'package:gebeta_food/scoped-models/main.dart';
import 'completed_order_list.dart';

class CompletedOrder extends StatefulWidget {
  final MainModel model;
  CompletedOrder(this.model);

  @override
  _CompletedOrderState createState() => _CompletedOrderState();
}

class _CompletedOrderState extends State<CompletedOrder> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.model.getCompletedOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Completed Order"),
        ),
        body: ListView(
          children: [
            CompletedOrderList(widget.model),
          ],
        ));
  }
}
