import 'package:flutter/material.dart';
import 'package:gebeta_food/Screens/orders/order_card.dart';
import 'package:gebeta_food/scoped-models/main.dart';

class OrdersList extends StatefulWidget {
  final MainModel model;
  OrdersList(this.model);
  

  @override
  _OrdersListState createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {

   @override
  void initState() {
    
    super.initState();
    widget.model.getAllOrders();
  }

  @override
  Widget build(BuildContext context) {
    return widget.model.getOrderList.length > 0
        ? ListView.builder(
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) => OrderCard(index),
            itemCount: widget.model.getOrderList.length)
        : Center(
            child: Text("No Offers"),
          );
  }
}