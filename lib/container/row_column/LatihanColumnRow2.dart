import 'package:flutter/material.dart';

class LatihanColumnRow2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320, // Lebar diperbesar sedikit agar muat secara horizontal
      height: 200,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 67, 255, 117),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color.fromARGB(255, 0, 165, 25),
          width: 2,
        ),
      ),
      
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
              Text(
                "Nama : Guna",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text("Nis : 123456789"),
              SizedBox(height: 5),
              Text("Kelas : XII RPL 1"),
            ],
          ),


          Container(
            width: 80,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(
                  'https://imgs.search.brave.com/l9r1AWUkJG1tmvwemlJRJR4X1Ki6e4Mor88mQq4QMiA/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly9jZG5z/LmtsaW1nLmNvbS9y/ZXNpemVkLzYzMHgv/Zy84L18vOF9wb3Ry/ZXRfbWVuYXdhbl9q/ZWZyaV9uaWNob2xf/cGFtZXJfcGVydXRf/c2l4cGFja19uZXRp/emVuX3NhbGFoX2Zv/a3VzX2RpX3VyYXRu/eWEvamVmcmlfbmlj/aG9sLTIwMjMwMTI5/LTAwNi1ub25fZm90/b2dyYWZlcl9rbHku/anBn'
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}