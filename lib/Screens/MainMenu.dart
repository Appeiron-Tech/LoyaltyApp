import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testing/Models/ProductModel.dart';
import 'package:testing/Screens/LoginScreen.dart';
import 'package:testing/Screens/ProductList.dart';
import 'package:testing/Utils/globalVariables.dart';
import 'package:testing/Widgets/Carousel.dart';
import 'package:testing/Widgets/MenuOption.dart';

import 'BusinessInfo.dart';
import 'GamifyProgram.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  // // Fetch content from the json file
  // Future<void> readJson() async {
  //   final String response = await rootBundle.loadString('assets/sample.json');
  //   final data = await json.decode(response);
  //   setState(() { _items = data["items"]; });
  // }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: linesColor,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: colorText2,
        backgroundColor: linesColor,
        centerTitle: true,
        title: const Text(''),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Alma cafe', style: Theme.of(context).textTheme.headline1),
          const SizedBox(height: 10),
          Container(
            width: 500,
            height: 250,
            child: Expanded(
              child: Container(
                alignment: Alignment.center,
                child: const Carousel(typeAd: 'MENU'),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: const MenuOption(
                  title: 'Menú',
                  color: Color.fromRGBO(220, 129, 100, 1),
                  routeParam: ProductList.routeName,
                ),
              ),
              Container(
                child: const MenuOption(
                  title: 'Ubícanos',
                  color: Color.fromRGBO(210, 189, 100, 1),
                  routeParam: BusinessInfo.routeName,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 300, //
            child: ElevatedButton(
              onPressed: () async {
                FirebaseAuth _auth1 = await FirebaseAuth.instance;
                if (_auth1.currentUser == null) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                } else {
                  Navigator.of(context)
                      .pushNamed(GamifyProgram.routeName, arguments: {
                    'title': 'Gamify',
                  });
                }
              },
              child: Text('ACCESS GAME'),
            ),
          ),
        ],
      ),
    );
  }
}
