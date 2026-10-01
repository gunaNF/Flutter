import 'package:flutter/material.dart';

class SizeBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 200,
          height: 100,
          color: Colors.blue,
          child: Center(
            child: Text(
              "Container 1",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        SizedBox(height: 20),
        Container(
          width: 200,
          height: 100,
          color: Colors.green,
          child: Center(
            child: Text(
              "Container 2",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}