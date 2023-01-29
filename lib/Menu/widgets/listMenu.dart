import 'package:flutter/material.dart';
import 'package:miam/Menu/models/menu.dart';
import 'package:miam/Menu/widgets/NewRecette.dart';
//1200 / 900

class listMenu extends StatelessWidget {
  listMenu({Key? key, this.menus}) : super(key: key);
  final List<Menu>? menus;

  @override
  Widget build(BuildContext context) {
    /*
      Initialisation/Declaration des variables
      Test des parametres
   */
    const List<String> _jours = ["Lundi Midi","Lundi Soir","Mardi Midi","Mardi Soir", "Mercredi Midi", "Mercredi Soir","Jeudi Midi","Jeudi Soir","Vendredi Midi","Vendredi Soir","Samedi Midi","Samedi Soir","Dimanche Midi","Dimanche Soir"];
    if (this.menus != null) {
      Menu? menu = this.menus?.last;
      if (menu != null) {
        /* return widget*/
        return Center(
          child: ListView.builder(
              itemCount: menu.recettes.length, itemBuilder: (context, i) {
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
                    leading: Image.asset("assets/images/img${i + 1}.jpg"),
                    title: Text("${_jours[i]} : ${menu.recettes[i].titre}"),
                    subtitle: Text('ingredients : ' ),
                    trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          newRecette(elements: [],recette: menu.recettes[i],);
                        },
                        child: const Icon(Icons.more_vert),
                  ),
                ),
              ),
            ));
          }),
        );
      }
    }
    return Text('Aucun menu ... ');
  }
}
