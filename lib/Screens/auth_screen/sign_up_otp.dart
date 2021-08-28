import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gebeta_food/Screens/auth_screen/signup_page.dart';
import 'package:gebeta_food/Screens/widgets/others/logo.dart';
import 'package:gebeta_food/scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../constants.dart';

enum MobileVerficationState { MOBILE_FORM, OTP_FORM }

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  MobileVerficationState currentState = MobileVerficationState.MOBILE_FORM;

  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  String verifiationId = '';
  String userInput = "";
  bool showLoading = false;

  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: showLoading
          ? Center(child: CircularProgressIndicator())
          : currentState == MobileVerficationState.MOBILE_FORM
              ? getMobileFormWidget(context)
              : getOtpFormWidget(context),
    );
  }

  getMobileFormWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: ListView(
        children: [
          SizedBox(height: 40),
          Logo(),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text(
              "Verify Your phone number before signing up.",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: gPrimaryColor,
              ),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: " +251912345678",
              // prefix: Text(
              //   "+251",
              //   style: TextStyle(
              //       color: gPrimaryColor, fontWeight: FontWeight.w600),
              // ),
              prefix: SvgPicture.asset(
                'assets/icons/ethiopia.svg',
                width: 25,
              ),
              labelText: "Phone Number",
              labelStyle:
                  TextStyle(color: gPrimaryColor, fontWeight: FontWeight.w600),
              hintStyle: TextStyle(
                  color: gTextLightColor, fontWeight: FontWeight.w200),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          ScopedModelDescendant(
              builder: (context, Widget child, MainModel model) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [gsecondaryColor, gPrimaryColor],
                    stops: [0, 1],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  textStyle: TextStyle(
                    fontSize: 23,
                  ),
                ),
                onPressed: () async {
                  setState(() {
                    showLoading = true;
                  });
                  Map<String, dynamic> response = await model.checkExsitingUser(phoneController.text);
                  if(response["UserExists"]){
                    setState(() {
                      showLoading = false;
                    });
                    _showMyDialog();
                  }
                  else{
                    await _auth.verifyPhoneNumber(
                      phoneNumber: phoneController.text,
                      verificationCompleted: (phoneAuthCredential) async {
                        setState(() {
                          showLoading = false;
                        });
                        // signInWithPhoneAuthCredential(phoneAuthCredential);
                      },
                      verificationFailed: (verificationFailed) async {
                        setState(() {
                          showLoading = false;
                        });
                        print(verificationFailed.message);
                      },
                      codeSent: (verificationId, resendingToken) async {
                        setState(() {
                          showLoading = false;
                          currentState = MobileVerficationState.OTP_FORM;
                          this.verifiationId = verificationId;
                        });
                      },
                      codeAutoRetrievalTimeout: (verificationId) async {});
                  }
                  
                },
                child: Text(
                  "Send",
                ),
              ),
            );
          })
        ],
      ),
    );
  }

  Future<void> _showMyDialog() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Something happend'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('User already Exists'),
              Text('please Enter new phone Number.'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });
    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });

      if (authCredential.user != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SignUpPage(phoneController.text)));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });
      print(e.message);
    }
  }

  otpTextFields(context) {
    final node = FocusScope.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            width: 50.0,
            child: TextFormField(
              controller: otpController,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26.0),
              onChanged: (value) {
                if (value.length == 1) node.nextFocus();
                userInput = userInput + value.toString();
              },
              maxLength: 1,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  counterText: "",
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: gsecondaryColor))),
            )),
        SizedBox(
            width: 50.0,
            child: TextFormField(
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26.0),
              onChanged: (value) {
                if (value.length == 1) node.nextFocus();
                userInput = userInput + value.toString();
              },
              maxLength: 1,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  counterText: "",
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: gsecondaryColor))),
            )),
        SizedBox(
            width: 50.0,
            child: TextFormField(
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26.0),
              onChanged: (value) {
                if (value.length == 1) node.nextFocus();
                userInput = userInput + value.toString();
              },
              maxLength: 1,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  counterText: "",
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: gsecondaryColor))),
            )),
        SizedBox(
            width: 50.0,
            child: TextFormField(
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26.0),
              onChanged: (value) {
                if (value.length == 1) node.nextFocus();
                userInput = userInput + value.toString();
              },
              maxLength: 1,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  counterText: "",
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: gsecondaryColor))),
            )),
        SizedBox(
            width: 50.0,
            child: TextFormField(
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26.0),
              onChanged: (value) {
                if (value.length == 1) node.nextFocus();
                userInput = userInput + value.toString();
              },
              maxLength: 1,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  counterText: "",
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: gsecondaryColor))),
            )),
        SizedBox(
            width: 50.0,
            child: TextFormField(
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26.0),
              onChanged: (value) {
                if (value.length == 1) node.nextFocus();
                userInput = userInput + value.toString();
              },
              maxLength: 1,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  counterText: "",
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: gsecondaryColor))),
            )),
      ],
    );
  }

  getOtpFormWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        children: [
          SizedBox(
            height: 3,
          ),
          Logo(),
          Container(
            padding: EdgeInsets.only(top: 3.0),
            alignment: Alignment.center,
            child: Text(
              "We have sent you a Verfication code to your mobile",
              style: TextStyle(
                color: gsecondaryColor,
                fontSize: 26,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 30.0, bottom: 10),
            child: Text(
              "Please check your mobile number ${phoneController.text}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          otpTextFields(context),
          SizedBox(
            height: 26,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [gsecondaryColor, gPrimaryColor],
                stops: [0, 1],
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                textStyle: TextStyle(
                  fontSize: 20,
                ),
              ),
              onPressed: () async {
                PhoneAuthCredential phoneAuthCredential =
                    PhoneAuthProvider.credential(
                        verificationId: verifiationId, smsCode: userInput);

                signInWithPhoneAuthCredential(phoneAuthCredential);
              },
              child: Text("VERIFY"),
            ),
          ),
        ],
      ),
    );
  }
}
