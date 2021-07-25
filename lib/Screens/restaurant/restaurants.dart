import 'package:flutter/material.dart';
import 'package:gebeta_food/Screens/home_screen/restaurants_list.dart';


class AllRestaurantsPage extends StatelessWidget {
  const AllRestaurantsPage({Key? key}) : super(key: key);

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
        body: ListView(
          children: [
            RestaurantsList(),
            RestaurantsList()
            
          ],
        ));
  }
}
