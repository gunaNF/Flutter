import 'package:flutter/material.dart';

class StackWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(width: 200,height: 200,color: Colors.blue,),
        Positioned(
          bottom: 10,
          right: 10,
          child: Icon(
            Icons.favorite,
            size: 10,
            color: Colors.red,
          ),
        ),
        Positioned(top: 10, left: 10, child: Text("Ini text diatas container")),
        Positioned(
          right: 25,
          top: 25,
          left: 25,
          child: Container(width: 100,height: 100,color: Colors.green,),
        ),
      ],
    );
  }
}