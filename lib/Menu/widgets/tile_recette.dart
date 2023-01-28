import 'package:flutter/material.dart';
import 'package:miam/Menu/models/recette.dart';

class tileRecette extends StatelessWidget {
  const tileRecette({Key? key, required this.recette}) : super(key: key);
  final Recette recette;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
        Text(recette.titre),
        Row(children:[
          Text(recette.getListElements() ),
        ])
        ]
    );
  }
}
