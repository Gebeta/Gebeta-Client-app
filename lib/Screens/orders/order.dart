import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.flip_to_back_outlined), onPressed: () { 
          Navigator.pop(context);
         },),
        centerTitle: true,
        title: Text("Order Details"),
      ),
    );
  }
}