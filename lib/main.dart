import 'package:flutter/material.dart';
import 'package:miam/Menu/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MIAM',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: const MenuPage(),
    );
  }
}

