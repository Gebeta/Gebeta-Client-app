import 'package:flutter/material.dart';
import 'package:gebeta_food/Screens/review_screen/review_card.dart';
import 'package:gebeta_food/models/rating.dart';
import 'package:gebeta_food/scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';

class AllReviews extends StatefulWidget {
  final MainModel model;
  final String restaurantName;
  AllReviews(this.model, this.restaurantName);

  @override
  _AllReviewsState createState() => _AllReviewsState();
}

class _AllReviewsState extends State<AllReviews> {
  @override
  void initState() {
    widget.model.getReview();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.restaurantName +" Reviews"),
        ),
        body: ScopedModelDescendant<MainModel>(
            builder: (context, Widget child, MainModel model) {
          return _buildReviewList(model.fetchReviews);
        }));
  }

  Widget _buildReviewList(List<Rating> ratings) {
    Widget reviewCards;
    if (ratings.length > 0) {
      reviewCards = ListView.builder(
        itemBuilder: (BuildContext context, int index) => ReviewCard(index),
        itemCount: ratings.length,
        shrinkWrap: true,
      );
    }
    else{
      reviewCards = Container();
    }

    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: [
          reviewCards,
        ],
      ),
    );
  }
}
