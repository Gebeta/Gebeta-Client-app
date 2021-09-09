import 'package:flutter/material.dart';
import 'package:gebeta_food/models/rating.dart';
import 'package:gebeta_food/scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';

class ReviewCard extends StatefulWidget {
  final int index;
  ReviewCard(this.index);

  @override
  _ReviewCardState createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (context, Widget child, MainModel model) {
      Rating reviewModel = model.fetchReviews[widget.index];
      return Container(
        margin: EdgeInsets.only(top: 20, left: 15, right: 15),
        padding: EdgeInsets.only(top: 8, left: 10, right: 10),
        decoration: BoxDecoration(
          color: Color(0xfff9efeb),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  maxRadius: 20,
                  backgroundImage: AssetImage("assets/images/profile.png"),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text("Client Name"),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: Text(reviewModel.comment),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  reviewModel.likes.toString() + " likes",
                  style: TextStyle(fontSize: 18),
                ),
                TextButton(
                    onPressed: () => _likeReview(model.likeAReview,reviewModel.id),
                    child: Row(
                      children: [
                        Icon(
                          Icons.thumb_up_rounded,
                          size: 20,
                        ),
                      ],
                    ))
              ],
            )
          ],
        ),
      );
    });
  }

  _likeReview(Function likeAReview, String id) {
    likeAReview(id);
    print("bubu");
  }
}
