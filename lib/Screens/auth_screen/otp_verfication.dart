import 'package:flutter/material.dart';
import 'package:gebeta_food/Screens/auth_screen/add_profile_pic.dart';
import 'package:gebeta_food/constants.dart';

class OtpPage extends StatefulWidget {
  final String phoneNo;
  const OtpPage(this.phoneNo);

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: gsecondaryColor,
            ),
            child: Icon(
              Icons.arrow_back_ios,
              size: 18,
              color: whiteColor,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: whiteColor,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(top: 30.0),
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
              padding: EdgeInsets.only(top: 30.0, bottom: 30),
              child: Text(
                "Please check your mobile number ${widget.phoneNo}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _textFieldOTP(first: true, last: false),
                _textFieldOTP(first: false, last: false),
                _textFieldOTP(first: false, last: false),
                _textFieldOTP(first: false, last: false),
                _textFieldOTP(first: false, last: false),
                _textFieldOTP(first: false, last: true),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
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
                    "Verify",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Text(
              "Didn't you receive any code?",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black38,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "Resend New Code",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: gsecondaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textFieldOTP({required bool first, required bool last}) {
    return Container(
      height: 80,
      child: AspectRatio(
        aspectRatio: 0.6,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: gsecondaryColor),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}
