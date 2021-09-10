import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gebeta_food/constants.dart';
import 'package:gebeta_food/scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';

class ReviewScreen extends StatefulWidget {
  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  double ratingNum = 0.0;
  TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Review Screen"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "Well, How was it?",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: gTextColor),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
            // height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Order Details",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: gTextColor),
                ),
                Text("Order id " + "id"),
                Text("Order id " + "id"),
                Container(
                  child: Text("Order Details"),
                ),
                
                DataTable(columns: [
                  DataColumn(label: Text("Item")),
                  DataColumn(label: Text("Quantity")),
                  DataColumn(label: Text("Total"))
                ], rows: [
                  DataRow(cells: [
                    DataCell(Text("1")),
                    DataCell(Text("Pizza")),
                    DataCell(Text("100")),
                  ]),
                  DataRow(cells: [
                    DataCell(Text("2")),
                    DataCell(Text("Pizza")),
                    DataCell(Text("100")),
                  ])
                ])
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
            child: Row(
              children: [
                CircleAvatar(
                  maxRadius: 50,
                  backgroundImage: AssetImage("assets/images/food.png"),
                ),
                Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.0,
                    ),
                    child: Text(
                      "Restaurant Name",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
            child: RatingBar.builder(
              onRatingUpdate: (rating) {
                setState(() {
                  ratingNum = rating;
                });
                print(rating);
              },
              allowHalfRating: true,
              itemCount: 5,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: gPrimaryColor,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.amber,
            ),
            margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
            child: TextField(
              maxLines: 5,
              controller: commentController,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                  hintText: "Enter your comment here",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    // borderSide: BorderSide.none
                  )),
            ),
          ),
          ScopedModelDescendant(builder: (context, Widget child, MainModel model){
              return Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            padding: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
            child: ElevatedButton(
              onPressed: () {
                clickReviewBtn(model.createReview);
              },
              style: ElevatedButton.styleFrom(
                primary: gPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              child: Text("Review"),
            ),
          );
          })
        ],
      ),
    );
  }

  void clickReviewBtn(Function createReview) {
    createReview("611a2969aa2f6b4956fed445", "61389c87b84a60874819ecd9", "61384a0351441b317dc26ecb", ratingNum, commentController.text);
    print("hello");
  }
}
