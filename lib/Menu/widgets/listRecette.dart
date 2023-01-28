import 'package:flutter/material.dart';
import '../models/recette.dart';

class listRecette extends StatelessWidget {
  listRecette({Key? key, required this.recettes}) : super(key: key);
  final List<Recette> recettes;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
          itemCount: recettes.length, itemBuilder: (context, i) {
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
                title: Text(recettes[i].titre),
                subtitle: Text('${recettes[i].tmpPreparation + recettes[i].tmpCuisson} minutes (${recettes[i].tmpPreparation} / ${recettes[i].tmpPreparation})'),
              ),
            ),
          ),
        );
      }),
    );
  }
}