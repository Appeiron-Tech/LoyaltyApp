import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

final List<String> imgList = [
  'https://picsum.photos/500/500',
  'https://picsum.photos/500/500',
  'https://picsum.photos/500/500',
  'https://picsum.photos/500/500',
];

final List<Map<String, dynamic>> products = [
  {
    "id": "0",
    "name": "Producto 1",
    "description": "The standard Lorem Ipsum passage",
    "price": "S/.9.90",
    "category": "1",
    "image": "https://picsum.photos/200"
  },
  {
    "id": "1",
    "name": "Producto 2",
    "description": "The standard Lorem Ipsum passage",
    "price": "S/.9.90",
    "category": "1",
    "image": "https://picsum.photos/300"
  },
  {
    "id": "2",
    "name": "Producto 3",
    "description": "The standard Lorem Ipsum passage",
    "price": "S/.9.90",
    "category": "2",
    "image": "https://picsum.photos/200"
  },
  {
    "id": "3",
    "name": "Producto 4",
    "description": "The standard Lorem Ipsum passage",
    "price": "S/.9.90",
    "category": "2",
    "image": "https://picsum.photos/400"
  },
  {
    "id": "4",
    "name": "Producto 5",
    "description": "The standard Lorem Ipsum passage",
    "price": "S/.9.90",
    "category": "3",
    "image": "https://picsum.photos/300"
  },
  {
    "id": "5",
    "name": "Producto 6",
    "description": "The standard Lorem Ipsum passage",
    "price": "S/.9.90",
    "category": "4",
    "image": "https://picsum.photos/500"
  },
  {
    "id": "6",
    "name": "Producto 7",
    "description": "The standard Lorem Ipsum passage",
    "price": "S/.9.90",
    "category": "4",
    "image": "https://picsum.photos/200"
  }
];

class GamifyProgram extends StatefulWidget {
  static const routeName = '/gamify-program';

  @override
  State<GamifyProgram> createState() => _GamifyProgramState();
}

class _GamifyProgramState extends State<GamifyProgram>
    with SingleTickerProviderStateMixin {
  late TabController _qrController;

  @override
  void initState() {
    super.initState();
    _qrController = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Widget qrModal = Container(
      padding: EdgeInsets.only(top: 30, bottom: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 350,
            child: TabBarView(
              controller: _qrController,
              children: <Widget>[
                Container(
                  child: Column(
                    children: [
                      Text(
                        'Escanear código',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      QrImage(
                        data: "1234567890",
                        version: QrVersions.auto,
                        size: 250.0,
                      ),
                      Text('1234567890',
                          style: Theme.of(context).textTheme.bodyText1),
                      SizedBox(height: 20),
                      Text('Ten en cuenta que tu codigo termina en 34:00'),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Text(
                        'Indicar código',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      Text('1234567890',
                          style: Theme.of(context).textTheme.bodyText1),
                      SizedBox(height: 20),
                      Text('Ten en cuenta que tu codigo termina en 34:00'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: TabBar(
              labelColor: Colors.black,
              labelStyle: Theme.of(context).textTheme.headline6,
              controller: _qrController,
              tabs: const [
                Tab(
                  icon: Icon(null),
                  text: 'Scan QR',
                ),
                Tab(
                  icon: Icon(null),
                  text: 'Indicar codigo',
                ),
              ],
            ),
          ),
        ],
      ),
    );

    Widget _buildPopupDialog(BuildContext context, index) {
      return AlertDialog(
        title: const Text('2 Cuarto de libra + 2 patatas medianas'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(
                "https://images.pexels.com/photos/8305725/pexels-photo-8305725.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
            const SizedBox(height: 10),
            Text('${products[index]["name"]}'),
            const Text('Oferta valida hasta el 23/01/22'),
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 10,
              ),
            ),
            const SizedBox(height: 20),
            const Text('Requisitos'),
            const Text('content of a page when looking at its layout.'),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            textColor: Theme.of(context).primaryColor,
            child: const Text('Close'),
          ),
          FlatButton(
            onPressed: () {
              showMaterialModalBottomSheet(
                context: context,
                builder: (context) => qrModal,
              );
            },
            textColor: Theme.of(context).primaryColor,
            child: const Text('Activar'),
          ),
        ],
      );
    }

    final userSection = Container(
      margin: const EdgeInsets.all(10),
      color: Colors.red,
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        textBaseline: TextBaseline.ideographic,
        children: <Widget>[
          Container(
            width: 40,
            height: 50,
            color: Colors.purple,
            child: Center(
              child: new Text('a', style: TextStyle(fontSize: 20)),
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
        height: 150,
        child: Column(
          children: <Widget>[
            Text('Special Announcements', style: TextStyle(fontSize: 20)),
            Expanded(
              child: CarouselSlider(
                options: CarouselOptions(),
                items: imgList
                    .map((item) => Container(
                          child: Center(
                              child: Image.network(item, fit: BoxFit.cover)),
                        ))
                    .toList(),
              ),
            ),
          ],
        ));

    final giftCarrousel = Container(
        height: 150,
        child: Column(
          children: <Widget>[
            Text('Gift', style: TextStyle(fontSize: 20)),
            Expanded(
              child: CarouselSlider(
                options: CarouselOptions(),
                items: imgList
                    .map((item) => Container(
                          child: Center(
                              child: Image.network(item,
                                  fit: BoxFit.cover, width: 1000)),
                        ))
                    .toList(),
              ),
            ),
          ],
        ));

    final offersGrid = GridView.count(
      mainAxisSpacing: 10,
      crossAxisSpacing: 20,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      crossAxisCount: 2,
      children: List.generate(products.length, (index) {
        return GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return _buildPopupDialog(context, index);
                });
          },
          child: GridTile(
            child: Container(
              height: 40,
              color: Colors.green,
              child: Center(
                child: Text(
                  products[index]['name'],
                ),
              ),
            ),
          ),
        );
      }),
    );

    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    print(routeArgs);
    final title = routeArgs['title'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gamify Program'),
      ),
      body: Column(
        children: [
          userSection,
          Expanded(
            child: ListView(
              children: [
                specialAdCarrousel,
                giftCarrousel,
                offersGrid,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
