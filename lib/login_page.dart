import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidePwd = true;

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.center,
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          SizedBox(height: 100),
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
                  color: Color(0xffd14e2c),
                  fontFamily: "Raleway"),
            ),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
            ),
            child: TextField(
              style: TextStyle(fontSize: 17, color: Color(0xffd14e2c)),
              decoration: InputDecoration(
                hintText: "Example : test@gmail.com",
                hintStyle: TextStyle(color: Color(0xffd14e2c)),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.grey.withOpacity(0.2),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Color(0xffd14e2c)),
                    obscureText: hidePwd,
                    decoration: InputDecoration(
                        hintText: "****",
                        hintStyle: TextStyle(color: Color(0xffd14e2c)),
                        border: InputBorder.none),
                  ),
                ),
                Container(
                  height: 50,
                  width: 50,
                  child: IconButton(
                        onPressed: togglePwdVisibility,
                        icon: hidePwd == true
                            ? Icon(Icons.visibility_off,
                                color: Color(0xffd14e2c))
                            : Icon(Icons.visibility),
                        color: Color(0xffd14e2c),
                      ),
                )
              ],
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
                  colors: [Color(0xffD86346), Color(0xffd14e2c)],
                  stops: [0, 1],
                ),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: InkWell(
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
    // hidePwd = !hidePwd;
    setState(() {
      hidePwd = !hidePwd;
    });
  }
}
