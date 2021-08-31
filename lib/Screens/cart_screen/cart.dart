import 'package:flutter/material.dart';
import 'package:gebeta_food/Screens/cart_screen/cart_card.dart';
import 'package:gebeta_food/constants.dart';
import 'package:gebeta_food/models/cart.dart';
import 'package:gebeta_food/scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';

class MyCartPage extends StatefulWidget {
  final MainModel model;
  const MyCartPage(this.model);

  @override
  _MyCartPageState createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  // int count = 1;
  double totalAmount = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.model.getCartList;
    // widget.model.totalPrice(widget.model.getCartList);
  }

  @override
  Widget build(BuildContext context) {
    double totalAmountX = totalPrice(widget.model);
    double shippingPrice = 200.0;
    return Scaffold(
      backgroundColor: Color(0xfff9efeb),
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("My Cart"),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              _builtDeliveryWidget(),
              _buildCartList(widget.model.getCartList),
              Container(
                decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(10.0)),
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Text("sub total")
                    _buildRow("Sub Total", totalAmountX),
                    _buildRow("Shipping", shippingPrice),
                    _buildRow("Total", totalAmountX + shippingPrice),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 70,
          )
        ],
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
              onPressed: () {
                model.createOrder("id", "restaurantId", "clientId", totalAmount, widget.model.getCartList);
              },
              child: Text(
                "Checkout",
                style: TextStyle(
                    color: whiteColor,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0),
              ),
            );
          })),
    );
  }

  Widget _buildRow(String label, double price) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 19, color: gTextLightColor),
          ),
          Text(
            price.toString(),
            style: TextStyle(fontSize: 16, color: gTextLightColor),
          )
        ],
      ),
    );
  }

  Widget _buildCartList(List<Cart> cartItems) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) => CartCard(index),
      itemCount: cartItems.length,
    );
    // return Column(
    //   children: [CartCard(), CartCard(), CartCard(), CartCard(),],
    // );
  }

  Widget _builtDeliveryWidget() {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
          color: whiteColor, borderRadius: BorderRadius.circular(10.0)),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 10.0),
          child: Text(
            "Delivery At",
            style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 17.0,
                color: gTextLightColor),
          ),
        ),
        TextButton(
            onPressed: () {},
            child: Text(
              "Choose Location ",
              style: TextStyle(color: gsecondaryColor),
            ))
      ]),
    );
  }

  double totalPrice(MainModel model) {
    List<Cart> cartItems = model.getCartList;
    for (int i = 0; i < cartItems.length; i++) {
      setState(() {
        totalAmount = totalAmount + cartItems[i].price * cartItems[i].quantity;
        // print(totalAmount);
      });
    }

    return totalAmount;
  }
}
