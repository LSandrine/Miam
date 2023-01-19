import 'package:miam/Menu/models/ingredient.dart';


class Recette {

  final int id;
  final String titre;
  final List<String> etapes;
  final List<Ingredient> ingredients;
  final double tmpPreparation;
  final double tmpCuisson;
  final double calories;
  final Equilibre estEquilibre;

  const Recette({
    required this.id,
    required this.titre,
    required this.etapes,
    required this.ingredients,
    required this.tmpPreparation,
    required this.tmpCuisson,
    required this.calories,
    required this.estEquilibre
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
  String getListElements(){
    String txt = "";
    for(Ingredient igd in ingredients){
      txt += igd.toString()+", ";
    }
    return txt;
  }

}

enum Equilibre{
  PARFAIT,
  MODERE,
  IMPARFAIT
}