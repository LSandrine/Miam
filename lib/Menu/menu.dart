import 'package:flutter/material.dart';
import 'package:miam/Menu/widgets/NouveauIngredient.dart';
import 'data/database_helper.dart';
import 'models/ingredient.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);
  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<Map<String, dynamic>> myData = [];
  List<ElementIg> _elements = [];
  final formKey = GlobalKey<FormState>();
  bool _isLoading = true;
  // This function is used to fetch all data from the database
  void _refreshData() async {
    final data = await DatabaseHelper.getItems();
    final elements = await DatabaseHelper.getElementIgs();
    setState(() {
      myData = data;
      _elements = elements;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData(); // Loading the data when the app starts
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // This function will be triggered when the floating button is pressed
  // It will also be triggered when you want to update an item
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

  String? formValidator(String? value) {
    if (value!.isEmpty) return 'Field is Required';
    return null;
  }

// Insert a new data to the database
  Future<void> addItem() async {
    await DatabaseHelper.createItem(
        _titleController.text, _descriptionController.text);
    _refreshData();
  }

  // Update an existing data
  Future<void> updateItem(int id) async {
    await DatabaseHelper.updateItem(
        id, _titleController.text, _descriptionController.text);
    _refreshData();
  }

  // Delete an item
  void deleteItem(int id) async {
    await DatabaseHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Successfully deleted!'), backgroundColor: Colors.green));
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Miam !'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.restaurant_menu)),
              Tab(icon: Icon(Icons.menu_book)),
              Tab(icon: Icon(Icons.receipt_long)),
            ],
          ),
        ),
        body: TabBarView(children: [
          _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : myData.isEmpty
                  ? const Center(child: Text("No Data Available!!!"))
                  : ListView.builder(
                      itemCount: myData.length,
                      itemBuilder: (context, index) => Card(
                        color:index % 2 == 0 ? Colors.green : Colors.green[200],
                        margin: const EdgeInsets.all(15),
                        child: ListTile(
                            title: Text(myData[index].toString()),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () =>
                                        showMyForm(myData[index]['id']),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () =>
                                        deleteItem(myData[index]['id']),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
          NouveauIngredient(),
          ListView.builder(
            itemCount: _elements.length,
            itemBuilder: (context, index) => Card(
              color:index % 2 == 0 ? Colors.green : Colors.green[200],
              margin: const EdgeInsets.all(15),
              child: ListTile(
                  title: Text(_elements[index].toString()),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () =>
                              _refreshData(),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () =>
                              _refreshData(),
                        ),
                      ],
                    ),
                  )),
            ),
          ),

        ]),
        floatingActionButton: Row(
          children: [
            FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () => showMyForm(null),
            ),
            FloatingActionButton(
              child: const Icon(Icons.send),
              onPressed: () => showMyForm(null),
            ),
          ],
        ),
      ),
    );
  }
}
