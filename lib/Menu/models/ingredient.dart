class Ingredient{
  final int id;
  final ElementIg nom;
  final double quantite;

  const Ingredient({
    required this.id,
    required this.nom,
    required this.quantite,
  });

  Map<String,dynamic> toMap(){
    return{
      'id':id,
      'nom':nom,
      'quantite':quantite,
    };
  }
  @override
  String toString(){
    return 'Ingredient{id:$id,nom:$nom,quantite:$quantite}';
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