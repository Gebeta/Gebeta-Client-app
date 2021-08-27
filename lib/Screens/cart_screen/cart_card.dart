import 'package:flutter/material.dart';
import 'package:gebeta_food/constants.dart';
import 'package:gebeta_food/models/cart.dart';
import 'package:gebeta_food/scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';

class CartCard extends StatefulWidget {
  final int cartIndex;
  const CartCard(this.cartIndex);

  @override
  _CartCardState createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (context, Widget child, MainModel model) {
        Cart cartItem = model.getCartList[widget.cartIndex];
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          height: 120.0,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12.0)),
          child: Dismissible(
            key: UniqueKey(),
            background: Container(
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.delete_forever,
                      color: Colors.white,
                      size: 33,
                    ),
                  ),
                ],
              ),
            ),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.endToStart) {
                print("swiped end to start");
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12)),
                  child: Image(
                    height: 150.0,
                    width: 150.0,
                    image: NetworkImage('http://192.168.1.11:3000/images/${model.getCartList[widget.cartIndex].id}/${model.getCartList[widget.cartIndex].image}'), //networkImage
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(cartItem.name), Text(cartItem.price.toString())],
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
          ),
        );
      },
    );
  }
}
