import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:testing/Resources/firestore_methods.dart';

class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  String coverURL = '';
  @override
  void initState() {
    super.initState();
    getImg();
  }

  getImg() async {
    coverURL = await FirestoreMethods.getCoverUrl();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(coverURL),
          fit: BoxFit.cover,
        ),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Container(
                  height: 75,
                  width: 75,
                  padding: const EdgeInsets.all(9.0),
                  child: const Image(
                      image: AssetImage('assets/images/ProductsImg.jpg')),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5.0,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const <Widget>[
                      Text(
                        "Products List",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      // MyProgressBar(isActive: true),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
