import 'package:miam/Menu/models/ingredient.dart';

import '../data/database_helper.dart';


class Recette {

  final int id;
  final String titre;
  final String etapes;
  final List<Ingredient> ingredients;
  final double tmpPreparation;
  final double tmpCuisson;
  final double calories;
  final String estEquilibre;

  static String listIg = '';

  const Recette({
    required this.id,
    required this.titre,
    required this.etapes,
    required this.ingredients,
    required this.tmpPreparation,
    required this.tmpCuisson,
    required this.calories,
    required this.estEquilibre,
  });

  Map<String,dynamic> toMap(){
    return {
      'id':id,
      'titre':titre,
      'etapes':etapes,
      'ingredients':ingredients,
      'tmpPreparation':tmpPreparation,
      'tmpCuisson':tmpCuisson,
      'calories':calories,
      'estEquilibre':estEquilibre
    };
  }
  @override
  String toString(){
    return 'Recette{id:$id,titre:$titre,etapes:$etapes,ingredients:$ingredients,tmpPreparation:$tmpPreparation,tmpCuisson:$tmpCuisson,calories:$calories,estEquilibre:$estEquilibre}';
  }

  List<Recette> loadJson(){
    List<Recette> lr = [];
    return lr;
  }
  void getListElements() async {
    List<ElementIg> elem = [];
    for(Ingredient ig in ingredients){
      ElementIg e = await DatabaseHelper.getElementIg(ig.elementIg.id);
      elem.add(e);
    }
    listIg =  (List.generate(elem.length,(i) {return elem[i].nom;})).join(' ');
  }


}

enum Equilibre{
  PARFAIT,
  MODERE,
  IMPARFAIT
}