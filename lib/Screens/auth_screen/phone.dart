import 'package:flutter/material.dart';
import 'package:gebeta_food/Screens/auth_screen/otp_verfication.dart';
import 'package:gebeta_food/Screens/widgets/others/logo.dart';
import 'package:gebeta_food/constants.dart';

class PhoneVerification extends StatefulWidget {
  const PhoneVerification({Key? key}) : super(key: key);

  @override
  _PhoneVerificationState createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  late String phoneNo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
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
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    style: TextStyle(fontSize: 17, color: gPrimaryColor),
                    decoration: InputDecoration(
                      hintText: " 0912345678",
                      prefix: Text(
                        "+251",
                        style: TextStyle(
                            color: gPrimaryColor, fontWeight: FontWeight.w600),
                      ),
                      labelText: "Phone Number",
                      labelStyle: TextStyle(
                          color: gPrimaryColor, fontWeight: FontWeight.w600),
                      hintStyle: TextStyle(
                          color: gTextLightColor, fontWeight: FontWeight.w200),
                    ),
                    onChanged: (String value) {
                      phoneNo = value;
                    },
                  ),
                  SizedBox(height: 10.0),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => OtpPage(phoneNo)),
                        );
                      },
                      child: Center(
                        child: Text(
                          "Verify",
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
            ),
          ),
        ],
      ),
    );
  }
}
