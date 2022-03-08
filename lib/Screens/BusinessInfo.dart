import 'package:flutter/material.dart';
import 'package:testing/Resources/firestore_methods.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:testing/Screens/StoreDetailScreen.dart';
import 'package:testing/Utils/globalVariables.dart';
import 'package:testing/Utils/utils.dart';

class BusinessInfo extends StatefulWidget {
  static const routeName = '/business-info';

  @override
  State<BusinessInfo> createState() => _BusinessInfoState();
}

class _BusinessInfoState extends State<BusinessInfo> {
  List stores = [];
  bool isLoading = false;

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
      stores = await FirestoreMethods().getStores();
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
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final title = routeArgs['title'];

    Widget storeList = ListView.builder(
        itemCount: stores.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        StoreDetailPage(storeModel: stores[index]),
                  ),
                );
              },
              child: Card(
                color: cardColor,
                elevation: 10,
                shadowColor: shadowColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 100.0,
                        height: 80.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                              stores[index].images[0],
                            ),
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15.0)),
                        ),
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(stores[index].district,
                              style: Theme.of(context).textTheme.bodyText1),
                          const Text('Metadata'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });

    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            backgroundColor: linesColor,
            appBar: AppBar(
              elevation: 0,
              foregroundColor: colorText2,
              backgroundColor: linesColor,
              centerTitle: true,
              title: const Text('Lista de locales'),
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 35, right: 35, top: 10),
              child: storeList,
            ),
          );
  }
}
