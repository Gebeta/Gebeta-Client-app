import 'package:flutter/material.dart';
import 'package:gebeta_food/Screens/widgets/others/logo.dart';

import 'constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 100,),
          Logo(),
          SizedBox(height: 180,),
          Container(
              height: 50,
              width: MediaQuery.of(context).size.width*0.8,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [gPrimaryColor, gsecondaryColor],
                  stops: [0,1],
                ),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: InkWell(
                onTap: (){
                  Navigator.pushNamed(context, '/phone_ver');
                },
                child: Center(
                  child: Text("Sign Up", style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width*0.8,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [gsecondaryColor,gPrimaryColor],
                  stops: [0,1],
                ),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: InkWell(
                onTap: (){
                  Navigator.pushNamed(context, '/login');
                  print("Log in clicked");
                },
                child: Center(
                  child: Text("Log In", style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),),
                ),
              ),
            ),
        ],
      )
      
    );
  }
}
