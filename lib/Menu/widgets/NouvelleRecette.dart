import 'package:flutter/material.dart';
import 'package:miam/Menu/models/recette.dart';

class tileJour extends StatelessWidget {
  const tileJour({Key? key,required this.nom,required this.recetteDuJour}): super(key: key);
  final String nom;
  final Recette recetteDuJour;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(nom),

    ],);
  }
}
// listTile ! composant flutter
