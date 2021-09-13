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
          child: Stack(
            children: [
              ScopedModelDescendant(
                  builder: (context, Widget child, MainModel model) {
                return Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                      child:
                          IconButton(onPressed: () {
                            showDialog(context: context, builder: (context){
                              return AlertDialog(actions: [
                                TextButton(onPressed: (){
                                  setState(() {
                                   model.removeFromCart(widget.cartIndex);   
                                  });
                                  model.removeFromCart(widget.cartIndex);
                                  Navigator.pop(context);
                                }, child: Text("Yes")),
                                TextButton(onPressed: (){
                                  Navigator.pop(context);
                                }, child: Text("No"))
                              ],
                              title: Text("Are you sure",));
                            });
                            
                          }, icon: Icon(Icons.close,size: 18,color: gPrimaryColor,))),
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
                          '$baseUrl/${model.getCartList[widget.cartIndex].id}/${model.getCartList[widget.cartIndex].image}'), //networkImage
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
