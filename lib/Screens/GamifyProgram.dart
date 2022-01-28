import 'package:flutter/material.dart';

class GamifyProgram extends StatelessWidget {
  static const routeName = '/gamify-program';

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final title = routeArgs['title'];
    return Scaffold(
      appBar: AppBar(title: const Text('Gamify Program'),),
      body: Center(
        child: Text('option screen ID:' + title!),
      ),
    );
  }
}
