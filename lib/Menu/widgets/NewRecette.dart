import 'package:flutter/material.dart';
import 'package:miam/Menu/models/ingredient.dart';
import 'package:miam/Menu/models/recette.dart';
import '../data/database_helper.dart';

class newRecette extends StatefulWidget {
  const newRecette({Key? key, required this.elements,this.recette}) : super(key: key);
  final List<ElementIg> elements;
  final Recette? recette;
  @override
  State<newRecette> createState() => _newRecetteState(elements : elements,recette:recette);
}

class _newRecetteState extends State<newRecette> {
  //List<ElementIg> elements = widget.elements;
  List<ElementIg> elements;
  Recette? recette;
  _newRecetteState({required this.elements,Recette? this.recette});

  final List<Ingredient> listIngredient = [];
  final TextEditingController _titreController = TextEditingController();
  final TextEditingController _etapesController = TextEditingController();
  final TextEditingController _tmpPreparationController =        TextEditingController();
  final TextEditingController _tmpCuissonController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _estEquilibreController =        TextEditingController();

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
      _titreController.text = recette!.titre;
      _etapesController.text = recette!.etapes;
      _tmpPreparationController.text = recette!.tmpPreparation.toString();
      _tmpCuissonController.text = recette!.tmpCuisson.toString();
      _caloriesController.text = recette!.calories.toString();
      _estEquilibreController.text = recette!.estEquilibre;
    } else {
      clearField();
    }
  }
  final formKey = GlobalKey<FormState>();



  String qtt = '0';
  /*
   *
   */
  void bottomForm(List<ElementIg> _elementsIg) {
    ElementIg _selectedElement = _elementsIg.first;
    final TextEditingController qController = TextEditingController();
    qController.text = "";
    final formKey2 = GlobalKey<FormState>();
    var items = _elementsIg.map((item) {
      return DropdownMenuItem<ElementIg>(
        value: item,
        child: Text(item.nom),
      );
    }).toList();
    // if list is empty, create a dummy item
    if (items.isEmpty) {
      items = [
        DropdownMenuItem(
          value: _selectedElement,
          child: Text(_selectedElement.nom),
        )
      ];
    }
    String _quantite = "0";
    showModalBottomSheet(
        context: context,
        elevation: 5,
        isDismissible: false,
        isScrollControlled: true,
        builder: (_) => Container(
            padding: EdgeInsets.only(
              top: 15,
              left: 15,
              right: 15,
              // attention le clavier ne doit pas couvrir les fields
              bottom: MediaQuery.of(context).viewInsets.bottom + 120,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                DropdownButton<ElementIg>(items: items,value: _selectedElement, onChanged: (nVal)=> _selectedElement = nVal!),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: const InputDecoration(hintText: 'Quantité (grammes)'),
                  onChanged: (txt) {_quantite = txt;},
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
                          // Close the bottomForm
                          Navigator.pop(context);
                        },
                        child: const Text("Annuler")),
                    ElevatedButton(
                      onPressed: () async {
                        ElementIg el =_selectedElement;
                        Ingredient ig = Ingredient(id: 0, elementIg: el, quantite: double.parse(_quantite));
                        // Ajouter aux ingrédients
                        listIngredient.add(ig);
                        // Close the bottomForm
                        Navigator.pop(context);
                      },
                      child: Text('Ajouter un ingrédient'),
                    ),
                  ],
                )
              ],
            )));
  }


  //
  @override
  Widget build(BuildContext context) {
    //return widget
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
                      hintText: 'Temps de préparation (minutes)'),
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
                  decoration: const InputDecoration(hintText: 'Est équilibré ?',
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
                          },
                          child: const Text("Annuler")),
                      ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            if (recette == null) {
                              await addRecette();
                            }
                            if (recette != null) {
                              await updateRecette(recette!.id);
                            }
                            clearField();
                          }
                        },
                        child: Text(recette == null ? 'Créer' : 'Sauvegarder'),
                      ),
                    ]),
              ],
            ),
          ),
          FloatingActionButton(
            child: const Icon(Icons.add_box_sharp,color: Colors.white,),
            onPressed: () => bottomForm(elements),
          ),

        ],)
    );
  }
  /*
   * Function de validation des champ text
   * @param String, valeur à tester.
   * @return String, text d'information en cas de problem, null sinon.
   */
  String? formValidatorText(String? value) {
    if (value!.isEmpty) return 'Field is Required';
    return null;
  }
/*
   * Function de validation des champ double
   * @param String, valeur à transformer en double.
   * @return String, text d'information en cas de problem, null sinon.
   */
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
   * Fonction d'ajout d'une recette en bd.
   */
  Future<void> addRecette() async {
    int idR = await DatabaseHelper.createRecette(
        _titreController.text, _etapesController.text, double.parse(_tmpPreparationController.text),
        double.parse(_tmpCuissonController.text), double.parse(_caloriesController.text), _estEquilibreController.text);

    for(Ingredient ig in listIngredient){
      await DatabaseHelper.createIngredient(idR, ig.elementIg.id, ig.quantite);
    }

  }

  /*
   * Fonction de modification d'une recette en bd.
   * @param int, id de la ligne a modifier.
   */
  Future<void> updateRecette(int id) async {
    await DatabaseHelper.updateRecette(id,
        _titreController.text, _etapesController.text, double.parse(_tmpPreparationController.text),
        double.parse(_tmpCuissonController.text), double.parse(_caloriesController.text), _estEquilibreController.text);
  }

  /*
   * Fonction supprimer une recette en bd.
   * @param int, id de la ligne a supprimer.
   */
  void deleteRecette(int id) async {
    await DatabaseHelper.deleteRecette(id);
    print('delete OK');
  }
}