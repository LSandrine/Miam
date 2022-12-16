import 'package:miam/Menu/models/ingredient.dart';

class Recette {
  Recette (this.titre,this.ingredients,this.tmpCuisson,this.tmpPreparation,this.calories,this.estEquilibre,this.etapes);

  final String titre;
  final List<String> etapes;
  final List<Ingredient> ingredients;
  final double tmpPreparation;
  final double tmpCuisson;
  final double calories;
  final Equilibre estEquilibre;

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