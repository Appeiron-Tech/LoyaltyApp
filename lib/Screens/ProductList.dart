import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testing/Models/CategoryModel.dart';
import 'package:testing/Models/ProductModel.dart';
import 'package:testing/Widgets/ProductList/Header.dart';
// https://github.com/cybdom/cloud_storage_status/blob/master/lib/details.dart

class ProductList extends StatelessWidget {
  static const routeName = '/product-list';

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final title = routeArgs['title'];
    List <ProductModel> _products = [];
    List <CategoryModel> _categories = [];

    Future<List<ProductModel>> ReadJson() async {
      final productsJsonData = await rootBundle.loadString('assets/DB/products.json');
      final productsData = await json.decode(productsJsonData) as List<dynamic>;
      _products = productsData.map((json) => ProductModel.fromJson(json)).toList();

      final categoriesJsonData = await rootBundle.loadString('assets/DB/categories.json');
      final categoriesData = await json.decode(categoriesJsonData) as List<dynamic>;
      _categories = categoriesData.map((json) => CategoryModel.fromJson(json)).toList();

      return productsData.map((e) => ProductModel.fromJson(e)).toList();
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amberAccent,
        appBar: AppBar(title: const Text('Loyalty App'),),
        body: FutureBuilder(
          future: ReadJson(),
          builder: (context, data){
            if(data.hasError){
              return Center(child: Text("${data.error}"),);
            }else if(data.hasData){
              // var categories = data.data as List<CategoryModel>;
              return Column(
                children: <Widget>[
                  const Header(),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                        ),
                        boxShadow: [
                          BoxShadow(blurRadius: 13.0, color: Colors.amberAccent),
                        ],
                      ),
                      padding: EdgeInsets.only(left: 15, right: 15, top: 15),
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
                                const SizedBox(
                                  height: 11,
                                ),
                                Container(
                                  height: 151,
                                  child: ListView.builder(
                                    itemCount: _categories.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        width: 251,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 15.0, vertical: 5.0),
                                        padding: EdgeInsets.all(15.0),
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
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Image(image: AssetImage(_categories[index].image),
                                                  height: 65,
                                                  width: 65,
                                                ),
                                                Spacer(),
                                                const CircleAvatar(
                                                  backgroundImage: AssetImage("assets/images/book1.jpg"),
                                                ),
                                                const CircleAvatar(
                                                    backgroundImage: AssetImage("assets/images/book2.jpg")
                                                ),
                                                const CircleAvatar(
                                                    backgroundImage: AssetImage("assets/images/book3.jpg")
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            Text(
                                              "Category $index ",
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 21,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 15),
                                const Text(
                                  "Category X books",
                                  style: TextStyle(
                                      fontSize: 21,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 9,),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: _products.length,
                              itemBuilder: (ctx, index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 15),
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Color(0xffecf0f3),
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      // const Icon(
                                      //   Icons.auto_stories,
                                      //   color: Colors.white,
                                      // ),
                                      CircleAvatar(
                                        backgroundImage: AssetImage(_products[index].image),
                                      ),
                                      SizedBox(width: 21,),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: _products[index].name,
                                                    style: const TextStyle(
                                                        color: Color(0xff333333),
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 21),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              _products[index].description,
                                              style: TextStyle(color: Colors.grey),
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
            }else{
              return Center(child: CircularProgressIndicator());
            }
          },
        )
      ),
    );
  }
}
