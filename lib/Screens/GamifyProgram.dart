import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:testing/Models/GamifyModel.dart';
import 'package:testing/Models/GiftModel.dart';
import 'package:testing/Models/OfferModel.dart';
import 'package:testing/Resources/auth_methods.dart';
import 'package:testing/Resources/firestore_methods.dart';
import 'package:testing/Screens/GamifyDetailsScreen.dart';
import 'package:testing/Screens/OfferScreen.dart';
import 'package:testing/Screens/SurveyScreen.dart';
import 'package:testing/Utils/globalVariables.dart';
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
  const GamifyProgram({Key? key}) : super(key: key);

  @override
  State<GamifyProgram> createState() => _GamifyProgramState();
}

class _GamifyProgramState extends State<GamifyProgram> {
  bool isLoading = false;
  List<OfferModel> offers = [];
  List<GiftModel> gifts = [];

  UserModel? currentsUser;
  GamifyModel? gamify;

  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    final userSection = Card(
        color: cardColor,
        elevation: 10,
        shadowColor: shadowColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Alma cafe',
                      style: Theme.of(context).textTheme.headline1),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: CachedNetworkImageProvider(
                            currentsUser?.imageUrl ??
                                "https://picsum.photos/100"),
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "${currentsUser?.name} ${currentsUser?.lastName}",
                              style: Theme.of(context).textTheme.bodyText1),
                          const SizedBox(height: 10),
                          RatingBar.builder(
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 6,
                            itemSize: 15.0,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 3.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.circle,
                              color: mainCTAColor,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                          const SizedBox(height: 5),
                          Text(gamify?.level.toString() ?? '0',
                              style: Theme.of(context).textTheme.caption),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    child: Center(
                      child: Text(gamify?.points.toString() ?? '0',
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white)),
                    ),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xffa076e8),
                          Color(0xffb1c4f8),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.navigate_next),
                    color: mainCTAColor,
                    iconSize: 30,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => GamifyDetailsPage(
                              userModel: currentsUser, gamifyModel: gamify),
                        ),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ));

    final specialAdCarrousel = SizedBox(
      height: 150,
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: Carousel(typeAd: 'GAMIFY'),
          ),
        ],
      ),
    );

    final giftCarrousel = SizedBox(
      height: 150,
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: Carousel(typeAd: 'MENU'),
          ),
        ],
      ),
    );

    final offersGrid = GridView.count(
      mainAxisSpacing: 10,
      crossAxisSpacing: 5,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      crossAxisCount: 2,
      children: offers.map((offer) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const OfferPage(),
              ),
            );
          },
          child: Container(
            child: Card(
              elevation: 10,
              shadowColor: shadowColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.10,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                            'https://picsum.photos/500/500',
                          ),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            offer.title,
                            style: Theme.of(context).textTheme.caption,
                          ),
                          const SizedBox(height: 7),
                          Text(
                            offer.description,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Text(
                            "S/. 9.00",
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          const SizedBox(height: 7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );

    return isLoading
        ? const Center(
            child: CircularProgressIndicator(backgroundColor: Colors.white),
          )
        : Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xfff93c64), Color(0xfff78b63)],
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            'https://picsum.photos/200'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40.0),
                          bottomRight: Radius.circular(40.0)),
                    ),
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: userSection,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        specialAdCarrousel,
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 10),
                          child: Text('Regalos',
                              style: Theme.of(context).textTheme.headline3),
                        ),
                        giftCarrousel,
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 10),
                          child: Text('Ofertas',
                              style: Theme.of(context).textTheme.headline3),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: offersGrid,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 10),
                          child: Text('Mi QR',
                              style: Theme.of(context).textTheme.headline3),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: Text(
                              'Muestra este código para sumar puntos por tus compras.',
                              style: Theme.of(context).textTheme.button),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
