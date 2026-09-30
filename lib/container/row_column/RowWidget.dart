import 'package:flutter/material.dart';

class RowWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Text("Ini row 1"),
      Text("Ini row 2"),
      Text("Ini row 3"),
    ],
    );
  }
}