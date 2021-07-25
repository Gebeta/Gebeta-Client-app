import 'package:flutter/material.dart';
import 'package:gebeta_food/Screens/widgets/form_input/button.dart';
import 'package:gebeta_food/Screens/widgets/others/logo.dart';
import 'package:gebeta_food/Screens/widgets/others/text.dart';
import 'package:gebeta_food/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
          SizedBox(
            height: 40.0,
          ),
          Logo(),
          Center(child: TextWidget("Log In")),
          SizedBox(height: 10,),
          Center(child: Text("Add your details to login")),
          SizedBox(height: 5),
          Form(
            key: _formKey,
            child: Column(
              children: [
                _buildEmailTextField(),
                SizedBox(height: 5.0),
                _buildPasswordTextField(),
                
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
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    child: ButtonWidget(() {}, "Log In"),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 15.0),
                  alignment: Alignment.center,
                  child: TextButton(
                      onPressed: () {}, child: Text('Forgot Password?')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _buildPasswordTextField() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
      child: TextFormField(
        style: TextStyle(
            fontSize: 17, fontWeight: FontWeight.w600, color: gPrimaryColor),
        obscureText: hidePwd,
        decoration: InputDecoration(
          hintText: "****",
          suffixIcon: IconButton(
              onPressed: togglePwdVisibility,
              icon: seePwd(),
              color: gPrimaryColor),
          labelText: "Password",
          labelStyle:
              TextStyle(color: gPrimaryColor, fontWeight: FontWeight.w600),
          hintStyle:
              TextStyle(color: gPrimaryColor, fontWeight: FontWeight.w100),
        ),
      ),
    );
  }

  Container _buildEmailTextField() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
      child: TextFormField(
        style: TextStyle(fontSize: 17, color: gPrimaryColor),
        decoration: InputDecoration(
          hintText: "test@gmail.com",
          labelText: "Email",
          labelStyle:
              TextStyle(color: gPrimaryColor, fontWeight: FontWeight.w600),
          hintStyle:
              TextStyle(color: gPrimaryColor, fontWeight: FontWeight.w100),
        ),
      ),
    );
  }

  void togglePwdVisibility() {
    setState(() {
      hidePwd = !hidePwd;
    });
  }
}
