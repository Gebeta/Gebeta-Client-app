import 'package:flutter/material.dart';
import 'package:gebeta_food/Screens/home_screen/restaurant_card.dart';
import 'package:gebeta_food/Screens/home_screen/restaurants_list.dart';
import 'package:gebeta_food/models/restaurant.dart';
import 'package:gebeta_food/scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';

class AllRestaurantsPage extends StatefulWidget {
  final MainModel model;
  AllRestaurantsPage(this.model);

  @override
  _AllRestaurantsPageState createState() => _AllRestaurantsPageState();
}

class _AllRestaurantsPageState extends State<AllRestaurantsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.model.getRestaurants();
  }

  Widget _buildRestaurantList(List<Restaurant> restaurants) {
    Widget restaurantCards;
    if (restaurants.length > 0) {
      restaurantCards = ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) => RestaurantCard(index),
        itemCount: restaurants.length,
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
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text(
          "Restaurants",
          style: TextStyle(fontSize: 22),
        ),
      ),
      body: ScopedModelDescendant<MainModel>(
        builder: (context, Widget child, MainModel model) {
          return _buildRestaurantList(model.displayRestaurants);
        },
      ),
    );
  }
}
