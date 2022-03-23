import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:testing/Utils/globalVariables.dart';
import 'package:testing/Widgets/appBar.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key, required this.productModel}) : super(key: key);

  final productModel;
  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: linesColor,
      appBar: const AppBarWidget(
        appBarText: 'Productos',
        appbackgroundColor: linesColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
                image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                        'https://picsum.photos/300')),
                borderRadius: const BorderRadius.all(Radius.circular(32.0)),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                Expanded(
                  child: Text(widget.productModel.name,
                      style: Theme.of(context).textTheme.bodyText1),
                ),
                Text('S/. ${widget.productModel.price.toString()}',
                    style: Theme.of(context).textTheme.labelMedium),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                const Icon(
                  Icons.timelapse,
                  color: Color(0xff8893a0),
                  size: 15,
                ),
                const SizedBox(width: 5),
                Text(
                    '${widget.productModel.minPreparado.toString()} min. de preparación',
                    style: Theme.of(context).textTheme.bodyText2),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text('Descripción: ${widget.productModel.description}',
                style: Theme.of(context).textTheme.bodyText1),
          ),
        ],
      ),
    );
  }
}
