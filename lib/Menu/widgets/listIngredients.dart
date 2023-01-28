import 'package:flutter/material.dart';
import '../models/menu.dart';
import '../models/recette.dart';

class listIngredient extends StatelessWidget {
  listIngredient({Key? key, required this.menus}) : super(key: key);
  final List<Menu> menus;
  Map<String,double> igs = {};

  void getIgs(Menu menu) async {
    igs = await menu.getListIngredients();
  }
  @override
  Widget build(BuildContext context) {
    if (this.menus != null) {
      Menu? menu = this.menus?.last;
      if (menu != null) {
        getIgs(menu);
        List<String> igsKey = igs.keys.toList();
        //double val = igs[keys[idx]];

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
                  child: ListTile(
                    title: Text(igsKey[i]),
                    subtitle: Text('quantite : ${igs[igsKey[i]]}'),
                  ),
                ),
              ),
            );
          }),
        );
      }
    }
    return Text('Aucun menu ... ');
  }
}
