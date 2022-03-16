import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:testing/Models/AnnouncementModel.dart';
import 'package:testing/Models/ClientModel.dart';
import 'package:testing/Resources/firestore_methods.dart';
import 'dart:async';

import 'package:testing/Screens/MainMenu.dart';

final List<String> imgList = [
  'https://picsum.photos/500/500',
  'https://picsum.photos/500/500',
  'https://picsum.photos/500/500',
  'https://picsum.photos/500/500',
];

const durationImg = 5;

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int _current = 0;
  String clientId = "6R6uxrX1jQaAuvZQ4WEl";
  String activeCampaignId = '';
  List<AnnouncementModel> listAnnouncements = [];
  String typeAd = 'WELCOME';

  @override
  void initState() {
    super.initState();
    getImages();
    startTime();
  }

  getImages() async {
    // get client active campaigns
    ClientModel currentClient = await FirestoreMethods.getClient(clientId);
    activeCampaignId = currentClient.activesCampaignId[0];

    // get active announcements urls
    listAnnouncements =
        await FirestoreMethods.getAnnouncements(activeCampaignId, typeAd);

    setState(() {});
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
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xfff93c64), Color(0xfff78b63)])),
      child: Center(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Builder(builder: (context) {
            final double height = MediaQuery.of(context).size.height;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                    child: Container(
                      height: 600,
                      width: 450,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.height,
                          viewportFraction: 1,
                          autoPlay: true,
                          autoPlayInterval:
                              const Duration(seconds: durationImg),
                        ),
                        items: listAnnouncements
                            .map(
                              (item) => Center(
                                child: CachedNetworkImage(
                                  imageUrl: item.image,
                                  fit: BoxFit.cover,
                                  height: height,
                                  width: double.infinity,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      route();
                    },
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        color: Color(0xfff2f4f7),
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
