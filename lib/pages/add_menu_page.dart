import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

class AddMenuPage extends StatefulWidget {
  const AddMenuPage({Key? key}) : super(key: key);

  @override
  State<AddMenuPage> createState() => _AddMenuPageState();
}

class _AddMenuPageState extends State<AddMenuPage> {

  final _formkey = GlobalKey<FormState>();

  final menuNameController = TextEditingController();
  final descriptionNameController = TextEditingController(); // base de donnée
DateTime selctedMenuType = DateTime.now();

  @override
  void dispose() {
    super.dispose();
    menuNameController.dispose();
    descriptionNameController.dispose();
  } // pour degager de l'espace

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Nom Menu' ,
                hintText: 'Entrer le nom du menu',
                border: OutlineInputBorder(),
              ),
              validator: (value){
                if (value== null || value.isEmpty){
                  return "vous devez completer ce texte";
                }
                return null;
              },
              controller: menuNameController,
            ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Description' ,
                    hintText: 'Entrer les ingredients',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value){
                    if (value== null || value.isEmpty){
                      return "vous devez completer ce texte";
                    }
                    return null;
                  },
                controller: descriptionNameController,
              ),
            ),

            Container(
              margin: EdgeInsets.only(bottom: 10),
            child: DateTimeFormField(
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.black45),
                errorStyle: TextStyle(color: Colors.redAccent),
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.event_note),
                labelText: 'choisir une date',
              ),
              mode: DateTimeFieldPickerMode.dateAndTime,
              autovalidateMode: AutovalidateMode.always,
              validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
              onDateSelected: (DateTime value) {
                setState(() {
                  selctedMenuType = value;
                }); // pour afficher la date  et le temps
              },
            ),
            ),
            SizedBox(
              width: double.infinity,
            height: 50,
            child: ElevatedButton(
                onPressed:(){
                  if (_formkey.currentState!.validate()){
                    final menuName = menuNameController.text;
                    final descriptionName = descriptionNameController.text;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Envoi en cours..."))
                    );
                    FocusScope.of(context).requestFocus(FocusNode()); // pour fermer le clavier une fois saisie
print("Ajout du menu $menuName par la description $descriptionNameController");
  print("Date du menu $selctedMenuType");                }
                },
                child: Text("Envoyer")
            ),
            )
          ],
        )
    ),
    );
  }
}

