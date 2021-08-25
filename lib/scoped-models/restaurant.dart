import 'dart:convert';

import 'package:gebeta_food/models/restaurant.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class RestaurantModel extends Model {
  List<Restaurant> _restaurants = [];

  Future<Null> getRestaurants() {
    Uri url = Uri.parse("");
    return http.get(url).then((http.Response response) {
      final List<Restaurant> fetchedRestaurants = [];

      final Map<String, dynamic> restaurantList = json.decode(response.body);
      restaurantList.forEach((String id, dynamic data) {
        final Restaurant restaurant = Restaurant(
          id: id,
          name: data['name'],
          address: data['address'],
          phoneNo: data['phoneNo'],
          email: data['email'],
          rating: data['rating'], 
          isApproved: data['is_approved'],
        );
        fetchedRestaurants.add(restaurant);
      });
      _restaurants = fetchedRestaurants;
      notifyListeners();
    });
  }

  void getRestaurant() {}
}
