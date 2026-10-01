import 'package:flutter/material.dart';

class Layout4 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
            Stack(
                clipBehavior: Clip.none,
                children: [
                    Container(height: 200, color: const Color.fromARGB(255, 255, 200, 2),),
                    Positioned(
                        bottom: -30,
                        left: 20,
                        child: SizedBox(
                            width: 80,
                            height: 80,
                            child: CircleAvatar( radius: 36,backgroundColor: const Color.fromARGB(255, 5, 155, 255),
                            ),
                        ),
                        ),
                        ],
            ),
            SizedBox(height: 40),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                    children: [
                        Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Text("Guna", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                    SizedBox(height: 8),
                                    Text("XII RPL 1", style: TextStyle(fontSize: 14, color: Colors.grey),),
                                ],
                            ),
                        ),
                    ],
                ),
            ),
            ElevatedButton(
                onPressed: () {},
                child: Text("Follow"),
            ),
        ],
    );
  }
}