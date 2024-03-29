import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:testing/Screens/BusinessInfo.dart';
import 'package:testing/Screens/GamifyProgram.dart';
import 'package:testing/Screens/MainMenu.dart';

import 'Screens/ProductList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        canvasColor: Colors.white,
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyText1: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
          bodyText2: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
          headline1: const TextStyle(
            fontSize: 24,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold
          )
        )
      ),
      // home: const MainMenu(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => MainMenu(),
        ProductList.routeName: (ctx) => ProductList(),
        BusinessInfo.routeName: (ctx) => BusinessInfo(),
        GamifyProgram.routeName: (ctx) => GamifyProgram(),
      },
    );
  }
}