import 'package:flutter/material.dart';
import 'package:gebeta_food/constants.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key}) : super(key: key);

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
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back_ios)),
                        Text(
                          "Edit Profile",
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
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 25,
                        width: 100,
                        color: Colors.black.withOpacity(0.2),
                        child: Icon(
                          Icons.camera_alt_rounded,
                          color: whiteColor.withOpacity(0.6),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.edit,
                    color: gsecondaryColor,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Edit Profile",
                    style: TextStyle(color: gsecondaryColor, fontSize: 17),
                  )
                ],
              ),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
