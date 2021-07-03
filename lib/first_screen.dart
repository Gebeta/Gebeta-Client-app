import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gebeta Food Delivery"),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Grab Your",
                style: TextStyle(
                  fontSize: 40.0
                ),
              ),
              Text(
                "Delicious Meal!",
                style: TextStyle(
                  fontSize: 40.0
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  labelText: "Search here",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
          ),
          
            ],
          )
          
        ],
      ),
    );
  }
}
