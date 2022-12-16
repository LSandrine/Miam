import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [
        ListView(
          children: const <Widget>[
            Card(
              child: ListTile(
                leading: FlutterLogo(size: 72.0),
                title: Text('Lundi'),
                subtitle: Text(
                    'A sufficiently long subtitle warrants three lines.'
                ),
                trailing: Icon(Icons.more_vert),
                isThreeLine: true,
              ),
            ),
          ],
        )
      ],
      ),
    );
  }
}
