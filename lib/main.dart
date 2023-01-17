import 'package:finalcuisine/pages/add_menu_page.dart';
import 'package:finalcuisine/pages/home_page.dart';
import 'package:finalcuisine/pages/listes_courses.dart';
import 'package:finalcuisine/pages/menu_page.dart';
import 'package:flutter/material.dart';

//import 'package:flutter_svg/flutter_svg.dart';
void main() {
  runApp(const MyApp());

}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  int _currentIndex = 0;

  setCurrentIndex(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: [
              Text("Accueil"),
              Text("Listes des menus "),
              Text("Ajouts des menus"),
              Text("listes des courses")

            ][_currentIndex],
          ),
          body: [
            HomePage(),
            MenuPage(),
            AddMenuPage(),
            ListesCourses()
          ][_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) => setCurrentIndex(index),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.grey,
            iconSize: 32,
            elevation: 10,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Accueil'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month),
                  label: 'Menu'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: 'Ajout_Menu'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_basket),
                  label: 'courses'
              ),
            ],
          ),
        )
    );
  }
}


