import 'package:flutter/material.dart';

class Latihan3 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          SizedBox(width: 20),
          Expanded(
            child: Container(
              width: 100,
              height: 100,
              color: const Color.fromARGB(255, 109, 187, 250),
              child: Center(
                child: Text(
                  "Pemasukan",
                  style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Container(
              width: 100,
              height: 100,
              color: const Color.fromARGB(255, 128, 255, 132),
              child: Center(
                child: Text(
                  "Pengeluaran",
                  style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Container(
              width: 100,
              height: 100,
              color: const Color.fromARGB(255, 255, 251, 134),
              child: Center(
                child: Text(
                  "Saldo",
                  style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}