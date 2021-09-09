import 'package:flutter/material.dart';
import 'package:gebeta_food/Screens/food%20/food.dart';
import 'package:gebeta_food/constants.dart';
import 'package:gebeta_food/models/item.dart';
import 'package:gebeta_food/scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';

class FoodCard extends StatelessWidget {
  final int itemIndex;
  const FoodCard(this.itemIndex);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (context, Widget child, MainModel model) {
        Item itemModel = model.displayItems[itemIndex];
        return InkWell(
          onTap: () {
            print("the whole thing clicked");
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      new FoodDetailPage(itemModel)),
            );
          },
          child: Container(
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(7.0),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 3.0,
                spreadRadius: 3.0)
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image.network(
                  'http://192.168.1.9:3000/images/${itemModel.id}/${itemModel.imageUrl[1]}',
                  fit: BoxFit.cover,
                  height: 120,
                  width: 130,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10.0, ),
              child: Text(
                itemModel.name,
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                      '${itemModel.price.toString()} ETB',
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        color: gsecondaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    
                  },
                  icon: Icon(Icons.add_circle),
                  color: gsecondaryColor,
                  iconSize: 35,
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
