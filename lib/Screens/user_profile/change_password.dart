import 'package:flutter/material.dart';
import 'package:gebeta_food/constants.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTextController = TextEditingController();
  final Map<String, dynamic> _formData = {
    "password": null,
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SafeArea(
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
                          "Change Password",
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
            SizedBox(
              height: 30,
            ),
            Container(
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
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Password",
                    style: TextStyle(color: ksecondaryColor, fontSize: 18),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TextFormField(
                      obscureText: true,
                      controller: _passwordTextController,
                      validator: (value) {
                        if (value.toString().isEmpty ||
                            value.toString().length < 8) {
                          return 'Invalid Password';
                        }
                      },
                      onChanged: (String value) {
                        _formData['password'] = value;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                        hintStyle: TextStyle(color: ksecondaryColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
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
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Confirm Password",
                    style: TextStyle(color: ksecondaryColor, fontSize: 18),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TextFormField(
                      obscureText: true,
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return 'Invalid Password';
                        }
                        if (_passwordTextController.text != value) {
                          return 'Passwords do not match.';
                        }
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Confirm Password",
                        hintStyle: TextStyle(color: ksecondaryColor),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
