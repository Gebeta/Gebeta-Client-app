import 'package:flutter/material.dart';
import 'package:gebeta_food/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidePwd = true;

  Widget seePwd() {
    return hidePwd == true
        ? Icon(Icons.visibility_off, color: gPrimaryColor)
        : Icon(Icons.visibility);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.center,
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          SizedBox(height: 50),
          Container(
            padding: EdgeInsets.all(25),
            child: Image.asset('assets/images/logo.png'),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text(
              "Log In",
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.w400,
                color: gPrimaryColor,
              ),
            ),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
            child: TextField(
              style: TextStyle(fontSize: 17, color: gPrimaryColor),
              decoration: InputDecoration(
                hintText: "test@gmail.com",
                labelText: "Email",
                labelStyle: TextStyle(
                    color: gPrimaryColor, fontWeight: FontWeight.w200),
                hintStyle: TextStyle(color: gPrimaryColor),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
            child: TextField(
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: gPrimaryColor),
              obscureText: hidePwd,
              decoration: InputDecoration(
                hintText: "****",
                suffixIcon: IconButton(
                    onPressed: togglePwdVisibility,
                    icon: seePwd(),
                    color: gPrimaryColor),
                labelText: "Password",
                labelStyle: TextStyle(
                    color: gPrimaryColor, fontWeight: FontWeight.w200),
                hintStyle: TextStyle(color: gPrimaryColor),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5, right: 15),
            alignment: Alignment.centerRight,
            child: Text('Forgot Password?'),
          ),
          SizedBox(height: 20),
          Container(
            height: 50,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [gsecondaryColor, gPrimaryColor],
                  stops: [0, 1],
                ),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: InkWell(
              onTap: (){
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: Center(
                child: Text(
                  "Log In",
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

  void togglePwdVisibility() {
    setState(() {
      hidePwd = !hidePwd;
    });
  }
}