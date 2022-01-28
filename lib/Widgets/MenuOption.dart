import 'package:flutter/material.dart';
import 'package:testing/Screens/ProductList.dart';

class MenuOption extends StatelessWidget {
  final String title;
  final Color color;
  final String routeParam;

  const MenuOption({required this.title, required this.routeParam, required this.color});

  void selectItem(BuildContext ctx){
    Navigator.of(ctx).pushNamed(
      routeParam,
      arguments: {
        'title': title,
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectItem(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Text(title, style: Theme.of(context).textTheme.headline1,),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.6), color
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12)
        ),
      ),
    );
  }
}
