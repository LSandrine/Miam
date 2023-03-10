import 'package:flutter/material.dart';
import 'package:miam/Menu/models/recette.dart';
import '../data/database_helper.dart';

class newIngredient extends StatefulWidget {
  const newIngredient({Key? key,this.recette}) : super(key: key);
  final Recette? recette;
  @override
  State<newIngredient> createState() => _newRecetteState();
}

class _newRecetteState extends State<newIngredient> {
  final TextEditingController _titreController = TextEditingController();
  final TextEditingController _etapesController = TextEditingController();
  final TextEditingController _tmpPreparationController=TextEditingController();
  final TextEditingController _tmpCuissonController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _estEquilibreController =TextEditingController();

  get recette => null;
  //final TextEditingController _ingredientsController = TextEditingController();
  void clearField(){
    _titreController.text = "";
    _etapesController.text = "";
    _tmpPreparationController.text = "";
    _tmpCuissonController.text = "";
    _caloriesController.text = "";
    _estEquilibreController.text = 'MODERE';
  }
  @override
  void initState() {
    super.initState();
    if (recette != null) {
      _titreController.text = recette.titre;
      _etapesController.text = recette.etapes;
      _tmpPreparationController.text = recette.tmpPreparation.toString();
      _tmpCuissonController.text = recette.tmpCuisson.toString();
      _caloriesController.text = recette.calories.toString();
      _estEquilibreController.text = recette.estEquilibre;
    } else {
      clearField();
    }
  }
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(
          top: 15,
          left: 15,
          right: 15,
        ),
        child: Column(children: [
          SizedBox(
            height: 20,
            child: Text(
                '${recette != null ? 'Modifier ' : 'Ajouter '}une Recette'),
          ),
          Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextFormField(
                  controller: _titreController,
                  validator: formValidatorText,
                  decoration: const InputDecoration(hintText: 'Titre'),
                ),
                TextFormField(
                  controller: _etapesController,
                  validator: formValidatorText,
                  decoration: const InputDecoration(hintText: 'Etapes'),
                ),
                TextFormField(
                  controller: _tmpPreparationController,
                  validator: formValidatorText,
                  decoration: const InputDecoration(
                      hintText: 'Temps de pr??paration (minutes)'),
                ),
                TextFormField(
                  controller: _tmpCuissonController,
                  validator: formValidatorText,
                  decoration: const InputDecoration(
                      hintText: 'Temps de cuisson (minutes)'),
                ),
                TextFormField(
                  controller: _caloriesController,
                  validator: formValidatorText,
                  decoration: const InputDecoration(
                      hintText: 'Nombre de calories (kcal)'),
                ),
                DropdownButtonFormField(
                  validator: formValidatorText,
                  decoration: const InputDecoration(hintText: 'Est ??quilibr?? ?',
                    enabledBorder: OutlineInputBorder( //<-- SEE HERE
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder( //<-- SEE HERE
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    filled: true,
                    fillColor: Colors.green,
                  ),
                  dropdownColor: Colors.green,
                  items: <String>['PARFAIT', 'MODERE', 'IMPARFAIT']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(fontSize: 20),
                      ),
                    );
                  }).toList(),
                  value: _estEquilibreController.text,
                  onChanged: (String? newValue) {
                    _estEquilibreController.text = newValue!;
                  },
                ),
                const SizedBox(height: 50,),
                Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            clearField();
                            //Navigator.pop(context);
                          },
                          child: const Text("Annuler")),
                      ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            if (recette == null) {
                              await addRecette();
                            }
                            if (recette != null) {
                              await updateRecette(recette.id);
                            }
                            clearField();
                            // Close the bottom sheet
                            //Navigator.pop(men);
                          }
                        },
                        child: Text(recette == null ? 'Cr??er' : 'Sauvegarder'),
                      ),
                    ]),
              ],
            ),
          ),
        ])); ;
  }
  String? formValidatorText(String? value) {
    if (value!.isEmpty) return 'Field is Required';
    return null;
  }

  String? formValidatorDouble(String? value) {
    if (value!.isEmpty) return 'Field is Required';
    try {
      double test = value as double;
    } on Exception catch (_) {
      return 'Field is double';
    }
    return null;
  }


// Insert a new data to the database
  /*
      _titreController.text = "";
      _etapesController.text = "";
      _tmpPreparationController.text = "";
      _tmpCuissonController.text = "";
      _caloriesController.text = "";
      _estEquilibreController.text = 'MODERE';
   */
  Future<void> addRecette() async {
    await DatabaseHelper.createRecette(
        _titreController.text, _etapesController.text, double.parse(_tmpPreparationController.text),
        double.parse(_tmpCuissonController.text), double.parse(_caloriesController.text), _estEquilibreController.text);
  }

  // Update an existing data
  Future<void> updateRecette(int id) async {
    await DatabaseHelper.updateRecette(id,
        _titreController.text, _etapesController.text, double.parse(_tmpPreparationController.text),
        double.parse(_tmpCuissonController.text), double.parse(_caloriesController.text), _estEquilibreController.text);
  }

  // Delete an item
  void deleteRecette(int id) async {
    await DatabaseHelper.deleteRecette(id);
    print('delete OK');
  }
}