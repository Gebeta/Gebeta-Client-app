import 'package:flutter/material.dart';
import 'package:gebeta_food/home_page.dart';
import 'package:gebeta_food/login_page.dart';
import 'package:gebeta_food/signup_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xffa43c21),
        fontFamily: "Raleway"
      ),
      home: HomeScreen(),
      routes: {
        '/login': (context)=>LoginPage(),
       '/signup':(context)=>SignUpPage(),
     },
    );
  }
}
