import 'package:flutter/material.dart';
import 'package:testing/Utils/globalVariables.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String appBarText;
  final Color appbackgroundColor;
  const AppBarWidget({
    Key? key,
    required this.appBarText,
    required this.appbackgroundColor,
  }) : super(key: key);

  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      foregroundColor: colorText2,
      backgroundColor: appbackgroundColor,
      centerTitle: true,
      title: Text(appBarText),
    );
  }
}
