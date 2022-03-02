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

const durationImg = 3;

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
                items: listAnnouncements
                    .map(
                      (item) => Container(
                        child: Center(
                          child: CachedNetworkImage(
                            imageUrl: item.image,
                            fit: BoxFit.cover,
                            height: height,
                          ),
                        ),
                      ),
                    )
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
