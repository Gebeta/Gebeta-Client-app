import 'package:flutter/material.dart';
import 'package:gebeta_food/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/home');
                          },
                          icon: Icon(Icons.arrow_back_ios),
                        ),
                        Text(
                          "Profile",
                          style: TextStyle(fontSize: 25),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.shopping_cart))
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 20, bottom: 20, left: 5),
                decoration: BoxDecoration(
                    // color: Colors.red,
                    border: Border(
                        bottom:
                            BorderSide(color: Colors.grey.withOpacity(0.3)))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      ClipOval(
                        child: Stack(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              child: Image.asset(
                                "assets/images/profile.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Client Name",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "test@test.com",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: gTextLightColor,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              "Phone No",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: gTextLightColor,
                                  fontWeight: FontWeight.w300),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/edit_profile");
                          },
                          icon: Icon(
                            Icons.navigate_next,
                            color: gTextLightColor.withOpacity(0.5),
                            size: 30,
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
