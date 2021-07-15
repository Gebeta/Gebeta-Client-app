import 'package:flutter/material.dart';
import 'package:gebeta_food/constants.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PopularTodayList extends StatefulWidget {

  @override
  _PopularTodayListState createState() => _PopularTodayListState();
}

class _PopularTodayListState extends State<PopularTodayList> {
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
    return Container(
      height: 300,
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
            padding: EdgeInsets.only(left: 15.0, top: 5.0, ),
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
          // Container(
          //   child: Padding(
          //     padding: const EdgeInsets.only(left: 15),
          //     child: RatingBarIndicator(
          //       rating: rating,
          //       itemBuilder: (context, index) => Icon(
          //         Icons.star,
          //         color: Colors.amber,
          //       ),
          //       itemCount: 5,
          //       itemSize: 17.0,

          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
