import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gebeta_food/Screens/payment/payment.dart';
import 'package:gebeta_food/constants.dart';
import 'package:gebeta_food/models/cart.dart';
import 'package:gebeta_food/scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';

class FinalCart extends StatefulWidget {
  final double deliveryFee;
  final MainModel model;
  final double totalAmount;
  FinalCart(this.deliveryFee, this.model, this.totalAmount);

  @override
  _FinalCartState createState() => _FinalCartState();
}

class _FinalCartState extends State<FinalCart> {
  List<Cart> _carts = [];
  @override
  void initState() {
    _carts = widget.model.getCartList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Finalze your Order"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Delivery to : "),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  DataTable(
                    columns: [
                      DataColumn(label: Text("Item")),
                      DataColumn(label: Text("Quantity")),
                      DataColumn(label: Text("Total"))
                    ],
                    rows: _carts
                        .map((item) => DataRow(cells: [
                              DataCell(Text(item.name)),
                              DataCell(Text(item.quantity.toString())),
                              DataCell(Text(widget.totalAmount.toString())),
                            ]))
                        .toList(),
                  ),
                  Text("Sub Total   ${widget.totalAmount}"),
                  Text(
                      "Delivery Fee   ${widget.deliveryFee.toStringAsFixed(2)}"),
                  Text(
                      "Total Price   ${(widget.totalAmount + widget.deliveryFee).toStringAsFixed(2)}"),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        height: 60.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: gsecondaryColor, boxShadow: [
          BoxShadow(
              color: Colors.black26, offset: Offset(0, -1), blurRadius: 6.0)
        ]),
        child: ScopedModelDescendant(
            builder: (context, Widget child, MainModel model) {
          return TextButton(
            onPressed: () async{
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => PaymentOptions(_carts,widget.deliveryFee)));
              final Map<String, dynamic> response = await model.createOrder(_carts[0].restaurantId, widget.totalAmount,
                  double.parse(widget.deliveryFee.toStringAsFixed(2)), _carts);
                  if (response['success']) {
                    Navigator.pushReplacementNamed(context, "/home");
                    Fluttertoast.showToast(msg: response['message'] + "Wait a little until the restaurant accept your order");
                   model.resetCart();
                  }
                  
              // PaymentOptions
            },
            child: Text(
              "Checkout",
              style: TextStyle(
                color: whiteColor,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
            ),
          );
        }),
      ),
    );
  }

  getTotalPrice(List<Cart> carts) {
    double price = 0.0;
    for (var cart in carts) {
      price = price + cart.price;
    }

    return price;
  }
}
