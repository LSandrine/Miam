import 'package:flutter/material.dart';

import 'menu_page.dart';
class HomePage extends StatelessWidget {

  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment:MainAxisAlignment.center ,
        children:  [
          Image.asset("assets/images/home.png"),
          const Text("Bienvenue sur Miam",
            style: TextStyle(
                fontSize: 28,
                fontFamily: 'Poppins'
            ),
          ),
          Padding(padding: EdgeInsets.only(top:20)),
        ],
      ),
    );
  }
}

