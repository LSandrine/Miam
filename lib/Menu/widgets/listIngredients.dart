import 'package:flutter/material.dart';
import '../data/database_helper.dart';
import '../models/ingredient.dart';
import '../models/menu.dart';
import '../models/recette.dart';

class listIngredient extends StatefulWidget {
  const listIngredient({Key? key, required this.menu}) : super(key: key);
  final Menu menu;
  @override
  State<listIngredient> createState() => _listIngredientState(menu : menu);
}

class _listIngredientState extends State<listIngredient> {
  Menu menu;
  _listIngredientState({required this.menu});
  List<bool> chk = [];
  Map<String,double> igs = {};
  void _refreshData() async {
    final data = await menu.getListIngredients();
    setState(() {
      igs = data;
      chk = List.generate(igs.length, (index) => false);
    });
  }
  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    if (menu != null) {
      //igs = tmp.then((value) => )
      var igsKey = igs.keys.toList();
      return Center(
          child: ListView.builder(
              itemCount: igsKey.length, itemBuilder: (context, i) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.4,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  child: CheckboxListTile(
                    value: chk[i],
                    onChanged: (bool? val){ setState(() {chk[i] = val!;});},
                    title: Text(igsKey[i]),
                    subtitle: Text('quantite : ${igs[igsKey[i]]}'),
                  ),
                ),
              ),
            );
          }),
        );
    }
    return Text('Aucun menu ... ');

  }
}
