// ignore: import_of_legacy_library_into_null_safe;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:testing/Screens/GamifyProgram.dart';
import 'package:testing/Screens/HomeScreen.dart';
import 'package:testing/Screens/MainMenu.dart';
import 'package:testing/Screens/OnboardingScreen.dart';
import 'package:testing/Screens/UserScreen.dart';
import 'package:testing/Screens/WelcomePage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testing/Utils/globalVariables.dart';
import 'package:provider/provider.dart';

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
      debugShowCheckedModeBanner: false,
      title: 'Loyalty App',
      theme: ThemeData(
        primaryColor: const Color(0xfff93c64),
        textTheme: GoogleFonts.interTextTheme(textTheme).copyWith(
          headline3: const TextStyle(
            color: Color(0xfff2f4f7),
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
          bodyText1: const TextStyle(
            color: Color(0xff2d4057),
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
          bodyText2: const TextStyle(
            color: Color(0xff8893a0),
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
          labelMedium: const TextStyle(
            color: Color(0xfff93c64),
            fontSize: 17,
            fontWeight: FontWeight.w400,
          ),
          caption: const TextStyle(
            color: Color(0xfff93c64),
            fontSize: 13,
            fontWeight: FontWeight.w300,
          ),
          headline1: const TextStyle(
            color: Color(0xff2d4057),
            fontSize: 25,
            fontWeight: FontWeight.w700,
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
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: const TextStyle(fontSize: 13),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          constraints: const BoxConstraints(maxHeight: 50),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xfff93c64), width: 1.0),
            borderRadius: BorderRadius.circular(25.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xfff93c64), width: 1.0),
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
        chipTheme: ChipThemeData(
          elevation: 2,
          shape:
              StadiumBorder(side: BorderSide(color: Colors.white, width: 1.0)),
          backgroundColor: Color.fromARGB(96, 248, 90, 101),
          disabledColor: Colors.white,
          labelStyle:
              TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),
          selectedColor: Color.fromARGB(96, 248, 90, 101),
        ),
      ),
      // home: ChangeNotifierProvider<ValueNotifier<int>>.value(
      //   value: ValueNotifier<int>(0),
      //   child: MyNavigationBar(),
      // ),
      home: SplashScreen.timer(
        seconds: 5,
        navigateAfterSeconds: ChangeNotifierProvider<ValueNotifier<int>>.value(
          value: ValueNotifier<int>(0),
          child: MyNavigationBar(),
        ),
        image: Image.asset('assets/images/logo_splash.png'),
        photoSize: 150.0,
        backgroundColor: mainCTAColor,
        loaderColor: Colors.white,
      ),
    );
  }
}

class MyNavigationBar extends StatefulWidget {
  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  final List<Widget> _children = [
    const HomePage(),
    const MainMenu(),
    GamifyProgram(),
    const UserPage(),
  ];

  void OnTappedBar(int index) {
    Provider.of<ValueNotifier<int>>(context, listen: false).value = index;
    print(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _children[Provider.of<ValueNotifier<int>>(context).value],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 5, top: 5),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          boxShadow: [
            BoxShadow(color: Color.fromARGB(255, 232, 235, 238), blurRadius: 1),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: BottomNavigationBar(
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            selectedItemColor: mainCTAColor,
            unselectedItemColor: colorText1,
            onTap: OnTappedBar,
            currentIndex: Provider.of<ValueNotifier<int>>(context).value,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: "Restaurant"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart), label: "Game"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile"),
            ],
          ),
        ),
      ),
    );
  }
}
