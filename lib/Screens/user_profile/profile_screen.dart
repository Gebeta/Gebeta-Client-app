import 'package:flutter/material.dart';
import 'package:gebeta_food/Screens/orders/pending_orders.dart';
import 'package:gebeta_food/Screens/user_profile/change_password.dart';
import 'package:gebeta_food/constants.dart';
import 'package:gebeta_food/models/profile.dart';
import 'package:gebeta_food/scoped-models/main.dart';

class ProfileScreen extends StatefulWidget {
  final MainModel model;
  final Profile profile;
  ProfileScreen(this.model, this.profile);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff8f9fd),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
                padding: EdgeInsets.only(left: 5, top: 20, bottom: 20),
                decoration: BoxDecoration(
                    color: whiteColor,
                    border: Border(
                        bottom:
                            BorderSide(color: Colors.grey.withOpacity(0.3)))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
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
                                  widget.profile.firstName +
                                      " " +
                                      widget.profile.lastName,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  widget.profile.email,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: gTextLightColor,
                                      fontWeight: FontWeight.w300),
                                ),
                                Text(
                                  widget.profile.phoneNo,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: gTextLightColor,
                                      fontWeight: FontWeight.w300),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/edit_profile");
                        },
                        icon: Icon(
                          Icons.navigate_next,
                          color: gTextLightColor.withOpacity(0.5),
                          size: 30,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    )
                  ],
                  color: whiteColor,
                ),
                margin: EdgeInsets.all(15),
                child: Column(
                  children: [
                    profileMenu(
                        context, Icons.change_circle, "Change Password"),
                    profileMenu(
                        context, Icons.payment_sharp, "Payment Methods"),
                    profileMenu(
                        context, Icons.location_on_outlined, "Location"),
                    profileMenu(context, Icons.access_time, "My Orders"),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    )
                  ],
                  color: whiteColor,
                ),
                margin: EdgeInsets.all(15),
                child: Column(
                  children: [
                    profileMenu(
                        context, Icons.notifications_outlined, "Notification"),
                    profileMenu(context, Icons.language_outlined, "Language"),
                    profileMenu(
                        context, Icons.people_outlined, "Invite Friends"),
                    profileMenu(
                        context, Icons.rate_review_outlined, "Rate app"),
                    profileMenu(context, Icons.info_outline, "About Us"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding profileMenu(context, icon, String name) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: gTextLightColor.withOpacity(0.4),
              ),
              SizedBox(width: 6),
              Text(
                name,
                style: TextStyle(
                    color: gTextLightColor.withOpacity(0.9), fontSize: 17),
              ),
            ],
          ),
          IconButton(
              onPressed: () {
                if (name == "Change Password") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChangePassword()));
                } else if (name == "Payment Methods") {
                } else if (name == "Location") {
                } else if (name == "My Orders") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PendingOrder(widget.model)));
                } else if (name == "Notification") {
                } else if (name == "Language") {
                } else if (name == "Invite Friends") {
                } else if (name == "Rate app") {
                } else {}
              },
              icon: Icon(
                Icons.navigate_next,
                color: gTextLightColor.withOpacity(0.5),
                size: 25,
              ))
        ],
      ),
    );
  }
}
