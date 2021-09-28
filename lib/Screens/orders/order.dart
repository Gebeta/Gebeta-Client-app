import 'package:flutter/material.dart';
import 'package:gebeta_food/scoped-models/main.dart';

class OrderScreen extends StatelessWidget {
  final MainModel model;
  OrderScreen(this.model);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.flip_to_back_outlined), onPressed: () { 
          Navigator.pop(context);
         },),
        centerTitle: true,
        title: Text("My Orders"),
      ),
      body: ListView(
        children: [
          
        ],
      ),
    );
  }
}