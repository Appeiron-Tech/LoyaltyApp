import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:testing/Screens/MainMenu.dart';

final List<String> imgList = [
  'https://picsum.photos/500/500',
  'https://picsum.photos/500/500',
  'https://picsum.photos/500/500',
  'https://picsum.photos/500/500',
];

const durationImg = 3;

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = Duration(seconds: imgList.length * durationImg);
    Timer timerSkip = Timer(duration, route);
    return timerSkip;
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MainMenu()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        final double height = MediaQuery.of(context).size.height;
        return Container(
          child: Stack(
            alignment: Alignment.topRight,
            children: <Widget>[
              CarouselSlider(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height,
                  viewportFraction: 1,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: durationImg),
                ),
                items: imgList
                    .map((item) => Container(
                          child: Center(
                              child: Image.network(
                            item,
                            fit: BoxFit.cover,
                            height: height,
                          )),
                        ))
                    .toList(),
              ),
              IconButton(
                onPressed: () {
                  route();
                },
                icon: const Icon(Icons.close),
                iconSize: 60,
              ),
            ],
          ),
        );
      }),
    );
  }
}
