import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Function funct;
  final String name;
  const ButtonWidget(this.funct, this.name);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        name,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
      ),
    );
  }
}
