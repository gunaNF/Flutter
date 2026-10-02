import 'package:flutter/material.dart';
import 'package:projek_flutterpertama/container/ContainerSatu.dart';
import 'package:projek_flutterpertama/container/LatihanContainer.dart';
import 'package:projek_flutterpertama/container/grid/GridInstagram.dart';
import 'package:projek_flutterpertama/container/row_column/ColumnWidget.dart';
import 'package:projek_flutterpertama/container/row_column/LatihanColumnRow1.dart';
import 'package:projek_flutterpertama/container/row_column/LatihanColumnRow2.dart';
import 'package:projek_flutterpertama/container/row_column/RowColumn.dart';
import 'package:projek_flutterpertama/container/row_column/RowWidget.dart';
import 'package:projek_flutterpertama/container/sized_box/ExpandedWidget.dart';
import 'package:projek_flutterpertama/container/sized_box/Latihan3.dart';
import 'package:projek_flutterpertama/container/sized_box/Latihan4.dart';
import 'package:projek_flutterpertama/container/sized_box/Layout4.dart';
import 'package:projek_flutterpertama/container/sized_box/LayoutSatu.dart';
import 'package:projek_flutterpertama/container/sized_box/SizeBox.dart';
import 'package:projek_flutterpertama/container/sized_box/StackWidget.dart';
import 'package:projek_flutterpertama/container/sized_box/LayoutDua.dart';

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
        // appBar: AppBar(
        //  // title: Text('Latihan Container'),
        //  // backgroundColor: const Color.fromARGB(255, 38, 255, 0),
        //  // centerTitle: true,
        // ),
        body: Gridinstagram()
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