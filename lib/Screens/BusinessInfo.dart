import 'package:flutter/material.dart';

class BusinessInfo extends StatelessWidget {
  static const routeName = '/business-info';

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final title = routeArgs['title'];
    return Scaffold(
      appBar: AppBar(title: const Text('Business Info'),),
      body: Center(
        child: Text('option screen ID:' + title!),
      ),
    );
  }
}
