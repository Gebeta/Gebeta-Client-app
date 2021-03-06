import 'package:flutter/material.dart';
import 'package:gebeta_food/Screens/home_screen/food_card.dart';
import 'package:gebeta_food/Screens/home_screen/restaurant_card.dart';
import 'package:gebeta_food/models/item.dart';
import 'package:gebeta_food/scoped-models/main.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:scoped_model/scoped_model.dart';
import 'package:gebeta_food/models/restaurant.dart';

class Items extends StatefulWidget {
  final MainModel model;
  Items(this.model);

  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  @override
  void initState() {
    super.initState();
    widget.model.fetchItems();
  }

  Widget _buildPopularFoodList(List<Item> items) {
    Widget itemCards;
    if (items.length > 0) {
      itemCards = ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) => FoodCard(index),
        itemCount: items.length,
      );
    } else {
      itemCards = Container();
    }
    return Container(
      height: 250,
      child: itemCards,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (context, Widget child, MainModel model) {
        return _buildPopularFoodList(model.displayItems);
      },
    );
  }
}
