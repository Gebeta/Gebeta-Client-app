import 'dart:convert';
import 'package:gebeta_food/constants.dart';
import 'package:gebeta_food/models/profile.dart';
import 'package:gebeta_food/models/rating.dart';
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
  List<Order> _activeOrder = [];
  List<Order> _order = [];
  List<Order> _completedOrder = [];
  List<Rating> _ratings = [];
  late Profile profile;
  User _authenticatedUser = User(id: "", email: "", token: "");

  Profile userProfile = Profile(
      id: "",
      firstName: '',
      lastName: '',
      email: '',
      phoneNo: '',
      address: '',
      password: '');
  // double totalAmount = 0.0;

  List<Cart> _cart = [];
}

mixin UserModel on AllModels {
  User get getUser {
    return _authenticatedUser;
  }

  fetchUser() async {
    if (_authenticatedUser.id != "") {
      Uri url = Uri.parse("$baseUrl/client/${_authenticatedUser.id}");
      return http.get(url).then((http.Response response) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        profile = Profile(
            id: responseData['_id'],
            firstName: responseData['first_name'],
            lastName: responseData['last_name'],
            email: responseData['email'],
            phoneNo: responseData['phone_no'],
            address: responseData['address'],
            password: responseData['password']);
        print("bubu");
        print(profile.firstName);
      });
    } else {
      print("You arenot logged in");
    }
  }

  Profile get getUserProfile {
    return profile;
  }

  Future<Map<String, dynamic>> checkExsitingUser(phoneNo) async {
    final Map<String, dynamic> userData = {"phone_no": phoneNo};
    Uri url = Uri.parse("$baseUrl/auth/checkUser");

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
    Uri url = Uri.parse("$baseUrl/auth/clientsignup");
    final http.Response response = await http.post(url,
        body: json.encode(userData),
        headers: {'Content-Type': 'application/json'});

    final Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);
    bool hasError = true;
    String message = 'Something went wrong';
    if (responseData['error'] == true) {
      hasError = true;
      message = responseData['message'];
    } else {
      hasError = false;
      message = "Signed Up successfully";
      profile = Profile(
        id: responseData['id'],
        firstName: responseData['first_name'],
        lastName: responseData['last_name'],
        email: responseData['email'],
        phoneNo: responseData['phone_no'],
        address: responseData['address'],
        password: responseData['password'],
      );
      _authenticatedUser = User(
          id: responseData['_id'], email: email, token: responseData['token']);

      SharedPreferences preferences = await SharedPreferences.getInstance();

      preferences.setString("token", responseData['token']);
      preferences.setString("userEmail", email);
      preferences.setString("userId", responseData['_id']);
    }
    notifyListeners();
    return {'success': !hasError, 'message': message};
  }

  Future<Map<String, dynamic>> login(String password, String email) async {
    final Map<String, dynamic> authData = {
      "email": email,
      "password": password,
    };

    Uri url = Uri.parse("$baseUrl/auth/clientlogin");
    final http.Response response = await http.post(url,
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'});

    final Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);

    bool hasError = true;
    String message = 'Something went wrong';
    if (responseData['error'] == true) {
      hasError = true;
      message = responseData['message'];
    } else {
      hasError = false;
      message = "Logged in successfully";
      _authenticatedUser = User(
          id: responseData['_id'], email: email, token: responseData['token']);

      profile = Profile(
        id: responseData['id'],
        firstName: responseData['first_name'],
        lastName: responseData['last_name'],
        email: responseData['email'],
        phoneNo: responseData['phone_no'],
        address: responseData['address'],
        password: responseData['password'],
      );
      SharedPreferences preferences = await SharedPreferences.getInstance();

      preferences.setString("token", responseData['token']);
      preferences.setString("userEmail", email);
      preferences.setString("userId", responseData['_id']);
    }
    notifyListeners();
    return {'success': !hasError, 'message': message};
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

  //  Future<Profile> getProfile(String id) async {
  //   Uri url =
  //       Uri.parse("$baseUrl/client/$id");
  //   final http.Response response =
  //       await http.get(url, headers: {'Content-Type': 'application/json'});
  //   if (response.statusCode == 200) {
  //     final List<dynamic> profile = json.decode(response.body);
  //     print(profile[0]);
  //     Profile userProfile = Profile(
  //       id: id,
  //       firstName: profile[0]['first_name'],
  //       lastName: profile[0]['last_name'],
  //       email: profile[0]['email'],
  //       phoneNo: profile[0]['phone_no'],
  //       address: profile[0]['address'],
  //       password: profile[0]['password'],
  //     );
  //     print(userProfile.email);

  //     // return Profile.fromJson(jsonDecode(response.body));
  //     return userProfile;
  //   } else {
  //     // return {'success': false, 'Profile': Null};
  //     throw Exception('Failed to load album');
  //   }
  // }

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
    Uri url = Uri.parse("$baseUrl/restaurant");
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
            rating: 3,
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
    Uri url = Uri.parse("$baseUrl/items");
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
            restaurantName: data['restaurant_id']['name'],
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

  removeFromCart(int cartIndex) {
    _cart.removeAt(cartIndex);
    notifyListeners();
  }
}

mixin OrderModel on AllModels {
  List<Order> get getOrderList {
    return List.from(_order);
  }

  List<Order> get getActiveOrderList {
    return List.from(_activeOrder);
  }

  List<Order> get getCompletedOrderList {
    return List.from(_completedOrder);
  }

  Future<Null> createOrder(String id, String restaurantId, String clientId,
      double totalPrice, List<Cart> cartItems) async {
    List<dynamic> items = [];
    // location object to be added
    cartItems.forEach((element) {
      items.add({
        "id": element.id,
        "imageUrl": [element.image],
        "description": element.description,
        "name": element.name,
        "price": element.price,
        "menuStatus": true,
        "quantity": element.quantity
      });
    });

    final Map<String, dynamic> orderData = {
      "restaurantId": restaurantId,
      "clientId": clientId,
      "totalPrice": totalPrice,
      "isAcitive": true,
      "items": items,
    };

    Uri url = Uri.parse("$baseUrl/order");

    final http.Response response = await http.post(url,
        body: json.encode(orderData),
        headers: {'Content-Type': 'application/json'});

    final Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);

    notifyListeners();
  }

  getActiveOrders() async {
    Uri url = Uri.parse("$baseUrl/order/activeorders");
    return http.get(url).then((http.Response response) {
      final List<Order> fetchedOrders = [];

      final List<dynamic> orderList = json.decode(response.body);
      // print("yooo");
      // print(orderList[0]['items'][0]['quantity']);
      orderList.forEach((dynamic data) {
        Order order = Order(
          id: data['id'],
          restaurantId: data['restaurant_id']['name'],
          clientId: data['client_id']['_id'],
          clientName: data['client_id']['first_name'] +
              " " +
              data['client_id']['last_name'],
          totalPrice: data['totalPrice'].toDouble(),
          shippingFee: data["deliveryfee"].toDouble(),
          isAcitive: data['isAcitive'],
          items: data['items'],
        );
        fetchedOrders.add(order);
      });
      _activeOrder = fetchedOrders.where((Order order) {
        return order.clientId == _authenticatedUser.id;
      }).toList();
      print("OLA id " + fetchedOrders[0].items[1].toString());
      notifyListeners();
    });
  }

  getCompletedOrders() async {
    Uri url = Uri.parse("$baseUrl/order/completedorders");
    return http.get(url).then((http.Response response) {
      final List<Order> fetchedOrders = [];

      final List<dynamic> orderList = json.decode(response.body);
      print(orderList);
      orderList.forEach((dynamic data) {
        Order order = Order(
          id: data['id'],
          restaurantId: data['restaurant_id']['name'],
          clientId: data['client_id']['_id'],
          clientName: data['client_id']['first_name'] +
              " " +
              data['client_id']['last_name'],
          totalPrice: data['totalPrice'].toDouble(),
          shippingFee: data["deliveryfee"].toDouble(),
          isAcitive: data['isAcitive'],
          items: data['items'],
        );
        fetchedOrders.add(order);
      });
      _completedOrder = fetchedOrders;
      print("OLA id " + fetchedOrders.length.toString());
      notifyListeners();
    });

    // final Order newProduct = Order(
    //     id: responseData['name'],
    //     title: title,
    //     description: description,
    //     image: image,
    //     price: price,
    //     userEmail: _authenticatedUser.email,
    //     userId: _authenticatedUser.id);
    // _products.add(newProduct);
  }
}

mixin ReviewModel on AllModels {
  List<Rating> get fetchReviews {
    return List.from(_ratings);
  }

  Future<Null> getReview() {
    Uri url = Uri.parse("$baseUrl/rate");
    return http.get(url).then((http.Response response) {
      final List<Rating> fetchedRates = [];

      final List<dynamic> rateList = json.decode(response.body);
      print(rateList);
      rateList.forEach((dynamic data) {
        Rating restaurant = Rating(
            id: data['_id'],
            comment: data['comment'],
            rating: data['rating'].toDouble(),
            likes: data['likes']);

        fetchedRates.add(restaurant);
      });
      _ratings = fetchedRates;
      // print("OLA" + _restaurants.length.toString());
      notifyListeners();
    });
  }

  Future<Null> createReview(String restaurantId, String clientId,
      String orderId, double rating, String comment) async {
    Uri url = Uri.parse("$baseUrl/rate");

    final Map<String, dynamic> rateData = {
      "restaurantd": restaurantId,
      "clientId": clientId,
      "order_id": orderId,
      "rating": rating,
      "comment": comment,
    };
    print(json.encode(rateData));

    final http.Response response = await http.post(url,
        body: json.encode(rateData),
        headers: {'Content-Type': 'application/json'});

    final Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);
  }

  fetchAllReviews() {
    Uri url = Uri.parse("$baseUrl/rate");
    return http.get(url).then((http.Response response) {
      final List<Rating> fetchedReviews = [];

      final List<dynamic> ratingList = json.decode(response.body);
      // print(ratingList);
      ratingList.forEach((dynamic data) {
        Rating rating = Rating(
            id: data['_id'],
            comment: data['comment'],
            rating: data['rating'],
            likes: data['likes']);

        // fetchedReviews.add(rating);
        _ratings.add(rating);
      });
      // _ratings = fetchedReviews;
      print("OLA id OLA OLA" + fetchedReviews[0].id);
      notifyListeners();
    });
  }

  likeAReview(String id) async {
    Uri url = Uri.parse('$baseUrl/rate/update/$id');
    // print(json.encode({"id" : id}));
    print("Id" + id);
    final Map<String, dynamic> idData = {
      "uniqueId": "613944bc3935702bfe53f578"
    };
    print(jsonEncode(idData));
    http.Response response = await http.put(url);
    Map<String, dynamic> responseData = json.decode(response.body);

    print(responseData);

    notifyListeners();
  }
}
