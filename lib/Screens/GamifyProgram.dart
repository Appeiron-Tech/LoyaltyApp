import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

final List<String> imgList = [
  'https://picsum.photos/500/500',
  'https://picsum.photos/500/500',
  'https://picsum.photos/500/500',
  'https://picsum.photos/500/500',
];

class GamifyProgram extends StatelessWidget {
  static const routeName = '/gamify-program';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    print(routeArgs);
    final title = routeArgs['title'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gamify Program'),
      ),
      body: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              userSection,
              specialAdCarrousel,
              giftCarrousel,
              offersGrid,
            ],
          ),
        ),
      ),
    );
  }

  final userSection = Container(
    margin: const EdgeInsets.all(15),
    color: Colors.red,
    child: new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      textBaseline: TextBaseline.ideographic,
      children: <Widget>[
        Container(
          width: 40,
          height: 80,
          color: Colors.purple,
          child: Center(
            child: new Text('a', style: TextStyle(fontSize: 30)),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.blue,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Gabriela Vega'),
                  Text('Gabriela Vega'),
                ]),
          ),
        ),
        Container(
          color: Colors.grey,
          child: new Text('70', style: TextStyle(fontSize: 40)),
        ),
      ],
    ),
  );

  final specialAdCarrousel = Container(
      height: 200,
      child: Column(
        children: <Widget>[
          Text('Special Announcements', style: TextStyle(fontSize: 30)),
          CarouselSlider(
            options: CarouselOptions(),
            items: imgList
                .map((item) => Container(
                      child: Center(
                          child: Image.network(item,
                              fit: BoxFit.cover, width: 1000)),
                    ))
                .toList(),
          ),
        ],
      ));

  final giftCarrousel = Container(
      height: 200,
      child: Column(
        children: <Widget>[
          Text('Gift', style: TextStyle(fontSize: 30)),
          CarouselSlider(
            options: CarouselOptions(),
            items: imgList
                .map((item) => Container(
                      child: Center(
                          child: Image.network(item,
                              fit: BoxFit.cover, width: 1000)),
                    ))
                .toList(),
          ),
        ],
      ));

  final offersGrid = Container(
    height: 151,
    color: Colors.pink,
  );
}
