import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing/Utils/globalVariables.dart';

class SurveySentPage extends StatelessWidget {
  const SurveySentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: linesColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            child: const Center(
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 60,
              ),
            ),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff5ccd92),
                  Color(0xffbfe89c),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Respuestas enviadas',
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              '¡Gracias por tu tiempo! Ahora podrás ver tus puntos acumulados por tu compra.',
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Ver mi puntaje'),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Back game'),
          ),
        ],
      ),
    );
  }
}
