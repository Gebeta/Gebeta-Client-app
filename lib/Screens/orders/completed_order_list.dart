
import 'package:flutter/material.dart';
import 'package:gebeta_food/Screens/orders/completed_order_card.dart';
import 'package:gebeta_food/scoped-models/main.dart';

class CompletedOrderList extends StatefulWidget {
  final MainModel model;
  CompletedOrderList(this.model);

  @override
  _CompletedOrderListState createState() => _CompletedOrderListState();
}

class _CompletedOrderListState extends State<CompletedOrderList> {
  @override
  void initState() {
    
    super.initState();
    widget.model.getCompletedOrders();
  }

  @override
  Widget build(BuildContext context) {
    return widget.model.getActiveOrderList.length > 0
        ? ListView.builder(
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) => CompletedOrderCard(index),
            itemCount: widget.model.getCompletedOrderList.length)
        : Center(
            child: Text("No Offers"),
          );
  }
}
