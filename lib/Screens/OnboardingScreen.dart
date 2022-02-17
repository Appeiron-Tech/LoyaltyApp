import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:testing/Screens/MainMenu.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            title: 'Para empezar ten en cuenta lo siguiente',
            body:
                'Dicta tu DNI en todas las compras para acceder a las promociones',
          ),
          PageViewModel(
            title: 'Title',
            body: 'Tu nivel se evalua 4 meses',
          ),
          PageViewModel(
            title: 'Title',
            body: 'A mayor consumo mayor beneficio.',
          ),
        ],
        onDone: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const MainMenu();
              },
            ),
          );
        },
        skip: const Icon(Icons.skip_next),
        next: const Icon(Icons.forward),
        done: const Text("Comenzar",
            style: TextStyle(fontWeight: FontWeight.w600)),
        dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            activeColor: Colors.blue,
            color: Colors.black26,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0))),
      ),
    );
  }
}
