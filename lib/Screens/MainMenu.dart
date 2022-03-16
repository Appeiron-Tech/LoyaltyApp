import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing/Screens/LoginScreen.dart';
import 'package:testing/Screens/ProductList.dart';
import 'package:testing/Utils/globalVariables.dart';
import 'package:testing/Widgets/Carousel.dart';
import 'BusinessInfo.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: linesColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20, right: 10),
            width: double.infinity,
            child: const Align(
              alignment: Alignment.centerRight,
              child: Image(
                image: AssetImage('assets/images/LOGO X-03.png'),
                height: 85,
                width: 85,
              ),
            ),
          ),
          Text('Alma cafe', style: Theme.of(context).textTheme.headline1),
          const SizedBox(height: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.25,
            child: Expanded(
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: const Carousel(typeAd: 'MENU'),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductList(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Card(
                      elevation: 10,
                      shadowColor: shadowColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 140.0,
                            height: MediaQuery.of(context).size.height * 0.13,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(
                                  'https://picsum.photos/500/500',
                                ),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'Menú',
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BusinessInfo(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Card(
                      elevation: 10,
                      shadowColor: shadowColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 140.0,
                            height: MediaQuery.of(context).size.height * 0.13,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(
                                  'https://picsum.photos/500/500',
                                ),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'Ubícanos',
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 300,
            child: ElevatedButton(
              onPressed: () async {
                FirebaseAuth _auth1 = await FirebaseAuth.instance;
                if (_auth1.currentUser == null) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                } else {
                  Provider.of<ValueNotifier<int>>(context, listen: false)
                      .value = 2;
                }
              },
              child: Text('ACCESS GAME'),
            ),
          ),
        ],
      ),
    );
  }
}
