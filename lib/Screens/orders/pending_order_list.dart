
import 'package:flutter/material.dart';
import 'package:gebeta_food/Screens/orders/pending_order_card.dart';
import 'package:gebeta_food/scoped-models/main.dart';

class PendingOrderList extends StatefulWidget {
  final MainModel model;
  PendingOrderList(this.model);

  @override
  _PendingOrderListState createState() => _PendingOrderListState();
}

class _PendingOrderListState extends State<PendingOrderList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.model.getActiveOrders();
  }

  @override
  Widget build(BuildContext context) {
    return widget.model.getActiveOrderList.length > 0
        ? ListView.builder(
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) => PendingOrderCard(index),
            itemCount: widget.model.getActiveOrderList.length)
        : Center(
            child: Text("No Orders"),
          );
  }
}
