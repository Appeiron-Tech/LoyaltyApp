import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testing/Models/CategoryModel.dart';
import 'package:testing/Models/ProductModel.dart';
import 'package:testing/Resources/firestore_methods.dart';
import 'package:testing/Widgets/ProductList/Header.dart';
import 'package:testing/Widgets/appBar.dart';

import '../Utils/globalVariables.dart';

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

  var dropdownValue;
  String selectedValue = "None";
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Ubicación"), value: "None"),
      DropdownMenuItem(child: Text("USA"), value: "USA"),
      DropdownMenuItem(child: Text("Canada"), value: "Canada"),
      DropdownMenuItem(child: Text("Brazil"), value: "Brazil"),
      DropdownMenuItem(child: Text("England"), value: "England"),
    ];
    return menuItems;
  }

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
            // height: MediaQuery.of(context).size.height * 0.09,
            margin: const EdgeInsets.only(right: 15),
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
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CachedNetworkImage(
                          imageUrl: _categoriesProduct[index].image,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Text(
                        _categoriesProduct[index].title,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    final Widget masPedidosList = ListView.builder(
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
            // height: MediaQuery.of(context).size.height * 0.09,
            margin: const EdgeInsets.only(right: 15),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl: _categoriesProduct[index].image,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Text(
                    _categoriesProduct[index].title,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    return Scaffold(
      backgroundColor: linesColor,
      appBar: const AppBarWidget(
        appBarText: 'Menú',
        appbackgroundColor: linesColor,
      ),
      body: FutureBuilder(
        future: getProducts(),
        builder: (context, data) {
          if (data.hasError) {
            return Center(child: Text("${data.error}"));
          } else if (data.hasData) {
            return ListView(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Search',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xfff9fafb), width: 1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xfff9fafb), width: 1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xfff9fafb), width: 1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        suffixIcon: Icon(
                          Icons.search,
                          color: mainCTAColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: DropdownButtonFormField(
                        alignment: Alignment.center,
                        iconSize: 20,
                        style: const TextStyle(fontSize: 15, color: colorText1),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(right: 3),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xfff9fafb), width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xfff9fafb), width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xfff9fafb), width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          prefixIcon: const Padding(
                            padding: EdgeInsetsDirectional.all(0.0),
                            child: Icon(Icons.location_on_outlined,
                                color: colorText1, size: 20),
                          ),
                          prefixIconConstraints:
                              const BoxConstraints(maxWidth: 30, minWidth: 30),
                          filled: true,
                          fillColor: const Color(0xfff9fafb),
                        ),
                        icon: const Icon(Icons.arrow_drop_down,
                            color: colorText1, size: 20),
                        dropdownColor: const Color(0xfff9fafb),
                        value: selectedValue,
                        onChanged: (String? newValue) {
                          setState(
                            () {
                              selectedValue = newValue!;
                            },
                          );
                        },
                        items: dropdownItems,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: DropdownButtonFormField(
                        alignment: Alignment.center,
                        iconSize: 20,
                        style: const TextStyle(fontSize: 15, color: colorText1),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(right: 3),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xfff9fafb), width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xfff9fafb), width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xfff9fafb), width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          prefixIcon: const Padding(
                            padding: EdgeInsetsDirectional.all(0.0),
                            child: Icon(Icons.attach_money,
                                color: colorText1, size: 20),
                          ),
                          prefixIconConstraints:
                              const BoxConstraints(maxWidth: 30, minWidth: 30),
                          filled: true,
                          fillColor: const Color(0xfff9fafb),
                        ),
                        icon: const Icon(Icons.arrow_drop_down,
                            color: colorText1, size: 20),
                        dropdownColor: const Color(0xfff9fafb),
                        value: selectedValue,
                        onChanged: (String? newValue) {
                          setState(
                            () {
                              selectedValue = newValue!;
                            },
                          );
                        },
                        items: dropdownItems,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
                  child: Text("Elegir por categoria",
                      style: Theme.of(context).textTheme.headline2),
                ),
                const SizedBox(height: 11),
                Container(
                    margin: const EdgeInsets.only(left: 20),
                    height: MediaQuery.of(context).size.height * 0.20,
                    child: categoriesList),
                const SizedBox(height: 15),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
                  child: Row(
                    children: [
                      Text('Más pedidos ',
                          style: Theme.of(context).textTheme.labelMedium),
                      Text(categoryTitle,
                          style: Theme.of(context).textTheme.headline2),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                    margin: const EdgeInsets.only(left: 20),
                    height: MediaQuery.of(context).size.height * 0.20,
                    child: masPedidosList),
                const SizedBox(height: 15),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
                  child: Row(
                    children: [
                      Text('Todo ',
                          style: Theme.of(context).textTheme.labelMedium),
                      Text(categoryTitle,
                          style: Theme.of(context).textTheme.headline2),
                    ],
                  ),
                ),
                const SizedBox(height: 9),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.13,
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
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                  'S/.${_currentProducts[index].price.toString()}',
                                  style: Theme.of(context).textTheme.caption),
                            ),
                            Text(
                              _currentProducts[index].name,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                _currentProducts[index].description,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
