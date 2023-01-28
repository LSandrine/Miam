import 'package:flutter/material.dart';
import 'dart:math';
import 'package:miam/Menu/models/menu.dart';

import 'data/database_helper.dart';
import 'models/recette.dart';

class accueilPage extends StatefulWidget {
  const accueilPage({Key? key}) : super(key: key);

  @override
  State<accueilPage> createState() => _accueilPageState();
}

class _accueilPageState extends State<accueilPage> {
  final _rng = Random();

  Future<void> createMenu() async {
    var menus = await DatabaseHelper.getMenus2();
    List<Recette> recettes = await DatabaseHelper.getRecettes();
    int IdM = (await DatabaseHelper.getLastIdMenu())+1;
    //var _rngId = List.generate(16, (_) => _rng.nextInt(recettes.length));
    List<int> _rngId = List<int>.generate(recettes.length, (i) => i + 1);
    _rngId.shuffle();
    _rngId = _rngId.sublist(0,13);
    for(var idR in _rngId){
      var r = await DatabaseHelper.createMenu(IdM, idR);
    }
    menus = await DatabaseHelper.getMenus2();
  }

  @override
  Widget build(BuildContext context) {
  return Container(color: Colors.green,child:Center(child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
      Container(
        height: 100,
        width: 300,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color:Colors.white ,borderRadius: BorderRadius.circular(10.0)),
        child: const Center(child: Text("Bienvenue sur Miam !",style:TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: Colors.green), ),),
      ),const SizedBox(height: 150),
      SizedBox(height: 100,width: 100 ,
        child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.red, shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(50.0),)),
          onPressed: () => createMenu(), child: const Icon(Icons.restart_alt,color: Colors.white,size: 65,)),)
    ]),),);
  }
}
