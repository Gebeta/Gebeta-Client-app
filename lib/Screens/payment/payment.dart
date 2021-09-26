import 'package:flutter/material.dart';
import 'package:gebeta_food/Screens/widgets/form_input/button.dart';
import 'package:gebeta_food/constants.dart';
import 'package:gebeta_food/models/cart.dart';

class PaymentOptions extends StatefulWidget {
  final List<Cart> carts;
  final double deliveryFee;
  PaymentOptions(this.carts,this.deliveryFee);

  @override
  _PaymentOptionsState createState() => _PaymentOptionsState();
}

class _PaymentOptionsState extends State<PaymentOptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff9efeb),
        appBar: AppBar(
          centerTitle: true,
          title: Text("Payment Options"),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.only(left: 25),
              color: whiteColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/images/yene.png",
                    height: 80,
                    width: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Text("YenePay"),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.only(left: 25),
              color: whiteColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/images/stripe.png",
                    height: 80,
                    width: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Text("Stripe"),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.only(left: 25),
              color: whiteColor,
              child: InkWell(
                onTap: (){
                  print("object");
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/payp.png",
                      height: 80,
                      width: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Text("PayPal"),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 200),
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [gsecondaryColor, gPrimaryColor],
                  stops: [0, 1],
                ),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: InkWell(
                onTap: () {},
                child: ButtonWidget(() {}, "Next"),
              ),
            )
          ]),
        ));
  }
}
