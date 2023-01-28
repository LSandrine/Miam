class Ingredient{
  final int id;
  final ElementIg elementIg;
  final double quantite;

  const Ingredient({
    required this.id,
    required this.elementIg,
    required this.quantite,
  });

  Map<String,dynamic> toMap(){
    return{
      'id':id,
      'elementIg':elementIg,
      'quantite':quantite,
    };
  }
  @override
  String toString(){
    return 'Ingredient{id:$id,elementIg:$elementIg,quantite:$quantite}';
  }
}


class ElementIg{
  final int id;
  final String nom;

  //ElementIg(this.id,this.nom);

  const ElementIg({
    required this.id,
    required this.nom,
  });


  Map<String,dynamic> toMap(){
    return{
      'id':id,
      'nom':nom,
    };
  }
  @override
  String toString(){
    return 'ElementIg{id:$id,nom:$nom}';
  }
}
/*
enum ElementIg{
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
*/