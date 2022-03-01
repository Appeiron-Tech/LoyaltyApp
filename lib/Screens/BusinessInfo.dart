import 'package:flutter/material.dart';
import 'package:testing/Resources/firestore_methods.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
          return ListTile(
            title: Text(stores[index].district),
            leading: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                stores[index].images[0],
              ),
            ),
            trailing: const Text('Metadata'),
          );
        });

    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text('Business Info'),
            ),
            body: storeList,
          );
  }
}
