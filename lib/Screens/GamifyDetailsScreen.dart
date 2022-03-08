import 'package:flutter/material.dart';

class GamifyDetailsPage extends StatefulWidget {
  const GamifyDetailsPage({Key? key}) : super(key: key);

  @override
  State<GamifyDetailsPage> createState() => _GamifyDetailsPageState();
}

class _GamifyDetailsPageState extends State<GamifyDetailsPage> {
  List compras = [
    "Compra 1",
    "Compra 2",
    "Compra 3",
    "Compra 4",
    "Compra 5",
    "Compra 6"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User gamify'),
      ),
      body: Column(
        children: [
          Text('Usted tiene 10 puntos'),
          Text('usted está en el nivel 10'),
          LinearProgressIndicator(),
          Text('Últimas compras'),
          SingleChildScrollView(
            child: ListView.builder(
              itemCount: compras.length,
              itemBuilder: (context, index) {
                return Center(
                  child: Text(compras[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
