import 'package:flutter/material.dart';
import 'package:miam/Menu/widgets/NewIngredient.dart';
import 'package:miam/Menu/widgets/NewRecette.dart';
import 'package:miam/Menu/widgets/listIngredients.dart';
import 'package:miam/Menu/widgets/listMenu.dart';
import 'package:miam/Menu/widgets/listRecette.dart';
import 'acceuil.dart';
import 'data/database_helper.dart';
import 'models/ingredient.dart';
import 'package:miam/Menu/models/menu.dart';
import 'models/recette.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);
  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  /*
  Initialisation/Declaration des variables
   */
  List<ElementIg> _elements = [];
  List<Recette> _recettes = [];
  bool _isLoading = true;
  int _selectedIndex = 0;
  List<Menu> _menus = [];

  /*
   * Fonction qui permet de récupérer les données de la base et de les stocker dans différente variable.
   */
  void _refreshData() async {
    final menus = await DatabaseHelper.getMenus();
    final elements = await DatabaseHelper.getElementIgs();
    final recettes = await DatabaseHelper.getRecettes();

    setState(() {
      _elements = elements;
      _menus = menus;
      _recettes = recettes;
      _isLoading = false;

    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData();// Charger les données (when the app starts)
  }

  /*
   * Fonction d'event de l'obj BottomNavigationBar, modifie la var _selectedIndex quand l'obj est tapé.
   * @param int, l'item sélectionné.
   */
  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
  /*
   * Return un widget en fonction de l'index souhaité.
   * @param int, index de page souhaité.
   * @return widget, widget souhaité.
   */
  Widget _pages (index){
    _refreshData();
    if(index == 0) {
      return accueilPage();
    }
    if(index == 1) {
      return listMenu(menus: _menus);
    }
    if(index == 2) {
      return newRecette(elements: _elements,);
    }
    if(index == 3) {
      //return listRecette(recettes: _recettes);
      return listIngredient(menu: _menus.last);
    }
    return Text('error' + index.toString());
  }
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title:  const Text('Miam !',style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.green,
          elevation: 0,
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          backgroundColor: Colors.green,
          elevation: 0,
          iconSize: 20,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white54,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(label: 'acc',icon: Icon(Icons.home_outlined),backgroundColor: Colors.green),
            BottomNavigationBarItem(label: 'menu',icon: Icon(Icons.restaurant_menu),backgroundColor: Colors.green),
            BottomNavigationBarItem(label: 'addRecette',icon: Icon(Icons.menu_book),backgroundColor: Colors.green),
            BottomNavigationBarItem(label: 'list Ig',icon: Icon(Icons.receipt_long),backgroundColor: Colors.green),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
        body: Center(
          child: _pages(_selectedIndex),// _pages.elementAt(_selectedIndex),
        ),
      ),
    );
  }
}
