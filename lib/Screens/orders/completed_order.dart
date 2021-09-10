import 'package:flutter/material.dart';
import 'package:gebeta_food/models/order.dart';
import 'package:gebeta_food/scoped-models/main.dart';

class CompletedOrderScreen extends StatefulWidget {
  final MainModel model;
  const CompletedOrderScreen(this.model);

  @override
  _CompletedOrderScreenState createState() => _CompletedOrderScreenState();
}

class _CompletedOrderScreenState extends State<CompletedOrderScreen> {

    @override
  void initState() {
    widget.model.getCompletedOrders();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}