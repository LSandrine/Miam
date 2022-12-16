class Ingredient{
  Ingredient(this.nom,this.quantite);
  final Element nom;
  final double quantite;

  @override
  String toString() {
    // TODO: implement toString
    return nom.toString();
  }
}

enum Element{
  Viande_poulet,
  Viande_Boeuf,
  Viande_Porc,
  Poisson_Gras,
  Poisson_Maigre,
  Courgette,
  Tomate,
  Oignon,
  Pates,
  Haricot_Rouge,
  Riz,
  Ail,
  Carotte,
  Poivron,
  Crevette,
  Epice_Curry,
  Epice_Chili,
  Creme_Coco,
  Poireau
}