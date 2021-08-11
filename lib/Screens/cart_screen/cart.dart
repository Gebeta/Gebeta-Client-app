import 'package:flutter/material.dart';
import 'package:gebeta_food/Screens/cart_screen/cart_card.dart';
import 'package:gebeta_food/constants.dart';

class MyCartPage extends StatefulWidget {
  const MyCartPage({Key? key}) : super(key: key);

  @override
  _MyCartPageState createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
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
              _buildCartList(),
              Container(
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(10.0)
                ),
                margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    _buildRow("Sub Total", 450.0),
                    _buildRow("Shipping", 450.0),
                    _buildRow("Total", 450.0),
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
        child: TextButton(
          onPressed: () {},
          child: Text(
            "Checkout",
            style: TextStyle(
                color: whiteColor,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0),
          ),
        ),
      ),
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

  Widget _buildCartList() {
    // Widget cartCard;
    // return ListView.builder(
    //   shrinkWrap: true,
    //   itemBuilder: (BuildContext context, int index) => CartCard(),
    //   itemCount: 5,
    // );
    return Column(
      children: [CartCard(), CartCard(), CartCard(), CartCard()],
    );
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
}
