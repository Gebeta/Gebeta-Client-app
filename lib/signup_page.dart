import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({ Key? key }) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  bool hidePwd = true;

  Widget see_pwd() {
    return hidePwd == true
        ? Icon(Icons.visibility_off, color: Color(0xffd14e2c))
        : Icon(Icons.visibility);
  }

    void togglePwdVisibility() {
    setState(() {
      hidePwd = !hidePwd;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          // SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(10),
            child: Image.asset('assets/images/logo.png'),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text(
              "Sign Up",
              style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffd14e2c),
                  ),
            ),
          ),
          SizedBox(height: 2),
          Container(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
            child: TextField(
              style: TextStyle(fontSize: 17, color: Color(0xffd14e2c)),
              decoration: InputDecoration(
                hintText: "Jhon",
                labelText: "First Name",
                labelStyle: TextStyle(color: Color(0xffd14e2c),fontWeight: FontWeight.w200),
                hintStyle: TextStyle(color: Color(0xffd14e2c)),
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Container(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
            child: TextField(
              style: TextStyle(fontSize: 17, color: Color(0xffd14e2c)),
              decoration: InputDecoration(
                hintText: "Doe",
                labelText: "Last Name",
                labelStyle: TextStyle(color: Color(0xffd14e2c),fontWeight: FontWeight.w200),
                hintStyle: TextStyle(color: Color(0xffd14e2c)),
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Container(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
            child: TextField(
              style: TextStyle(fontSize: 17, color: Color(0xffd14e2c)),
              decoration: InputDecoration(
                hintText: "jhondoe@gmail.com",
                labelText: "Email",
                labelStyle: TextStyle(color: Color(0xffd14e2c),fontWeight: FontWeight.w200),
                hintStyle: TextStyle(color: Color(0xffd14e2c)),
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
                  color: Color(0xffd14e2c)),
              obscureText: hidePwd,
              decoration: InputDecoration(
                hintText: "****",
                suffixIcon: IconButton(
                    onPressed: togglePwdVisibility,
                    icon: see_pwd(),
                    color: Color(0xffd14e2c)),
                labelText: "Password",
                labelStyle: TextStyle(
                    color: Color(0xffd14e2c), fontWeight: FontWeight.w200),
                hintStyle: TextStyle(color: Color(0xffd14e2c)),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
            child: TextField(
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Color(0xffd14e2c)),
              obscureText: hidePwd,
              decoration: InputDecoration(
                hintText: "****",
                suffixIcon: IconButton(
                    onPressed: togglePwdVisibility,
                    icon: see_pwd(),
                    color: Color(0xffd14e2c)),
                labelText: "Confirm Password",
                labelStyle: TextStyle(
                    color: Color(0xffd14e2c), fontWeight: FontWeight.w200),
                hintStyle: TextStyle(color: Color(0xffd14e2c)),
              ),
            ),
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
              onTap: (){
                  Navigator.pushReplacementNamed(context, '/selectTopics');
                },
              child: Center(
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}