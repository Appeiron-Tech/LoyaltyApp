import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testing/Screens/GamifyProgram.dart';
import 'package:testing/Screens/LoginScreen.dart';
import 'package:testing/Screens/ProductList.dart';
import 'package:testing/Screens/SignInScreen.dart';
import 'package:testing/Utils/globalVariables.dart';

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
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Card(
          elevation: 10,
          shadowColor: shadowColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 140.0,
                height: 90.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                      'https://picsum.photos/500/500',
                    ),
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
