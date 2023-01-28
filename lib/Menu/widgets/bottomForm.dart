import 'package:flutter/material.dart';

/*

void showMyForm(int? id) async {
  // id == null -> create new item
  // id != null -> update an existing item
  if (id != null) {
    final existingData = myData.firstWhere((element) => element['id'] == id);
    _titleController.text = existingData['title'];
    _descriptionController.text = existingData['description'];
  } else {
    _titleController.text = "";
    _descriptionController.text = "";
  }

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
            // prevent the soft keyboard from covering the text fields
            bottom: MediaQuery.of(context).viewInsets.bottom + 120,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextFormField(
                  controller: _titleController,
                  validator: formValidator,
                  decoration: const InputDecoration(hintText: 'Title'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: formValidator,
                  controller: _descriptionController,
                  decoration: const InputDecoration(hintText: 'Description'),
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
                          Navigator.pop(context);
                        },
                        child: const Text("Exit")),
                    ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          if (id == null) {
                            await addItem();
                          }

                          if (id != null) {
                            await updateItem(id);
                          }

                          // Clear the text fields
                          setState(() {
                            _titleController.text = '';
                            _descriptionController.text = '';
                          });

                          // Close the bottom sheet
                          Navigator.pop(context);
                        }
                        // Save new data
                      },
                      child: Text(id == null ? 'Create New' : 'Update'),
                    ),
                  ],
                )
              ],
            ),
          )));
}
*/