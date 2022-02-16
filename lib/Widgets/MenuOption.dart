import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testing/Screens/GamifyProgram.dart';
import 'package:testing/Screens/LoginScreen.dart';
import 'package:testing/Screens/ProductList.dart';
import 'package:testing/Screens/SignInScreen.dart';

class MenuOption extends StatelessWidget {
  final String title;
  final Color color;
  final String routeParam;

  const MenuOption(
      {required this.title, required this.routeParam, required this.color});

  void verifyUser(BuildContext ctx) async {
    print("Estoy en verify");
    // verificar si el usuario está logeado
    FirebaseAuth _auth1 = await FirebaseAuth.instance;
    if (_auth1.currentUser == null) {
      Navigator.of(ctx).push(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    } else {
      selectItem(ctx);
    }
  }

  void selectItem(BuildContext ctx) {
    print("Estoy en select");
    Navigator.of(ctx).pushNamed(routeParam, arguments: {
      'title': title,
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () => selectItem(context),
      onTap: () => routeParam == GamifyProgram.routeName
          ? verifyUser(context)
          : selectItem(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline1,
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withOpacity(0.6), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
