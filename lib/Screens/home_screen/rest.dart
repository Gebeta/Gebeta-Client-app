import 'package:flutter/material.dart';
import 'package:gebeta_food/Screens/home_screen/restaurant_card.dart';
import 'package:gebeta_food/scoped-models/main.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:scoped_model/scoped_model.dart';
import 'package:gebeta_food/models/restaurant.dart';

class Restaurants extends StatefulWidget {
  final MainModel model;
  Restaurants(this.model);

  @override
  _RestaurantsState createState() => _RestaurantsState();
}

class _RestaurantsState extends State<Restaurants> {
  @override
  void initState() {
    super.initState();
    widget.model.getRestaurants();
    // print( widget.model.getRestaurants());
  }

  Widget _buildRestaurantList(List<Restaurant> restaurants) {
    Widget restaurantCards;
    if (restaurants.length > 0) {
      restaurantCards = ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) => RestaurantCard(index),
        itemCount: 2,
      );
    } else {
      restaurantCards = Container();
    }
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: [
          restaurantCards,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (context, Widget child, MainModel model) {
        return _buildRestaurantList(model.displayRestaurants);
      },
    );
  }
}
