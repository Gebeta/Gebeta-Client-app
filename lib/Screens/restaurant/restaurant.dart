import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gebeta_food/constants.dart';

class RestaurantScreen extends StatefulWidget {
  final String restauranName;
  final String img;
  final String description;
  final double rating;
  final bool isOpen;

  RestaurantScreen(
      this.restauranName, this.img, this.description, this.rating, this.isOpen);

  @override
  _RestaurantScreenState createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  Widget _buildMenuItem() {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 175.0,
            width: 175.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/food.png"),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(15.0)),
          ),
          Container(
            height: 175.0,
            width: 175.0,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.black87.withOpacity(0.3),
                      Colors.black54.withOpacity(0.3),
                      Colors.black38.withOpacity(0.3),
                    ]),
                borderRadius: BorderRadius.circular(15.0)),
          ),
          Positioned(
            bottom: 65.0,
            child: Column(
              children: [
                Text(
                  "Pizza",
                  style: TextStyle(
                      fontSize: 24.0,
                      color: whiteColor,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '80 ETB',
                  style: TextStyle(
                      fontSize: 17.0,
                      color: whiteColor,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: Container(
              width: 45.0,
              decoration: BoxDecoration(
                  color: gsecondaryColor,
                  borderRadius: BorderRadius.circular(50)),
              child: IconButton(
                onPressed: () {},
                color: whiteColor,
                icon: Icon(Icons.add),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Hero(
                tag: widget.img,
                child: Image(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  image: AssetImage(widget.img),
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      color: whiteColor,
                      onPressed: () => Navigator.pop(context),
                      iconSize: 28,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.restauranName,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              children: [
                RatingBarIndicator(
                  rating: widget.rating,
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: gPrimaryColor,
                  ),
                  itemCount: 5,
                  itemSize: 20.0,
                ),
                Text(
                  "(300 Reviews)",
                  style: TextStyle(
                      color: gTextLightColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w300),
                ),
                TextButton(onPressed: () {}, child: Text("see Reviews"))
              ],
            ),
          ),
          SizedBox(height: 6.0),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              "Safari, Addis Ababa",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15.0, top: 15.0),
              child: Text(
                "Menu",
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                    color: gTextColor),
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(
                10,
                (index) {
                  return _buildMenuItem();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
