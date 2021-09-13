import 'package:flutter/material.dart';
import 'package:gebeta_food/Screens/orders/completed_order.dart';
import 'package:gebeta_food/Screens/orders/pending_orderd.dart';
import 'package:gebeta_food/scoped-models/main.dart';

class AllOrdersScreen extends StatefulWidget {
  final MainModel model;
  
  const AllOrdersScreen(this.model);

  @override
  _AllOrdersScreenState createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  @override
  void initState() {
    // TODO: implement initState
    widget.model.getActiveOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2,
     child: Scaffold(
       appBar: AppBar(
         title: Text("Orders History"),
         bottom: TabBar(
           labelStyle: TextStyle(fontSize: 16),
           unselectedLabelStyle: TextStyle(fontSize: 15),
           tabs: [
             Tab(
               text: "Pending Orders",
             ),
             Tab(
               text: "Completed Orders",
             )
           ],
         ),
       ),
       body: TabBarView(
         children: [
           PendingOrderScreen(widget.model),
           CompletedOrderScreen(widget.model)
         ],
       ),
     )
      
    );
  }
}