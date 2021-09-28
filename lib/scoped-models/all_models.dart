import 'dart:convert';
import 'package:gebeta_food/constants.dart';
import 'package:gebeta_food/mapapi.dart';
import 'package:gebeta_food/models/address.dart';
import 'package:gebeta_food/models/direction_detail.dart';
import 'package:gebeta_food/models/profile.dart';
import 'package:gebeta_food/models/rating.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  List<Item> _itemsByRestarant = [];
  List<Order> _activeOrder = [];
  List<Order> _order = [];
  List<Order> _completedOrder = [];
  List<Rating> _ratings = [];
  late Profile profile;
  User _authenticatedUser = User(id: "", email: "", token: "");
  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  Restaurant restaurant = Restaurant(
    id: "",
    name: "",
    address: "",
    phoneNo: "",
    email: "",
    image: "",
    rating: 0.0,
    latitude: 0.0,
    longtiude: 0.0,
    isApproved: false,
    status: false,
  );

  Profile userProfile = Profile(
      id: "",
      firstName: '',
      lastName: '',
      email: '',
      phoneNo: '',
      addressName: '',
      locationLatitude: 0.0,
      locationLongtiude: 0.0,
      password: '');
  // double totalAmount = 0.0;

  List<Cart> _cart = [];

  auth(token) {
    return {
      "Content-type": "application/json",
      "Authorization": "Bearer " + token
    };
  }
}

mixin UserModel on AllModels {
  User get getUser {
    return _authenticatedUser;
  }

  addProfilePicture(image, latitude, longtidue, id) async {
    print("latlng");
    print(latitude);
    Uri url = Uri.parse("$baseUrl/client/uploadProfile");
    Address userAddress = Address(latitude, longtidue);
    var request = http.MultipartRequest("POST", url);
    request.fields['clientId'] = id;
    request.fields['address'] = jsonEncode(userAddress);
    var pic = await http.MultipartFile.fromPath("clientImg", image.path);
    request.files.add(pic);
    var response = await request.send();

    var responseData = response.stream.toBytes();
    // var responseString = String.fromCharCodes(responseData);
    print(responseData);
    // final http.Response response = await http.post(url,body: json.encode(userData));
  }

  addCategory(List<String> categories, price, id) async {
    Uri url = Uri.parse("$baseUrl/client/$id");
    print("nnn");
    print(categories);
    print(price);
    final Map<String, dynamic> categoryData = {
      "catagory": categories,
      "price": price,
    };
    print(json.encode(categoryData));
    http.Response response = await http.put(url,
        body: json.encode(categoryData),
        headers: {"Content-Type": "application/json"});
    final Map<String, dynamic> responseData = json.decode(response.body);
    print("responseData");
    print(responseData);
  }

  fetchUser() async {
    if (_authenticatedUser.id != "") {
      Uri url = Uri.parse("$baseUrl/client/${_authenticatedUser.id}");
      return http.get(url).then((http.Response response) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        var add = jsonDecode(responseData['address']);
        profile = Profile(
            id: responseData['_id'],
            firstName: responseData['first_name'],
            lastName: responseData['last_name'],
            email: responseData['email'],
            phoneNo: responseData['phone_no'],
            addressName: responseData['address'],
            locationLatitude: add['latitude'],
            locationLongtiude: add['longtiude'],
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
        body: json.encode(userData), headers: auth(_authenticatedUser.token));

    final Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);
    if (responseData['message'] == "UserExists") {
      return {"UserExists": true};
    } else {
      return {"UserExists": false};
    }
  }

  Future<Map<String, dynamic>> signUp(
    String fname,
    String lname,
    String password,
    String email,
    String phoneNo,
  ) async {
    final Map<String, dynamic> userData = {
      "first_name": fname,
      "last_name": lname,
      "password": password,
      "email": email,
      "phone_no": phoneNo,
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
      var address = jsonDecode(responseData['address']);
      profile = Profile(
        id: responseData['_id'],
        firstName: responseData['first_name'],
        lastName: responseData['last_name'],
        email: responseData['email'],
        phoneNo: responseData['phone_no'],
        addressName: responseData['address'],
        locationLatitude: address['latitude'],
        locationLongtiude: address['longtiude'],
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
    return {
      'success': !hasError,
      'message': message,
      'id': _authenticatedUser.id
    };
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
        addressName: responseData['address'],
        locationLatitude: 0.0,
        locationLongtiude: 0.0,
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
    return http.get(url, headers: auth(_authenticatedUser.token)).then((
      http.Response response,
    ) {
      final List<Restaurant> fetchedRestaurants = [];

      final List<dynamic> restaurantList = json.decode(response.body);
      print(restaurantList);
      restaurantList.forEach((dynamic data) {
        var add = jsonDecode(data['address']);
        Restaurant restaurant = Restaurant(
            id: data['_id'],
            name: data['name'],
            address: "summit",
            phoneNo: data['phone_no'],
            email: data['email'],
            image: data['restPic'],
            rating: 3,
            latitude: add["lat"],
            longtiude: add["lng"],
            status: data['status'],
            isApproved: data['is_approved']);
        fetchedRestaurants.add(restaurant);
      });
      _restaurants = fetchedRestaurants;
      // print("OLA" + _restaurants.length.toString());
      notifyListeners();
    });
  }

  Future<Null> getRestaurantById(String id) {
    Uri url = Uri.parse("$baseUrl/restaurant/$id");
    return http.get(url).then((http.Response response) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);

      restaurant = Restaurant(
          id: responseData['id'],
          name: responseData['name'],
          address: responseData['address'],
          phoneNo: responseData['phone_no'],
          email: responseData['email'],
          image: responseData['restPic'],
          rating: responseData['rating'],
          status: responseData['status'],
          latitude: 0.0,
          longtiude: 0.0,
          isApproved: responseData['is_approved']);

      notifyListeners();
    });
  }
}

mixin ItemModel on AllModels {
  List<Item> get displayItems {
    return List.from(_item);
  }

  List<Item> get displayItemsByRestaurant {
    return List.from(_itemsByRestarant);
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
            restaurantName: data['restaurandId']['name'],
            restaurantId: data['restaurandId']['_id'],
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

  checkAvailability(id) {
    Uri url = Uri.parse("$baseUrl/items");
  }

  Future<Null> fetchItemsByRestaurant(id) {
    // print(id);
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
            restaurantName: data['restaurandId']['name'],
            restaurantId: data['restaurandId']['_id'],
            menuStatus: data['isServed'],
            price: data['price'].toDouble(),
            quantity: 1);
        fetchedItems.add(item);
      });

      _itemsByRestarant = fetchedItems.where((Item item) {
        print(item.restaurantId);
        return item.restaurantId == id;
      }).toList();
      print("OLA id ola OLA");
      print(_itemsByRestarant);
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

  bool checkRestaurant(id) {
    print("object" + id);

    List<Cart> carts = getCartList;
    bool isRestaurantSame = true;
    if (carts.length >= 1) {
      // print(carts[0].restaurantId);
      if (carts[0].restaurantId != id) {
        isRestaurantSame = false;
      } else {
        isRestaurantSame = true;
      }
    }
    print("ollla");
    print(isRestaurantSame);
    return isRestaurantSame;
  }

  addToCart(id, name, image, price, quantity, description, restaurantId) {
    Cart cartItem = Cart(
      id: id,
      name: name,
      description: description,
      image: image,
      price: price,
      restaurantId: restaurantId,
      quantity: quantity,
    );
    _cart.add(cartItem);
  }

  resetCart() {
    _cart.clear();
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

  Future<Map<String, dynamic>> createOrder(String restaurantId,
      double totalPrice, double deliveryfee, List<Cart> cartItems) async {
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

    var restPosition = await getRestaurantLocation2(restaurantId);
    var position = await getUserLocation(_authenticatedUser.id);

    final Map<String, dynamic> orderData = {
      "restaurantId": restaurantId,
      "clientId": _authenticatedUser.id,
      "totalPrice": totalPrice,
      "deliveryfee": deliveryfee,
      "isAcitive": true,
      "items": items,
      "position": position,
      "rest_position": restPosition
    };

    Uri url = Uri.parse("$baseUrl/order");

    final http.Response response = await http.post(url,
        body: json.encode(orderData),
        headers: {'Content-Type': 'application/json'});

    final Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);
    bool hasError = true;
    String message = 'Something went wrong';
    if (response.statusCode == 200) {
      hasError = false;
      message = "Order created successfully";
    } else {
      hasError = true;
      message = responseData['message'];
    }
    notifyListeners();
    return {'success': !hasError, 'message': message};
  }

  getActiveOrders({reload}) async {
    if (reload == true) {
      _isLoading = false;
    } else {
      _isLoading = true;
    }
    Uri url = Uri.parse("$baseUrl/order/activeorders");
    return http.get(url).then((http.Response response) {
      final List<Order> fetchedOrders = [];

      final List<dynamic> orderList = json.decode(response.body);
      // print("yooo");
      // print(orderList[0]['items'][0]['quantity']);
      orderList.forEach((dynamic data) {
        Order order = Order(
          id: data['id'],
          driverId: data['driverId'],
          restaurantId: data['restaurant_id']['name'],
          clientId: data['client_id']['_id'],
          clientName: data['client_id']['first_name'] +
              " " +
              data['client_id']['last_name'],
          totalPrice: data['totalPrice'].toDouble(),
          shippingFee: data["deliveryfee"].toDouble(),
          isAcitive: data['isAcitive'],
          status: data['status'],
          items: data['items'],
        );

        fetchedOrders.add(order);
      });
      _activeOrder = fetchedOrders.where((Order order) {
        return order.clientId == _authenticatedUser.id;
      }).toList();
      // print("OLA id ");
      // print(fetchedOrders[0].clientName);
      notifyListeners();
    });
  }

  getAllOrders() async{
    Uri url = Uri.parse("$baseUrl/order");
    return http.get(url).then((http.Response response) {
      final List<Order> fetchedOrders = [];

      final List<dynamic> orderList = json.decode(response.body);
      print(orderList);
      orderList.forEach((dynamic data) {
        Order order = Order(
          id: data['id'],
          driverId: data['driverId'],
          restaurantId: data['restaurant_id']['name'],
          clientId: data['client_id']['_id'],
          clientName: data['client_id']['first_name'] +
              " " +
              data['client_id']['last_name'],
          totalPrice: data['totalPrice'].toDouble(),
          shippingFee: data["deliveryfee"].toDouble(),
          isAcitive: data['isAcitive'],
          status: data['status'],
          items: data['items'],
        );
        fetchedOrders.add(order);
      });
      _order = fetchedOrders.where((Order order) {
        return order.clientId == _authenticatedUser.id;
      }).toList();
      print("OLA id " + fetchedOrders.length.toString());
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
          driverId: data['driverId'],
          restaurantId: data['restaurant_id']['name'],
          clientId: data['client_id']['_id'],
          clientName: data['client_id']['first_name'] +
              " " +
              data['client_id']['last_name'],
          totalPrice: data['totalPrice'].toDouble(),
          shippingFee: data["deliveryfee"].toDouble(),
          isAcitive: data['isAcitive'],
          status: data['status'],
          items: data['items'],
        );
        fetchedOrders.add(order);
      });
      _completedOrder = fetchedOrders.where((Order order) {
        return order.clientId == _authenticatedUser.id;
      }).toList();
      print("OLA id " + fetchedOrders.length.toString());
      notifyListeners();
    });
  }

  getRestaurantLocation2(String id) async {
    Uri url = Uri.parse("$baseUrl/restaurant/$id");
    http.Response response = await http.get(url);
    final Map<String, dynamic> responseData = json.decode(response.body);

    var addressJson = jsonDecode(responseData['address']);
    Address restaurantAddress = Address(addressJson["lat"], addressJson["lng"]);

    String jsonrRestaurant = jsonEncode(restaurantAddress);
    return jsonrRestaurant;
  }

  getRestaurantLocation(String id) async {
    Uri url = Uri.parse("$baseUrl/restaurant/$id");
    http.Response response = await http.get(url);
    final List<dynamic> responseData = json.decode(response.body);

    var addressJson = jsonDecode(responseData[0]['address']);
    Address restaurantAddress = Address(addressJson["lat"], addressJson["lng"]);

    String jsonrRestaurant = jsonEncode(restaurantAddress);
    print("restaurant");
    print(jsonrRestaurant);
    return jsonrRestaurant;
  }

  getDriverLocation(String id) async {
    Uri url = Uri.parse("$baseUrl/driver/$id");
    http.Response response = await http.get(url);
    final List<dynamic> responseData = json.decode(response.body);

    var addressJson = jsonDecode(responseData[0]['address']);
    Address restaurantAddress = Address(addressJson["lat"], addressJson["lng"]);

    String jsonrRestaurant = jsonEncode(restaurantAddress);
    print("Driver");
    print(jsonrRestaurant);
    return jsonrRestaurant;
  }

  getUserLocation(id) async {
    Uri url = Uri.parse("$baseUrl/client/$id");
    http.Response response = await http.get(url);
    final Map<String, dynamic> responseData = json.decode(response.body);
    // print(responseData["location"]['coordinates']);

    var addressJson = jsonDecode(responseData['address']);
    Address userAddress =
        Address(addressJson["latitude"], addressJson["longtiude"]);
    print("uSER");
    print(userAddress);
    String jsonUser = jsonEncode(userAddress);
    return jsonUser;
  }

  obtainPlaceName(LatLng userLocation) async {
    String addressName = "";
    print("bjhjk");
    print(userLocation);

    String geocodeUrl =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${userLocation.latitude},${userLocation.longitude}&key=AIzaSyAQ7HIJpfOrh3s-PqSmxVRhqBv9uxy5JLg";

    Uri url = Uri.parse(geocodeUrl);

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      addressName = responseData['results'][0]['formatted_address'];
    }
    print("address name");
    print(addressName);
    return {"addressName": addressName};
  }

  // Future<DirectionDetails>
  obtainPlacesDirectionDetails(restaurantLocation, userLocation) async {
    var addressJson = jsonDecode(restaurantLocation);
    var addressUserJson = jsonDecode(userLocation);

    double pickupLocationLatitude = addressJson["latitude"];
    double pickupLocationLongtiude = addressJson["longtiude"];
    double dropoffLocationLatitude = addressUserJson['latitude'];
    double dropoffLocationLongtiude = addressUserJson['longtiude'];

    print("Henok");
    print(
        "restaurant's $pickupLocationLatitude, $pickupLocationLongtiude, user's $dropoffLocationLatitude, $dropoffLocationLongtiude");
    String directionUrl =
        "https://maps.googleapis.com/maps/api/directions/json?origin=$pickupLocationLatitude,$pickupLocationLongtiude&destination=$dropoffLocationLatitude,$dropoffLocationLongtiude&key=$APIkey";

    http.Response responseDirection = await http.get(Uri.parse(directionUrl));

    if (responseDirection.statusCode == 200) {
      Map<String, dynamic> responseDataDirection =
          json.decode(responseDirection.body);
      print(responseDataDirection);
      DirectionDetails directionDetails = DirectionDetails(
        distanceValue: responseDataDirection["routes"][0]["legs"][0]["distance"]
            ["value"],
        durationValue: responseDataDirection["routes"][0]["legs"][0]["duration"]
            ["value"],
        distanceText: responseDataDirection["routes"][0]["legs"][0]["distance"]
            ["text"],
        durationText: responseDataDirection["routes"][0]["legs"][0]["duration"]
            ["text"],
        encodedPoints: responseDataDirection["routes"][0]["overview_polyline"]
            ["points"],
      );
      return directionDetails;
    } else {
      DirectionDetails directionDetails = DirectionDetails(
          distanceValue: 0,
          durationValue: 0,
          distanceText: "",
          durationText: "",
          encodedPoints: "encodedPoints");
      return directionDetails;
    }
  }

  double calculateFare(DirectionDetails directionDetails) {
    // double timeFare = (directionDetails.durationValue /60)*0.2;
    double distanceFare = (directionDetails.distanceValue / 1000) * 8;

    double totalAmountInBirr = 30 + (distanceFare);

    return totalAmountInBirr;
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

  // getRequest(String urlString) async {
  //   Uri url = Uri.parse(urlString);

  //   http.Response response = await http.get(url);

  //   // Map<String, dynamic> responseData = json.decode(response.body);

  //   // print(responseData);
  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> responseData = json.decode(response.body);
  //     return responseData;
  //   } else {
  //     return 'failed';
  //   }
  // }
}
