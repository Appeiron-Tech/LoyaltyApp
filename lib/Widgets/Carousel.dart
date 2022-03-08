import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testing/Models/AnnouncementModel.dart';
import 'package:testing/Models/ClientModel.dart';
import 'package:testing/Resources/firestore_methods.dart';
import 'package:testing/Utils/globalVariables.dart';

class Carousel extends StatefulWidget {
  final String typeAd;

  const Carousel({Key? key, required this.typeAd}) : super(key: key);

  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<Carousel> {
  int _current = 0;
  String clientId = "6R6uxrX1jQaAuvZQ4WEl";
  String activeCampaignId = '';
  List<AnnouncementModel> listAnnouncements = [];

  @override
  void initState() {
    super.initState();
    getImages();
  }

  getImages() async {
    // get client active campaigns
    ClientModel currentClient = await FirestoreMethods.getClient(clientId);
    activeCampaignId = currentClient.activesCampaignId[0];

    // get active announcements urls
    listAnnouncements = await FirestoreMethods.getAnnouncements(
        activeCampaignId, widget.typeAd);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final CarouselController _controller = CarouselController();

    final List<Widget> imageSliders = listAnnouncements
        .map(
          (item) => Container(
            margin: const EdgeInsets.all(2.0),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                child: Stack(
                  children: <Widget>[
                    CachedNetworkImage(
                        imageUrl: item.image, fit: BoxFit.cover, width: 1000.0),
                  ],
                )),
          ),
        )
        .toList();

    return Scaffold(
      backgroundColor: linesColor,
      body: Column(
        children: [
          Expanded(
            child: CarouselSlider(
              items: imageSliders,
              carouselController: _controller,
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(
                    () {
                      _current = index;
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
