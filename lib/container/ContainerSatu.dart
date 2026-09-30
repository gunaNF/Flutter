import 'package:flutter/material.dart';

class ContainerSatu extends StatelessWidget {
  const ContainerSatu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage('https://imgs.search.brave.com/lBg86U127AebP6vKS3m8y9rWDIrCi_LRvNv0U-RRsMw/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzExLzE1LzMzLzM5/LzM2MF9GXzExMTUz/MzM5MzJfQU9uSEt0/QU1MSW9pWVEzd1Y3/Q29jWXIwMkx0cEh3/MlMuanBn'
          ),
          fit: BoxFit.cover,
        )
      ),
      child: Center(
       child: Text(
         'Container Satu',
         style: TextStyle(color: Colors.white, fontSize: 20),
       ),
      ),
    );
  }
}