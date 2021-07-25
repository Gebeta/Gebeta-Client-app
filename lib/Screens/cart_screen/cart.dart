import 'package:flutter/material.dart';
import 'package:gebeta_food/constants.dart';

class MyCartPage extends StatefulWidget {
  const MyCartPage({Key? key}) : super(key: key);

  @override
  _MyCartPageState createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff9efeb),
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("My Cart"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(10.0)
            ),
            margin: EdgeInsets.symmetric(horizontal: 23,vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 10.0),
                  child: Text("Delivery At",
                     style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 17.0,
                      color: gTextLightColor),
                  ),
                ),
                TextButton(onPressed: (){}, child: Text("Location Name"))
              ]
            ),
          ),
          ListView.separated(
              shrinkWrap: true,
              itemBuilder: (BuildContext context, index) {
                if (index < 3) {
                  return Dismissible(
                    onDismissed: (DismissDirection direction) {
                      if (direction == DismissDirection.endToStart) {
                        _showWarningDialog(context);
                      }
                    },
                    key: UniqueKey(),
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      height: 120.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                            child: Image(
                              height: 150.0,
                              width: 150.0,
                              image: AssetImage("assets/images/food.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text("Food Name"), Text("Price")],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (count > 1) {
                                      count--;
                                    }
                                  });
                                },
                                icon: Icon(Icons.remove_circle),
                                color: gsecondaryColor,
                                iconSize: 27,
                              ),
                              Text(count.toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "Montserrat",
                                  )),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    count++;
                                  });
                                },
                                icon: Icon(Icons.add_circle),
                                color: gsecondaryColor,
                                iconSize: 27,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      _buildRow("Sub Total", 450.0),
                      _buildRow("Shipping", 450.0),
                      _buildRow("Total", 450.0),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, index) {
                return Container();
              },
              itemCount: 4),
        ],
      ),
          bottomSheet: Container(
            height: 60.0,
            width: MediaQuery.of(context).size.width,
            
            decoration: BoxDecoration(
              color: gsecondaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0,-1),
                  blurRadius: 6.0
                )
              ]
            ),
            child: TextButton(onPressed: (){

            }, child: Text("Checkout",
            style: TextStyle(
              color: whiteColor,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0
            ),)),
          ),
    );
  }

  Widget _buildRow(String label, double price) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 19, color: gTextLightColor),
          ),
          Text(
            price.toString(),
            style: TextStyle(fontSize: 16, color: gTextLightColor),
          )
        ],
      ),
    );
  }

  _showWarningDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('This action cannot be undone!'),
            actions: <Widget>[
              TextButton(
                child: Text('DISCARD'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text('CONTINUE'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
