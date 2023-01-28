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

  /*
   * Generation d'un menu de 14 recette et enregistrement en bd.
   */
  Future<void> createMenu() async {
    // load all recettes
    List<Recette> recettes = await DatabaseHelper.getRecettes();
    // get last id inserted dans la table Menu
    int IdM = (await DatabaseHelper.getLastIdMenu())+1;
    // Creation d'une liste de tous les id
    List<int> _rngId = List<int>.generate(recettes.length, (i) => i + 1);
    //shuffle la liste pour obtenir un menu different
    _rngId.shuffle();
    // conserve les 14 premiers id pour les 14 recettes du menu
    _rngId = _rngId.sublist(0,13);
    // add dans la bd le nouveau menu
    for(var idR in _rngId){
      var r = await DatabaseHelper.createMenu(IdM, idR);
    }
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
