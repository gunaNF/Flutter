import 'package:flutter/material.dart';

class ColumnWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text("Ini column 1"),
        Text("Ini column 2"),
        Text("Ini column 3"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Ini row 1"),
            Text("Ini row 2"),
            Text("Ini row 3"),
          ],
        ),
      ],
    );
  }
}