import 'package:flutter/material.dart';
import 'package:gebeta_food/Screens/food%20/food.dart';
// import 'package:gebeta_food/Screens/restaurant/restaurant.dart';
import 'package:gebeta_food/constants.dart';

class PopularFoodListView extends StatefulWidget {
  @override
  _PopularFoodListViewState createState() => _PopularFoodListViewState();
}

class _PopularFoodListViewState extends State<PopularFoodListView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        _buildFoodCard("assets/images/burger.png", "Burger", 80.0, 5),
        _buildFoodCard("assets/images/burger.png", "Burger", 80.0, 5),
        _buildFoodCard("assets/images/burger.png", "Burger", 80.0, 5),
      ],
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image.asset(
                  img,
                  fit: BoxFit.cover,
                  height: 130,
                  width: 130,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 15.0,
                top: 5.0,
              ),
              child: Text(
                foodName,
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
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
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Icon(Icons.add),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(gPrimaryColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
