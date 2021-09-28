import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gebeta_food/Screens/cart_screen/cart.dart';
import 'package:gebeta_food/Screens/home_screen/home_page.dart';
import 'package:gebeta_food/Screens/home_screen/landing_page.dart';
import 'package:gebeta_food/Screens/orders/completed_order.dart';
import 'package:gebeta_food/Screens/orders/order.dart';
import 'package:gebeta_food/Screens/orders/pending_orders.dart';
import 'package:gebeta_food/Screens/restaurant/restaurants.dart';
import 'package:gebeta_food/Screens/review_screen/review_sceen.dart';
import 'package:gebeta_food/Screens/user_profile/edit_profile.dart';
import 'package:gebeta_food/Screens/user_profile/profile_screen.dart';
import 'package:gebeta_food/constants.dart';
import 'package:gebeta_food/home_page.dart';
import 'package:scoped_model/scoped_model.dart';
import 'Screens/auth_screen/login_page.dart';
import 'Screens/auth_screen/sign_up_otp.dart';
import 'scoped-models/main.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MainModel _model = MainModel();

  @override
  void initState() {
    _model.autoAuthenthicate();
    super.initState();
    // _model.getProfile("612f3bac8b26e6ca13d25495");
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        title: 'Gebeta Food Delivery',
        theme: ThemeData(
          // brightness: Brightness.dark,
          primaryColor: gsecondaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: "Montserrat",
        ),
        debugShowCheckedModeBanner: false,
        // home: PaymentOptions(),
        // home: ReviewScreen(),
        routes: {
          '/': (context) => _model.getUser.id == ""
              ? HomeScreen()
              : MyHomePage(model: _model),
          '/login': (context) => LoginPage(),
          '/home': (context) => MyHomePage(model: _model),
          // '/profile': (context) => ProfileScreen(_model),
          '/restaurants': (context) => AllRestaurantsPage(_model),
          '/edit_profile': (context) => EditProfilePage(_model),
          '/my_cart': (context) => MyCartPage(_model),
          '/completed_orders': (context) => CompletedOrder(_model),
          '/pending_orders': (context) => PendingOrder(_model),
          '/orders': (context) => OrderScreen(_model),
          '/phone_ver': (context) => LoginScreen()
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => MyHomePage(
                    model: _model,
                  ));
        },
      ),
    );
  }
}
