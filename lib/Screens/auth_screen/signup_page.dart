import 'package:flutter/material.dart';
import 'package:gebeta_food/Screens/auth_screen/add_profile_pic.dart';
import 'package:gebeta_food/Screens/widgets/form_input/button.dart';
import 'package:gebeta_food/Screens/widgets/others/logo.dart';
import 'package:gebeta_food/Screens/widgets/others/text.dart';
import 'package:gebeta_food/constants.dart';
import 'package:gebeta_food/scoped-models/main.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:scoped_model/scoped_model.dart';

class SignUpPage extends StatefulWidget {
  final String phoneNo;
  const SignUpPage(this.phoneNo);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTextController = TextEditingController();

  final Map<String, dynamic> _formData = {
    "id": null,
    "first_name": null,
    "last_name": null,
    "username": null,
    "password": null,
    "email": null,
    "phone_no": null,
    "address": null
  };

  bool hidePwd = true;

  Widget seePwd() {
    return hidePwd == true
        ? Icon(Icons.visibility_off, color: gPrimaryColor)
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
          Logo(),
          Center(child: TextWidget("Sign Up")),
          SizedBox(height: 2),
          Form(
            key: _formKey,
            child: Column(
              children: [
                _buildFirstNameField(),
                SizedBox(height: 5.0),
                _buildLastNameField(),
                SizedBox(height: 5.0),
                _buildEmailField(),
                SizedBox(height: 10.0),
                _buildPasswordField(),
                _buildConfirmPasswordField(),
                SizedBox(height: 20),
                ScopedModelDescendant<MainModel>(
                  builder: (context, Widget child, MainModel model) {
                    return Container(
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
                          onTap: () => _submitForm(model.signUp),
                          child: ButtonWidget(() {}, "Sign Up")),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _buildConfirmPasswordField() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
      child: TextFormField(
        style: TextStyle(
            fontSize: 17, fontWeight: FontWeight.w600, color: gPrimaryColor),
        obscureText: hidePwd,
        validator: (value) {
          if (_passwordTextController.text != value) {
            return 'Passwords do not match.';
          }
        },
        decoration: InputDecoration(
          hintText: "****",
          suffixIcon: IconButton(
              onPressed: togglePwdVisibility,
              icon: seePwd(),
              color: gPrimaryColor),
          labelText: "Confirm Password",
          labelStyle:
              TextStyle(color: gPrimaryColor, fontWeight: FontWeight.w600),
          hintStyle:
              TextStyle(color: gPrimaryColor, fontWeight: FontWeight.w100),
        ),
      ),
    );
  }

  Container _buildPasswordField() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
      child: TextFormField(
        style: TextStyle(
            fontSize: 17, fontWeight: FontWeight.w600, color: gPrimaryColor),
        obscureText: hidePwd,
        validator: (value) {
          if (value.toString().isEmpty || value.toString().length < 8) {
            return 'Invalid Password';
          }
        },
        onChanged: (String value) {
          _formData['password'] = value;
        },
        controller: _passwordTextController,
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

  Container _buildEmailField() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
      child: TextFormField(
        style: TextStyle(fontSize: 17, color: gPrimaryColor),
        decoration: InputDecoration(
          hintText: "jhondoe@gmail.com",
          labelText: "Email",
          labelStyle:
              TextStyle(color: gPrimaryColor, fontWeight: FontWeight.w600),
          hintStyle:
              TextStyle(color: gPrimaryColor, fontWeight: FontWeight.w100),
        ),
        validator: (value) {
          if (value.toString().isEmpty ||
              !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                  .hasMatch(value.toString())) {
            return 'Invalid Email';
          }
        },
        onChanged: (String value) {
          _formData['email'] = value;
        },
      ),
    );
  }

  Container _buildLastNameField() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
      child: TextFormField(
        style: TextStyle(fontSize: 17, color: gPrimaryColor),
        decoration: InputDecoration(
          hintText: "Doe",
          labelText: "Last Name",
          labelStyle:
              TextStyle(color: gPrimaryColor, fontWeight: FontWeight.w600),
          hintStyle:
              TextStyle(color: gPrimaryColor, fontWeight: FontWeight.w100),
        ),
        validator: (value) {
          if (value.toString().isEmpty) {
            return 'Last Name can\'t be Empty';
          }
        },
        onChanged: (String value) {
          _formData['last_name'] = value;
        },
      ),
    );
  }

  Container _buildFirstNameField() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
      child: TextFormField(
        style: TextStyle(fontSize: 17, color: gPrimaryColor),
        decoration: InputDecoration(
          hintText: "Jhon",
          labelText: "First Name",
          labelStyle:
              TextStyle(color: gPrimaryColor, fontWeight: FontWeight.w600),
          hintStyle:
              TextStyle(color: gPrimaryColor, fontWeight: FontWeight.w100),
        ),
        validator: (value) {
          if (value.toString().isEmpty) {
            return 'First Name can\'t be Empty';
          }
        },
        onChanged: (String value) {
          _formData['first_name'] = value;
        },
      ),
    );
  }

  Future<void> _submitForm(Function signup) async {
    // || !_formData['acceptTerms']
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    final Map<String, dynamic> response = await signup(
        _formData['first_name'],
        _formData['last_name'],
        _formData['password'],
        _formData['email'],
        widget.phoneNo,);
    print("response data " + response['success'].toString());
    print(response['id']);
    if (response['success']) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => new AddProfilePicScreen(
                  _formData['first_name'],response['id']
                )),
      );
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("An error occured"),
              content: Text(response['message']),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Okay"),
                )
              ],
            );
          });
    }
  }
}
