import 'package:flutter/material.dart';
import 'package:gebeta_food/constants.dart';

class AddProfilePicScreen extends StatefulWidget {
  const AddProfilePicScreen({Key? key}) : super(key: key);

  @override
  _AddProfilePicScreenState createState() => _AddProfilePicScreenState();
}

class _AddProfilePicScreenState extends State<AddProfilePicScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        title: Text("Finish setting up your Profile"),
      ),
      body: Column(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 20),
                alignment: Alignment.topLeft,
                child: Text(
                  "Hi, " + "Yael",
                  style: TextStyle(
                    color: gsecondaryColor,
                    fontSize: 28,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Add Profile Pic",
                  style: TextStyle(
                    color: gsecondaryColor,
                    fontSize: 28,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: Image.asset(
                    "assets/images/female_avatar.jpg",
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * 0.5,
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [gsecondaryColor, gPrimaryColor],
                    stops: [0, 1],
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Add Profile Picture ",
                        style: TextStyle(color: whiteColor, fontSize: 16),
                      ),
                      Icon(
                        Icons.add_a_photo_outlined,
                        color: whiteColor,
                      )
                    ],
                  ),
                  onTap: () {},
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Choose your Location",
                style: TextStyle(
                  color: gsecondaryColor,
                  fontSize: 20,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text("Choose"),
              )
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [gsecondaryColor, gPrimaryColor],
                stops: [0, 1],
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: InkWell(
              onTap: () {
                // Navigator.pushNamed(context, '/signup');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddProfilePicScreen()),
                );
              },
              child: Center(
                child: Text(
                  "Next",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 120,
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Text("Pick an Image"),
                SizedBox(
                  height: 10.0
                )
              ],
            ),
          );
        });
  }
}
