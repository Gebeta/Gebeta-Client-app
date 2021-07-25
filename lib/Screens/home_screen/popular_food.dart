import 'package:flutter/material.dart';
import 'package:gebeta_food/Screens/food%20/food.dart';
import 'package:gebeta_food/constants.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Recommendations extends StatefulWidget {

  @override
  _RecommendationsState createState() => _RecommendationsState();
}

class _RecommendationsState extends State<Recommendations> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.33,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          _buildFoodCard("assets/images/burger.png", "Burger", 80.0, 5),
          _buildFoodCard("assets/images/burger.png", "Burger", 80.0, 5),
          _buildFoodCard("assets/images/burger.png", "Burger", 80.0, 5),
        ],
      ),
    );
  }

  Widget _buildFoodCard(
      String img, String foodName, double price, double rating) {
    return InkWell(
      onTap: () {
        print("the whole thing clicked");
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => new FoodDetailPage(foodName, img, price)),
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
                child: Image.asset(
                  img,
                  fit: BoxFit.cover,
                  height: 120,
                  width: 130,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10.0, ),
              child: Text(
                foodName,
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
                    "$price ETB",
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        color: gsecondaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  onPressed: () {},
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
  }
}
