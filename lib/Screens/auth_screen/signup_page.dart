import 'package:flutter/material.dart';
import 'package:gebeta_food/constants.dart';
import 'package:gebeta_food/scoped-models/user.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

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
    final UserModel model = UserModel();
    return ScopedModel<UserModel>(
      model: model,
      child: Scaffold(
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
                  color: gPrimaryColor,
                ),
              ),
            ),
            SizedBox(height: 2),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                    child: TextFormField(
                      style: TextStyle(fontSize: 17, color: gPrimaryColor),
                      decoration: InputDecoration(
                        hintText: "Jhon",
                        labelText: "First Name",
                        labelStyle: TextStyle(
                            color: gPrimaryColor, fontWeight: FontWeight.w200),
                        hintStyle: TextStyle(color: gPrimaryColor),
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
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                    child: TextFormField(
                      style: TextStyle(fontSize: 17, color: gPrimaryColor),
                      decoration: InputDecoration(
                        hintText: "Doe",
                        labelText: "Last Name",
                        labelStyle: TextStyle(
                            color: gPrimaryColor, fontWeight: FontWeight.w200),
                        hintStyle: TextStyle(color: gPrimaryColor),
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
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                    child: TextFormField(
                      style: TextStyle(fontSize: 17, color: gPrimaryColor),
                      decoration: InputDecoration(
                        hintText: "jhondoe@gmail.com",
                        labelText: "Email",
                        labelStyle: TextStyle(
                            color: gPrimaryColor, fontWeight: FontWeight.w200),
                        hintStyle: TextStyle(color: gPrimaryColor),
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
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                    child: TextFormField(
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: gPrimaryColor),
                      obscureText: hidePwd,
                      validator: (value) {
                        if (value.toString().isEmpty ||
                            value.toString().length < 6) {
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
                        labelStyle: TextStyle(
                            color: gPrimaryColor, fontWeight: FontWeight.w200),
                        hintStyle: TextStyle(color: gPrimaryColor),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                    child: TextFormField(
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: gPrimaryColor),
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
                        labelStyle: TextStyle(
                            color: gPrimaryColor, fontWeight: FontWeight.w200),
                        hintStyle: TextStyle(color: gPrimaryColor),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ScopedModelDescendant<UserModel>(
                      builder: (context, Widget child, UserModel moder) {
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
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
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
        "145",
        _formData['first_name'],
        _formData['last_name'],
        "eyael",
        _formData['password'],
        _formData['email'],
        "0826747834",
        "Summit");
    print("response data " + response['success'].toString());
    if (response['success']) {
      Navigator.pushReplacementNamed(context, '/selectTopics');
    }
  }
}
