import 'dart:convert';

import 'package:gebeta_food/models/cart.dart';
import 'package:gebeta_food/models/item.dart';
import 'package:gebeta_food/models/restaurant.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

mixin AllModels on Model {
  List<Restaurant> _restaurants = [];
  List<Item> _item = [];

  double totalAmount = 0.0;

  List<Cart> cart = [];

  double totalPrice(List<Cart> cartItems) {
    for (int i = 0; i < cartItems.length; i++) {
          totalAmount = totalAmount + cartItems[i].price * cartItems[i].quantity;
    }
    return totalAmount;
  }

  addToCart(id, name, image, price, quantity) {
    Cart cartItem = Cart(
      id: id,
      name: name,
      image: image,
      price: price,
      quantity: quantity,
    );
    cart.add(cartItem);
  }

 
  Future<Null> fetchItems() {
    Uri url = Uri.parse("http://192.168.1.11:3000/items");
    return http.get(url).then((http.Response response) {
      final List<Item> fetchedItems = [];

      final List<dynamic> itemList = json.decode(response.body);
      print(itemList);
      itemList.forEach((dynamic data) {
        Item item = Item(
            id: data['_id'],
            name: data['foodName'],
            description: data['description'],
            imageUrl: data['imgLocation'],
            menuStatus: data['isServed'],
            price: data['price'].toDouble(),
            quantity: 1);
        fetchedItems.add(item);
      });
      _item = fetchedItems;
      print("OLA id " + fetchedItems[0].id);
      notifyListeners();
    });
  }

  Future<Null> getRestaurants() {
    Uri url = Uri.parse("http://192.168.1.11:3000/restaurant");
    return http.get(url).then((http.Response response) {
      final List<Restaurant> fetchedRestaurants = [];

      final List<dynamic> restaurantList = json.decode(response.body);
      print(restaurantList);
      restaurantList.forEach((dynamic data) {
        Restaurant restaurant = Restaurant(
            id: data['id'],
            name: data['name'],
            address: "summit",
            phoneNo: "+251925262988",
            email: data['email'],
            rating: data['rating'].toDouble(),
            isApproved: data['is_approved']);
        fetchedRestaurants.add(restaurant);
      });
      _restaurants = fetchedRestaurants;
      // print("OLA" + _restaurants.length.toString());
      notifyListeners();
    });
  }
}

mixin UserModel on AllModels {
  Future<Map<String, dynamic>> signUp(
      String id,
      String fname,
      String lname,
      String username,
      String password,
      String email,
      String phoneNo,
      String address) async {
    final Map<String, dynamic> userData = {
      "id": id,
      "first_name": fname,
      "last_name": lname,
      "username": username,
      "password": password,
      "email": email,
      "phone_no": phoneNo,
      "address": address
    };
    Uri url = Uri.parse("http://192.168.1.11:3000/auth/clientsignup");
    final http.Response response = await http.post(url,
        body: json.encode(userData),
        headers: {'Content-Type': 'application/json'});

    final Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);

    return {'success': true, 'message': "signed up"};
  }

  Future<Map<String, dynamic>> login(String password,String email) async {
    final Map<String, dynamic> authData = {
      "email": email,
      "password": password,
    };
    
    Uri url = Uri.parse("http://192.168.1.11:3000/auth/clientlogin");
    final http.Response response = await http.post(url,
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'});

    final Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);

    return {'success': true, 'message': "signed up"};
  }
}

mixin RestaurantModel on AllModels {
  List<Restaurant> get displayRestaurants {
    return List.from(_restaurants);
  }
}

mixin ItemModel on AllModels {
  List<Item> get displayItems {
    return List.from(_item);
  }
}

mixin CartModel on AllModels {
  List<Cart> get getCartList {
    return List.from(cart);
  }

  bool checkingItem(id){
    List<Cart> items = getCartList;
    bool _isILike;
    var contain = items.where((element) => element.id == id);
      if (contain.isEmpty){
        _isILike = false;
      } else {
        _isILike = true;
      }
    print(_isILike);

    return _isILike;
  }
}
