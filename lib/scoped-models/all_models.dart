import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:gebeta_food/models/cart.dart';
import 'package:gebeta_food/models/item.dart';
import 'package:gebeta_food/models/order.dart';
import 'package:gebeta_food/models/restaurant.dart';
import 'package:gebeta_food/models/user.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

mixin AllModels on Model {
  List<Restaurant> _restaurants = [];
  List<Item> _item = [];
  User _authenticatedUser = User(id: "", email: "", token: "");
  // double totalAmount = 0.0;

  List<Cart> _cart = [];
}

mixin UserModel on AllModels {
  User get getUser {
    return _authenticatedUser;
  }

  Future<Map<String, dynamic>> checkExsitingUser(phoneNo) async {
    bool exists;
    final Map<String, dynamic> userData = {"phone_no": phoneNo};
    Uri url = Uri.parse("http://192.168.8.142:3000/auth/checkUser");

    final http.Response response = await http.post(url,
        body: json.encode(userData),
        headers: {'Content-Type': 'application/json'});

    final Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);
    if (responseData['message'] == "UserExists") {
      return {"UserExists": true};
    } else {
      return {"UserExists": false};
    }
  }

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
    Uri url = Uri.parse("http://192.168.8.142:3000/auth/clientsignup");
    final http.Response response = await http.post(url,
        body: json.encode(userData),
        headers: {'Content-Type': 'application/json'});

    final Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);

    _authenticatedUser = User(
        id: responseData['_id'], email: email, token: responseData['token']);

    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString("token", responseData['token']);
    preferences.setString("userEmail", email);
    preferences.setString("userId", responseData['_id']);

    return {'success': true, 'message': "signed up"};
  }

  Future<Map<String, dynamic>> login(String password, String email) async {
    final Map<String, dynamic> authData = {
      "email": email,
      "password": password,
    };

    Uri url = Uri.parse("http://192.168.8.142:3000/auth/clientlogin");
    final http.Response response = await http.post(url,
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'});

    final Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);
    _authenticatedUser = User(
        id: responseData['_id'], email: email, token: responseData['token']);

    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString("token", responseData['token']);
    preferences.setString("userEmail", email);
    preferences.setString("userId", responseData['_id']);

    return {'success': true, 'message': "logged in"};
  }

  void autoAuthenthicate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? token = preferences.getString("token");
    final String? userEmail = preferences.getString("userEmail");
    final String? userId = preferences.getString("userId");
    if (token != null) {
      _authenticatedUser = User(
          id: userId.toString(),
          email: userEmail.toString(),
          token: userEmail.toString());
      notifyListeners();
    }
  }

  void logout() async {
    _authenticatedUser = User(id: "", email: "", token: "");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("token");
    preferences.remove("userEmail");
    preferences.remove("userId");
    notifyListeners();
  }
}

mixin RestaurantModel on AllModels {
  List<Restaurant> get displayRestaurants {
    return List.from(_restaurants);
  }

  Future<Null> getRestaurants() {
    Uri url = Uri.parse("http://192.168.8.142:3000/restaurant");
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

mixin ItemModel on AllModels {
  List<Item> get displayItems {
    return List.from(_item);
  }

  Future<Null> fetchItems() {
    Uri url = Uri.parse("http://192.168.8.142:3000/items");
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
}

mixin CartModel on AllModels {
  List<Cart> get getCartList {
    return List.from(_cart);
  }

  bool checkingItem(id) {
    List<Cart> items = getCartList;
    bool _isILike;
    var contain = items.where((element) => element.id == id);
    if (contain.isEmpty) {
      _isILike = false;
    } else {
      _isILike = true;
    }
    print(_isILike);

    return _isILike;
  }

  addToCart(id, name, image, price, quantity, description) {
    Cart cartItem = Cart(
      id: id,
      name: name,
      description: description,
      image: image,
      price: price,
      quantity: quantity,
    );
    _cart.add(cartItem);
  }

  removeFromCart(int cartIndex){
    _cart.removeAt(cartIndex);
    notifyListeners();
  }
}

mixin OrderModel on AllModels {
  createOrder(String id, String restaurantId, String clientId,
      double totalPrice, List<Cart> cartItems) {
    List<Item> items = [];
    cartItems.forEach((element) {
      items.add(Item(
          id: id,
          imageUrl: [element.image],
          description: element.description,
          name: element.name,
          price: element.price,
          menuStatus: true,
          quantity: element.quantity));
    });

    Order order = Order(
        id: id,
        restaurantId: restaurantId,
        clientId: clientId,
        totalPrice: totalPrice,
        isAcitive: true,
        items: items,
        date: DateFormat('dd-MM-yyyy').format(new DateTime.now()) +
            ' ' +
            DateFormat('kk:mm:a').format(new DateTime.now()));
    print(order.items.length);
  }
}
