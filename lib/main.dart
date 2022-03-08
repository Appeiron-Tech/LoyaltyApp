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
import 'package:google_fonts/google_fonts.dart';
import 'package:testing/Utils/globalVariables.dart';

import 'Screens/ProductList.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xfff93c64),
        textTheme: GoogleFonts.interTextTheme(textTheme).copyWith(
          bodyText1: const TextStyle(
            color: Color(0xff2d4057),
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
          bodyText2: const TextStyle(
            color: Color(0xff8893a0),
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
          labelMedium: const TextStyle(
            color: Color(0xfff93c64),
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
          caption: const TextStyle(
            color: Color(0xfff93c64),
            fontSize: 13,
            fontWeight: FontWeight.w300,
          ),
          headline1: const TextStyle(
            color: Color(0xff2d4057),
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
          headline2: const TextStyle(
            color: Color(0xff2d4057),
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
          button: const TextStyle(
            color: Color(0xfff2f4f7),
            fontSize: 10,
            fontWeight: FontWeight.w300,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: Theme.of(context).textTheme.button,
            padding:
                const EdgeInsets.only(left: 40, right: 40, top: 13, bottom: 13),
            elevation: 10,
            primary: mainCTAColor,
            shadowColor: shadowColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ),
      ),
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
