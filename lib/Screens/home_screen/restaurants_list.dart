import 'package:flutter/material.dart';
import 'package:gebeta_food/Screens/restaurant/restaurant.dart';
import 'package:gebeta_food/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gebeta_food/models/restaurant.dart';

class RestaurantsList extends StatefulWidget {
  const RestaurantsList({Key? key}) : super(key: key);

  @override
  _RestaurantsListState createState() => _RestaurantsListState();
}

Widget _listItem(BuildContext context, String imgPath, String restaurantName,
    String desc, double rating, bool isOpen) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: GestureDetector(
      onTap: () {
        print("Restaurant clicked");
        Restaurant restaurant = Restaurant(
            id: "612569c05920bc395d2a7f53",
            name: restaurantName,
            address: "",
            phoneNo: "",
            email: "email",
            rating: rating,
            isApproved: isOpen);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => new RestaurantScreen(restaurant)),
        // );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Hero(
                tag: imgPath,
                child: Image.asset(
                  imgPath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.26,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        restaurantName,
                        style: TextStyle(
                            color: Color(0xFF563734),
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 8,
                        ),
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            color: isOpen
                                ? Color(0xff0267C1).withOpacity(0.65)
                                : Colors.red.withOpacity(0.65),
                            borderRadius: BorderRadius.circular(4)),
                        child: Text(
                          isOpen ? "Open" : "Closed",
                          style: TextStyle(color: whiteColor),
                        ),
                      )
                    ],
                  ),
                  Container(
                    child: RatingBarIndicator(
                      rating: rating,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: gPrimaryColor,
                      ),
                      itemCount: 5,
                      itemSize: 20.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    child: Text(
                      desc,
                      style: TextStyle(
                          color: Color(0xFFB2A9A9),
                          fontFamily: 'Montserrat',
                          fontSize: 15.0),
                    ),
                  ),
                  SizedBox(height: 10.0),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

class _RestaurantsListState extends State<RestaurantsList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _listItem(
            context,
            'assets/images/burger2.png',
            'Restaurant 1',
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In feugiat pretium quam a maximus. In sodales interdum diam, eget porttitor justo ullamcorper sit amet. ',
            5,
            true),
        SizedBox(height: 10.0),
        _listItem(
            context,
            'assets/images/food.png',
            'Restaurant 1',
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In feugiat pretium quam a maximus. In sodales interdum diam, eget porttitor justo ullamcorper sit amet. ',
            3.3,
            false),
      ],
    );
  }
}
