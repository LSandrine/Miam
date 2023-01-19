import 'package:flutter/material.dart';
import 'package:miam/Menu/models/recette.dart';

import '../data/database_helper.dart';

class NouveauIngredient extends StatelessWidget {
  NouveauIngredient({Key? key, this.id}) : super(key: key);
  final int? id;
  final TextEditingController _nomEIg = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
          key: formKey,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextFormField(
                  controller: _nomEIg,
                  validator: formValidator,
                  decoration: const InputDecoration(hintText: 'Nom'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          //Navigator.pop(context);
                        },
                        child: const Text("Exit")),
                    ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          if (id == null) {
                            await addElement();
                          }

                          if (id != null) {
                            await updateElement(id!);
                          }

                          // Close the bottom sheet
                          //Navigator.pop(context);
                        }
                        // Save new data
                      },
                      child: Text(id == null ? 'Nouveau ' : 'Modifier '),
                    ),
                  ],
                )
              ])),
    );
  }

  String? formValidator(String? value) {
    if (value!.isEmpty) return 'Le nom est nécessaire ! ';
    return null;
  }

  // Insert a new data to the database
  Future<void> addElement() async {
    await DatabaseHelper.createElementIg(_nomEIg.text);
  }

  // Update an existing data
  Future<void> updateElement(int id) async {
    await DatabaseHelper.updateElementIg(id, _nomEIg.text);
  }
}
