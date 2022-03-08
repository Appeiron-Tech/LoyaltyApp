import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:testing/Models/GamifyModel.dart';
import 'package:testing/Models/GiftModel.dart';
import 'package:testing/Models/OfferModel.dart';
import 'package:testing/Resources/auth_methods.dart';
import 'package:testing/Resources/firestore_methods.dart';
import 'package:testing/Screens/GamifyDetailsScreen.dart';
import 'package:testing/Screens/MainMenu.dart';
import 'package:testing/Screens/SurveyScreen.dart';
import 'package:testing/Screens/UserScreen.dart';
import 'package:testing/Utils/utils.dart';
import 'package:testing/Widgets/Carousel.dart';
import '../Models/UserModel.dart';

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
  bool isLoading = false;
  List<OfferModel> offers = [];
  List<GiftModel> gifts = [];
  late TabController _qrController;
  UserModel? currentsUser;
  GamifyModel? gamify;

  @override
  void initState() {
    _qrController = TabController(length: 2, vsync: this);
    getData();
    super.initState();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });

    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;

      currentsUser = await AuthMethods().getUserDetails();
      offers = await FirestoreMethods().getOffers(userId);
      gifts = await FirestoreMethods().getGifts(userId);
      gamify = await FirestoreMethods().getGamify(userId);

      setState(() {});
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MainMenu()));
  }

  @override
  Widget build(BuildContext context) {
    Widget qrModal = Container(
      padding: const EdgeInsets.only(top: 30, bottom: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 350,
            child: TabBarView(
              controller: _qrController,
              children: <Widget>[
                Column(
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
                    const SizedBox(height: 20),
                    const Text('Ten en cuenta que tu codigo termina en 34:00'),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Indicar código',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Text('1234567890',
                        style: Theme.of(context).textTheme.bodyText1),
                    const SizedBox(height: 20),
                    const Text('Ten en cuenta que tu codigo termina en 34:00'),
                  ],
                ),
              ],
            ),
          ),
          TabBar(
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
            CachedNetworkImage(imageUrl: "https://picsum.photos/200"),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        textBaseline: TextBaseline.ideographic,
        children: <Widget>[
          Container(
            width: 40,
            height: 50,
            color: Colors.purple,
            child: Center(
              child: Text(
                gamify?.level.toString() ?? '0',
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(currentsUser?.name ?? "Name"),
                    Text('Subtitulo'),
                    TextButton(
                      onPressed: () {
                        logout();
                      },
                      child: Text("LOG OUT"),
                    ),
                  ]),
            ),
          ),
          Container(
            color: Colors.grey,
            child: Text(gamify?.points.toString() ?? '0',
                style: const TextStyle(fontSize: 40)),
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
              child: Carousel(typeAd: 'GAMIFY'),
            ),
          ],
        ));

    final giftCarrousel = Container(
        height: 150,
        child: Column(
          children: <Widget>[
            const Text('Gift', style: TextStyle(fontSize: 20)),
            Expanded(
              child: CarouselSlider(
                options: CarouselOptions(),
                items: gifts
                    .map((item) => Center(
                        child: CachedNetworkImage(
                            imageUrl: item.image,
                            fit: BoxFit.cover,
                            width: 1000)))
                    .toList(),
              ),
            ),
          ],
        ));

    final offersGrid = GridView.count(
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      crossAxisCount: 2,
      children: offers.map((offer) {
        return GestureDetector(
          onTap: () {
            // showDialog(
            //     context: context,
            //     builder: (BuildContext context) {
            //       return _buildPopupDialog(context, index);
            //     });
          },
          child: Material(
            elevation: 2,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: Container(
              clipBehavior: Clip.hardEdge,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(offer.title,
                            style: Theme.of(context).textTheme.headline4),
                        const SizedBox(height: 5),
                        Text(offer.description,
                            style: Theme.of(context).textTheme.bodyText1),
                        const SizedBox(height: 10),
                        Text("S/. 9.00",
                            style: Theme.of(context).textTheme.headline6),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );

    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;

    final title = routeArgs['title'];

    return isLoading
        ? const Center(
            child: CircularProgressIndicator(backgroundColor: Colors.white),
          )
        : Scaffold(
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
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SurveyPage(),
                            ),
                          );
                        },
                        child: Text('Survey'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => UserPage(),
                            ),
                          );
                        },
                        child: Text('Profile'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => GamifyDetailsPage(),
                            ),
                          );
                        },
                        child: Text('My level'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
