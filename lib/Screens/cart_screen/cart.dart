import 'package:flutter/material.dart';
import 'package:gebeta_food/Screens/cart_screen/cart_card.dart';
import 'package:gebeta_food/Screens/payment/payment.dart';
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
    totalAmount = 0.0;
    widget.model.getCartList;
    totalPrice(widget.model);
    // widget.model.totalPrice(widget.model.getCartList);
  }

  @override
  Widget build(BuildContext context) {
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
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Sub Total",
                            style:
                                TextStyle(fontSize: 19, color: gTextLightColor),
                          ),
                          Text(
                            totalAmount.toString(),
                            style:
                                TextStyle(fontSize: 16, color: gTextLightColor),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Shipping",
                            style:
                                TextStyle(fontSize: 19, color: gTextLightColor),
                          ),
                          Text(
                            shippingPrice.toString(),
                            style:
                                TextStyle(fontSize: 16, color: gTextLightColor),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total",
                            style:
                                TextStyle(fontSize: 19, color: gTextLightColor),
                          ),
                          Text(
                            (totalAmount + shippingPrice).toString(),
                            style:
                                TextStyle(fontSize: 16, color: gTextLightColor),
                          )
                        ],
                      ),
                    )
                    // _buildRow("Sub Total", totalAmount),
                    // _buildRow("Shipping", shippingPrice),
                    // _buildRow("Total", totalAmount + shippingPrice),
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
                model.createOrder("", "611a2969aa2f6b4956fed445", model.getUser.id, totalAmount + shippingPrice,
                    widget.model.getCartList);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => new PaymentOptions()));
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

  // Widget _buildRow(String label, double price) {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 8.0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Text(
  //           label,
  //           style: TextStyle(fontSize: 19, color: gTextLightColor),
  //         ),
  //         Text(
  //           price.toString(),
  //           style: TextStyle(fontSize: 16, color: gTextLightColor),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget _buildCartList(List<Cart> cartItems) {
    if (cartItems.length == 0) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Row(
          children: [
            Text("Nothing in your cart"),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/home");
                },
                child: Text("please add items"))
          ],
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) => buildCartCard(index),
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

  Widget buildCartCard(cartIndex) {
    return ScopedModelDescendant<MainModel>(
      builder: (context, Widget child, MainModel model) {
        Cart cartItem = model.getCartList[cartIndex];
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          height: 120.0,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12.0)),
          child: Stack(
            children: [
              ScopedModelDescendant(
                  builder: (context, Widget child, MainModel model) {
                return Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                      child: IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              setState(() {
                                                model.removeFromCart(cartIndex);
                                              });
                                              model.removeFromCart(cartIndex);
                                              Navigator.pop(context);
                                            },
                                            child: Text("Yes")),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("No"))
                                      ],
                                      title: Text(
                                        "Are you sure",
                                      ));
                                });
                          },
                          icon: Icon(
                            Icons.close,
                            size: 18,
                            color: gPrimaryColor,
                          ))),
                );
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12)),
                    child: Image(
                      height: 150.0,
                      width: 150.0,
                      image: NetworkImage(
                          'http://192.168.1.9:3000/images/${model.getCartList[cartIndex].id}/${model.getCartList[cartIndex].image}'), //networkImage
                      fit: BoxFit.cover,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(cartItem.name),
                      Text(cartItem.price.toString())
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (cartItem.quantity > 1) {
                              cartItem.quantity--;
                            }
                          });
                          // Navigator.pushNamed(context, "/my_cart");
                        },
                        icon: Icon(Icons.remove_circle),
                        color: gsecondaryColor,
                        iconSize: 27,
                      ),
                      Text(cartItem.quantity.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Montserrat",
                          )),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            cartItem.quantity++;
                          });
                        },
                        icon: Icon(Icons.add_circle),
                        color: gsecondaryColor,
                        iconSize: 27,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
