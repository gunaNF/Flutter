import 'package:flutter/material.dart';
import 'package:projek_flutterpertama/container/ContainerSatu.dart';
import 'package:projek_flutterpertama/container/LatihanContainer.dart';
import 'package:projek_flutterpertama/container/row_column/ColumnWidget.dart';
import 'package:projek_flutterpertama/container/row_column/LatihanColumnRow1.dart';
import 'package:projek_flutterpertama/container/row_column/LatihanColumnRow2.dart';
import 'package:projek_flutterpertama/container/row_column/RowColumn.dart';
import 'package:projek_flutterpertama/container/row_column/RowWidget.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Latihan Container'),
          backgroundColor: const Color.fromARGB(255, 38, 255, 0),
          centerTitle: true,
        ),
        body: LatihanColumnRow2()
      ),
    );
  } 
}

class Hellowidget extends StatelessWidget {
  const Hellowidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Hello, World!'),
    );
  }
}