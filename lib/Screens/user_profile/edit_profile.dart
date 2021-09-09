import 'package:flutter/material.dart';
import 'package:gebeta_food/constants.dart';
import 'package:gebeta_food/models/profile.dart';
import 'package:gebeta_food/scoped-models/main.dart';

class EditProfilePage extends StatefulWidget {
  final MainModel model;
  const EditProfilePage(this.model);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late Profile userProfile;
  @override
  void initState() {
    userProfile = widget.model.getUserProfile;
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
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back_ios)),
                        Text(
                          "Edit Profile",
                          style: TextStyle(fontSize: 22),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Done",
                        style: TextStyle(
                          color: gsecondaryColor,
                          fontSize: 16,
                          fontFamily: "Montserrat",
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Stack(
                children: [
                  ClipOval(
                    child: Container(
                      height: 130,
                      width: 130,
                      child: Image.asset(
                        "assets/images/profile.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                          color: gsecondaryColor,
                          borderRadius: BorderRadius.circular(50)),
                      child: Icon(
                        Icons.camera_alt_rounded,
                        color: whiteColor.withOpacity(0.8),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              Text(
                "Hi there, Client 👋",
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: gTextLightColor),
              ),
              TextButton(
                child: Text(
                  "Sign Out",
                  style: TextStyle(
                    color: gTextLightColor,
                    fontSize: 16,
                    fontFamily: "Montserrat",
                  ),
                ),
                onPressed: () {},
              ),
              Form(
                  child: ListView(
                shrinkWrap: true,
                children: [
                  customInputFiled(context, "First Name", userProfile.firstName),
                  customInputFiled(context, "Last Name", userProfile.lastName),
                  customInputFiled(context, "Phone No", userProfile.phoneNo),
                  customInputFiled(context, "Email",userProfile.email),
                  customInputFiled(context, "Gender", "Client Gender"),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  Container customInputFiled(
      BuildContext context, String textLabel, String initialTextValue) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 3,
            // offset: Offset(0, 3),
          )
        ],
        color: whiteColor,
      ),
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            textLabel,
            style: TextStyle(color: ksecondaryColor, fontSize: 18),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: TextFormField(
              initialValue: initialTextValue,
              obscureText: textLabel == "Password" ? true : false,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: textLabel,
                hintStyle: TextStyle(color: ksecondaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
