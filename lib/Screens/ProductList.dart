import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testing/Models/CategoryModel.dart';
import 'package:testing/Models/ProductModel.dart';
import 'package:testing/Resources/firestore_methods.dart';
import 'package:testing/Widgets/ProductList/Header.dart';

import '../Utils/globalVariables.dart';
// https://github.com/cybdom/cloud_storage_status/blob/master/lib/details.dart

class ProductList extends StatefulWidget {
  static const routeName = '/product-list';

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<CategoryModel> _categoriesProduct = [];
  List<ProductModel> _currentProducts = [];
  List<ProductModel> _allProducts = [];
  String currentCategoryId = '';
  String categoryTitle = 'Categoria 0';

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  getCategories() async {
    _categoriesProduct = await FirestoreMethods.getCategories(clientId);
    currentCategoryId = _categoriesProduct[0].uid;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final title = routeArgs['title'];

    Future<List<ProductModel>> getProducts() async {
      return _allProducts = await FirestoreMethods.getProducts();
    }

    Future<void> filterProducts(String categoryId, String categoryName) async {
      setState(
        () {
          categoryTitle = categoryName;
          _currentProducts = _allProducts
              .where((product) => product.categoryId == categoryId)
              .toList()
            ..sort((a, b) => a.order.compareTo(b.order));
        },
      );
    }

    final Widget categoriesList = ListView.builder(
      itemCount: _categoriesProduct.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            print("Presionado");
            print(_categoriesProduct[index].title);
            filterProducts(
                _categoriesProduct[index].uid, _categoriesProduct[index].title);
          },
          child: Container(
            width: 251,
            margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.blueGrey,
                  blurRadius: 7.0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Image(
                      image: CachedNetworkImageProvider(
                        _categoriesProduct[index].image,
                      ),
                      height: 65,
                      width: 65,
                    ),
                    const Spacer(),
                    const CircleAvatar(
                      backgroundImage: AssetImage("assets/images/book1.jpg"),
                    ),
                    const CircleAvatar(
                        backgroundImage: AssetImage("assets/images/book2.jpg")),
                    const CircleAvatar(
                        backgroundImage: AssetImage("assets/images/book3.jpg")),
                  ],
                ),
                const Spacer(),
                Text(
                  _categoriesProduct[index].title,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amberAccent,
        appBar: AppBar(
          title: const Text('Loyalty App'),
        ),
        body: FutureBuilder(
          future: getProducts(),
          builder: (context, data) {
            if (data.hasError) {
              return Center(child: Text("${data.error}"));
            } else if (data.hasData) {
              return Stack(
                overflow: Overflow.clip,
                alignment: AlignmentDirectional.topCenter,
                fit: StackFit.loose,
                children: <Widget>[
                  const Header(),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 140),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 15),
                      child: Column(
                        children: <Widget>[
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text(
                                  "Categories",
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 11),
                                Container(height: 151, child: categoriesList),
                                const SizedBox(height: 15),
                                Text(
                                  categoryTitle,
                                  style: TextStyle(
                                      fontSize: 21,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 9),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: _currentProducts.length,
                              itemBuilder: (ctx, index) {
                                return Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: const Color(0xffecf0f3),
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      // const Icon(
                                      //   Icons.auto_stories,
                                      //   color: Colors.white,
                                      // ),
                                      CircleAvatar(
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                                _currentProducts[index].image),
                                      ),

                                      const SizedBox(width: 21),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        _currentProducts[index]
                                                            .name,
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xff333333),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 21),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              _currentProducts[index]
                                                  .description,
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                              softWrap: false,
                                              overflow: TextOverflow.fade,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
