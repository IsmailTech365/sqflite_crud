// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sqlflite_crud/classes/addnote.dart';
import 'package:sqlflite_crud/classes/edit.dart';
import 'package:sqlflite_crud/classes/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
      routes: {
        'home': (context) => Home(),
        'add': (context) => Addnote(),
        'edit': (context) => Editnots(),
      },
    );
  }
}
