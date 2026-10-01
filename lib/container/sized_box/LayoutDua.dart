import 'package:flutter/material.dart';

class LayoutDua extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container (
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.image, size: 60, color: Colors.grey[700]),
        ),
        Positioned(
          top: 8,
          left: 8,
         child: Container(
          padding: EdgeInsets.all(4),
          color: Colors.red,
          child: Text("-28%"),
         ),
        ),
        Positioned(
          bottom: 8,
          right: 8,
          child: Icon(Icons.favorite_border),
        ),
      ],
    );
  }
}