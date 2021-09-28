import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gebeta_food/Screens/restaurant/restaurant.dart';
import 'package:gebeta_food/models/restaurant.dart';
import 'package:gebeta_food/scoped-models/main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:scoped_model/scoped_model.dart';

import '../../constants.dart';

class RestaurantCard extends StatelessWidget {
  final int restaurantIndex;

  RestaurantCard(this.restaurantIndex);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (context, Widget child, MainModel model) {
        Restaurant restaurantModel = model.displayRestaurants[restaurantIndex];
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: GestureDetector(
            onTap: () async {
              var address = await model.obtainPlaceName(
                  LatLng(restaurantModel.latitude, restaurantModel.longtiude));

              print("Restaurant clicked");
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => new RestaurantScreen(
                        restaurantModel, model, restaurantModel.id, address['addressName'])),
              );
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
                      tag: restaurantModel.name,
                      child: Image.network(
                        "$baseUrl/images/${restaurantModel.id}/${restaurantModel.image}",
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
                              restaurantModel.name,
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
                                  color: restaurantModel.isApproved
                                      ? Color(0xff0267C1).withOpacity(0.65)
                                      : Colors.red.withOpacity(0.65),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Text(
                                restaurantModel.status ? "Open" : "Closed",
                                style: TextStyle(color: whiteColor),
                              ),
                            )
                          ],
                        ),
                        Container(
                          child: RatingBarIndicator(
                            rating: 4,
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
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In feugiat pretium quam a maximus. In sodales interdum diam, eget porttitor justo ullamcorper sit amet. ',
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
      },
    );
  }
}
