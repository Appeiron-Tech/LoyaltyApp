import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:testing/Screens/BusinessInfo.dart';
import 'package:testing/Screens/GamifyProgram.dart';
import 'package:testing/Screens/LoginScreen.dart';
import 'package:testing/Screens/MainMenu.dart';
import 'package:testing/Screens/OnboardingScreen.dart';
import 'package:testing/Screens/SignInScreen.dart';
import 'package:testing/Screens/WelcomePage.dart';

import 'Screens/ProductList.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
                  fontWeight: FontWeight.bold))),
      // home: const MainMenu(),
      initialRoute: '/',
      routes: {
        // '/': (ctx) => OnboardingScreen(),
        '/': (ctx) => WelcomePage(),
        // '/': (ctx) => LoginScreen(),
        ProductList.routeName: (ctx) => ProductList(),
        BusinessInfo.routeName: (ctx) => BusinessInfo(),
        GamifyProgram.routeName: (ctx) => GamifyProgram(),
      },
    );
  }
}
