import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testing/Models/ProductModel.dart';
import 'package:testing/Screens/ProductList.dart';
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

class _HomePageState extends State<MainMenu>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Loyalty App'),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      child: Carousel()
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: const MenuOption(
                            title: 'Product List',
                            color: Color.fromRGBO(220, 129, 100, 1),
                            routeParam: ProductList.routeName,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: const MenuOption(
                            title: 'Business Info',
                            color: Color.fromRGBO(210, 189, 100, 1),
                            routeParam: BusinessInfo.routeName,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: const MenuOption(
                      title: 'Gamify Program',
                      color: Color.fromRGBO(220, 189, 100, 1),
                      routeParam: GamifyProgram.routeName,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
