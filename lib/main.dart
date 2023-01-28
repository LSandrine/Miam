import 'package:flutter/material.dart';
import 'package:miam/Menu/menu.dart';
// Remise du projet le 30 janvier
// code (repo github)
// video au moins 10 min par groupe, comment elle est codé. pourquoi ? et expliquer
// assurer qu'on a assimilé des notions de flutter => justifier nos choix

//scr cpy
void  main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Miam',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: const MenuPage(),
    );
  }
}


