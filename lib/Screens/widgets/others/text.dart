import 'package:flutter/material.dart';

import '../../../constants.dart';

class TextWidget extends StatelessWidget {
  final String text;
  const TextWidget(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.w400,
          color: gPrimaryColor,
        ),
      ),
    );
  }
}
