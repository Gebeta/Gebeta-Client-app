import 'package:flutter/material.dart';
import 'package:gebeta_food/Screens/auth_screen/phone.dart';
import 'package:gebeta_food/Screens/cart_screen/cart.dart';
import 'package:gebeta_food/Screens/home_screen/home_page.dart';
import 'package:gebeta_food/Screens/home_screen/landing_page.dart';
import 'package:gebeta_food/Screens/orders/orders.dart';
import 'package:gebeta_food/Screens/restaurant/restaurants.dart';
import 'package:gebeta_food/Screens/user_profile/edit_profile.dart';
import 'package:gebeta_food/Screens/user_profile/profile_screen.dart';
import 'package:gebeta_food/constants.dart';
import 'package:gebeta_food/home_page.dart';
import 'Screens/auth_screen/login_page.dart';
import 'Screens/auth_screen/signup_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gebeta Food Delivery',
      theme: ThemeData(
        // brightness: Brightness.dark,
        primaryColor: gsecondaryColor,
        fontFamily: "Montserrat"
      ),
      home: HomeScreen(),
      // home: HomeScreen(),
      routes: {
        '/login': (context)=>LoginPage(),
       '/signup':(context)=>SignUpPage(),
       '/home':(context)=>MyHomePage(),
       '/profile':(context)=>ProfileScreen(),
       '/restaurants':(context)=>AllRestaurantsPage(),
       '/edit_profile':(context)=>EditProfilePage(),
       '/selectTopics':(context)=>SelectTopicsPage(),
       '/my_cart':(context)=>MyCartPage(),
       '/my_orders': (context)=>AllOrdersScreen(),
       '/phone_ver': (context)=>PhoneVerification(),
     },
    );
  }
}
