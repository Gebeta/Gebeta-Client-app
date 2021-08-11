import 'package:flutter/material.dart';
import 'package:gebeta_food/constants.dart';

class CartCard extends StatefulWidget {
  const CartCard({Key? key}) : super(key: key);

  @override
  _CartCardState createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
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
                child: Icon(Icons.delete_forever,color: Colors.white,size: 33,),
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
                image: AssetImage("assets/images/food.png"),
                fit: BoxFit.cover,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Food Name"), Text("Price")],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (count > 1) {
                        count--;
                      }
                    });
                  },
                  icon: Icon(Icons.remove_circle),
                  color: gsecondaryColor,
                  iconSize: 27,
                ),
                Text(count.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Montserrat",
                    )),
                IconButton(
                  onPressed: () {
                    setState(() {
                      count++;
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
  }
}
