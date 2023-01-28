import 'package:miam/Menu/models/recette.dart';
import 'package:miam/Menu/models/ingredient.dart';

import '../data/database_helper.dart';

class Menu {
  final int idMenu;
  final List<Recette> recettes;
  final List<Ingredient> ingredients;

  const Menu({
    required this.idMenu,
    required this.recettes,
    required this.ingredients
  });

  Map<String,dynamic> toMap(){
    return {
      'idMenu':idMenu,
      'recettes':recettes,
      'ingredients':ingredients
    };
  }

  @override
  String toString(){
    String nomRecettes = (List.generate(recettes.length,(i) {return recettes[i].titre;})).join(' ') ;
    String nomIg = (List.generate(ingredients.length,(i) {return ingredients[i].elementIg.nom;})).join(' ');
    return 'Menu{recettes:'+nomRecettes+',ingredients:'+nomIg+'}';
  }

  String getListRecettes(){
    String txt = "";
    for(Recette re in recettes){
      txt += re.toString()+", ";
    }
    return txt;
  }

  Future<Map<String,double>> getListIngredients() async{
    List<int> allIdRecette = (List.generate(recettes.length,(i) {return recettes[i].id;}));
    //print(allIdRecette);
    Map<String,double> lIgQtt = {};
    for(var idR in allIdRecette){
      List<Ingredient> tmp = await DatabaseHelper.getIngredientsByRecette(idR);
      for(Ingredient ig in tmp){
        var el = await DatabaseHelper.getElementIg(ig.elementIg.id);
        //print(el);
        lIgQtt[el.nom] = ig.quantite;
      }
    }
    //print('ici '+lIgQtt.length.toString());
    return lIgQtt;
  }

}
