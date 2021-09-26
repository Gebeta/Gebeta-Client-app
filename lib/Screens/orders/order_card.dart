import 'package:flutter/material.dart';
import 'package:gebeta_food/Screens/orders/order_detail.dart';
import 'package:gebeta_food/Screens/review_screen/review_sceen.dart';
import 'package:gebeta_food/constants.dart';
import 'package:gebeta_food/models/order.dart';
import 'package:gebeta_food/scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';

class OrderCard extends StatefulWidget {
  final int orderIndex;
  const OrderCard(this.orderIndex);

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (context, Widget child, MainModel model) {
      Order orderModel = model.getActiveOrderList[widget.orderIndex];
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      new OrderDetailsPage(orderModel, model)));
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 3,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ]),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Order No"),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: getOrderId(orderModel.id),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text("Date"),
                  ),
                  Text("Date"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text("Status"),
                  ),
                  Text(orderModel.status),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text("Total"),
                  ),
                  Text((orderModel.totalPrice + orderModel.shippingFee)
                      .toString()),
                ],
              ),
              
            ],
          ),
        ),
      );
    });
  }

  

  Widget getOrderId(int id) {
    Widget orderId;
    if (id < 10) {
      orderId = Text("000" + id.toString());
    } else if (id < 100) {
      orderId = Text("00" + id.toString());
    } else if (id < 1000) {
      orderId = Text("0" + id.toString());
    } else {
      orderId = Text("" + id.toString());
    }
    return orderId;
  }
}
