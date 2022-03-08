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
            height: 120,
            margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: shadowColor,
                  blurRadius: 7.0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image(
                  image: CachedNetworkImageProvider(
                    _categoriesProduct[index].image,
                  ),
                  height: 50,
                  width: 50,
                ),
                Text(
                  _categoriesProduct[index].title,
                  style: Theme.of(context).textTheme.headline2,
                ),
              ],
            ),
          ),
        );
      },
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: linesColor,
        appBar: AppBar(
          elevation: 0,
          foregroundColor: colorText2,
          backgroundColor: linesColor,
          centerTitle: true,
          title: const Text('Menú'),
        ),
        body: FutureBuilder(
          future: getProducts(),
          builder: (context, data) {
            if (data.hasError) {
              return Center(child: Text("${data.error}"));
            } else if (data.hasData) {
              return Column(
                children: <Widget>[
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 25),
                          child: Text("Elegir por categoria",
                              style: Theme.of(context).textTheme.headline2),
                        ),
                        const SizedBox(height: 11),
                        Container(
                            padding: EdgeInsets.only(left: 10),
                            height: 150,
                            child: categoriesList),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 25),
                          child: Row(
                            children: [
                              Text('Todo ',
                                  style:
                                      Theme.of(context).textTheme.labelMedium),
                              Text(categoryTitle,
                                  style: Theme.of(context).textTheme.headline2),
                            ],
                          ),
                        ),
                        const SizedBox(height: 9),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 25),
                      child: GridView.builder(
                        itemCount: _currentProducts.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, crossAxisSpacing: 10),
                        itemBuilder: (ctx, index) {
                          return Card(
                            elevation: 10,
                            shadowColor: shadowColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: CachedNetworkImageProvider(
                                        _currentProducts[index].image,
                                      ),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20.0)),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                    'S/.${_currentProducts[index].price.toString()}',
                                    style: Theme.of(context).textTheme.caption),
                                SizedBox(height: 10),
                                Text(
                                  _currentProducts[index].name,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                Text(
                                  _currentProducts[index].description,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ],
                            ),
                          );
                        },
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
