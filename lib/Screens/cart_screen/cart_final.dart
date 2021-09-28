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
            onPressed: () async {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => PaymentOptions(_carts,widget.deliveryFee)));
              // showDialog(context: context, builder: (context)=>{
              //   return
              // })
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Make your Payment Using Stripe'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            TextFormField(
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: gPrimaryColor),
                              decoration: InputDecoration(
                                hintText: "4242424242424242",
                                labelText: "Credit Card ",
                                labelStyle: TextStyle(
                                    color: gPrimaryColor,
                                    fontWeight: FontWeight.w600),
                                hintStyle: TextStyle(
                                    color: gPrimaryColor,
                                    fontWeight: FontWeight.w100),
                              ),
                              validator: (value) {
                                if (value.toString().isEmpty ||
                                    value.toString().length < 16) {
                                  return 'please Enter a valid Number';
                                }
                                if (value.toString() != "4242424242424242") {
                                  return 'for development only, use 4242424242424242';
                                }
                              },
                            ),
                            Text("Amount: " + widget.totalAmount.toString()),
                            Text('please Enter a valid Number'),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () async {
                              final Map<String, dynamic> response =
                                  await model.createOrder(
                                      _carts[0].restaurantId,
                                      widget.totalAmount,
                                      double.parse(widget.deliveryFee
                                          .toStringAsFixed(2)),
                                      _carts);
                              if (response['success']) {
                                Fluttertoast.showToast(
                                    msg: response['message'] +
                                        "Wait a little until the restaurant accept your order");
                                model.resetCart();
                                Navigator.pop(context);
                                Navigator.pushReplacementNamed(
                                    context, "/home");
                              }

                              Navigator.pop(context);
                            },
                            child: Text("Pay")),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, "/my_cart");
                              Fluttertoast.showToast(
                                  msg: "You have canceled the transaction");
                            },
                            child: Text("Cancel"))
                      ],
                    );
                  });

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
