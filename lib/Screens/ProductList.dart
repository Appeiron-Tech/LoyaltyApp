import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testing/Models/CategoryModel.dart';
import 'package:testing/Models/ProductModel.dart';
import 'package:testing/Resources/firestore_methods.dart';
import 'package:testing/Screens/ProductScreen.dart';
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
  List<DropdownMenuItem<String>> categoryItems = [
    DropdownMenuItem(child: Text("Todas"), value: "None"),
  ];

  var dropdownCategoryValue;

  String selectedCategoryValue = "None";

  var dropdownPriceValue;
  String selectedPriceValue = "0";
  List<DropdownMenuItem<String>> get dropdownPrices {
    List<DropdownMenuItem<String>> priceItems = const [
      DropdownMenuItem(child: Text("Todos"), value: "0"),
      DropdownMenuItem(child: Text("Min  - S/.20"), value: "1"),
      DropdownMenuItem(child: Text("S/.20 - S/.50"), value: "2"),
      DropdownMenuItem(child: Text("S/.50 - S/.75"), value: "3"),
      DropdownMenuItem(child: Text("S/.75 - S/.100"), value: "4"),
      DropdownMenuItem(child: Text("S/.100 - Max"), value: "5"),
    ];
    return priceItems;
  }

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  getCategories() async {
    _categoriesProduct = await FirestoreMethods.getCategories(clientId);

    for (var category in _categoriesProduct) {
      categoryItems.add(
        DropdownMenuItem(child: Text(category.title), value: category.uid),
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Future<List<ProductModel>> getProducts() async {
      return _allProducts = await FirestoreMethods.getProducts();
    }

    Future<void> filterProducts(String categoryId) async {
      setState(
        () {
          if (categoryId == 'None') {
            _currentProducts = _allProducts;
          } else {
            _currentProducts = _allProducts
                .where((product) => product.categoryId == categoryId)
                .toList()
              ..sort((a, b) => a.order.compareTo(b.order));
          }
        },
      );
    }

    Future<void> searchProducts(String query) async {
      setState(() {
        _currentProducts = _allProducts
            .where((product) => product.name.toLowerCase().contains(query))
            .toList()
          ..sort((a, b) => a.order.compareTo(b.order));
      });
    }

    final Widget masPedidosList = ListView.builder(
      itemCount: _allProducts.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            width: MediaQuery.of(context).size.width * 0.35,
            child: Card(
              clipBehavior: Clip.antiAlias,
              // height: MediaQuery.of(context).size.height * 0.09,
              margin: const EdgeInsets.only(right: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: Image.network(
                      _allProducts[index].image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.all(7.0),
                    child: Center(
                      child: Text(
                        _allProducts[index].name,
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    return Scaffold(
      backgroundColor: linesColor,
      appBar: const AppBarWidget(
        appBarText: 'Menú',
        appbackgroundColor: mainCTAColor,
      ),
      body: FutureBuilder(
        future: getProducts(),
        builder: (context, data) {
          if (data.hasError) {
            return Center(child: Text("${data.error}"));
          } else if (data.hasData) {
            return ListView(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 20),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [mainCTAColor, Color(0xfff78b63)],
                    ),
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: TextFormField(
                            onChanged: (String query) {
                              print(query);
                              searchProducts(query);
                            },
                            decoration: const InputDecoration(
                              labelText: 'Search',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xfff9fafb), width: 1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xfff9fafb), width: 1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xfff9fafb), width: 1),
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
                      Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: DropdownButtonFormField(
                                alignment: Alignment.center,
                                iconSize: 20,
                                style: const TextStyle(
                                    fontSize: 15, color: colorText1),
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.only(right: 3),
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
                                  prefixIconConstraints: const BoxConstraints(
                                      maxWidth: 30, minWidth: 30),
                                  filled: true,
                                  fillColor: const Color(0xfff9fafb),
                                ),
                                icon: const Icon(Icons.arrow_drop_down,
                                    color: colorText1, size: 20),
                                dropdownColor: const Color(0xfff9fafb),
                                value: selectedPriceValue,
                                onChanged: (String? newValue) {
                                  setState(
                                    () {
                                      selectedPriceValue = newValue!;
                                    },
                                  );
                                },
                                items: dropdownPrices,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                height: 40,
                                // width: MediaQuery.of(context).size.width * 0.45,
                                child: DropdownButtonFormField(
                                  alignment: Alignment.center,
                                  iconSize: 20,
                                  style: const TextStyle(
                                      fontSize: 15, color: colorText1),
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(right: 3),
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
                                      child: Icon(Icons.av_timer,
                                          color: colorText1, size: 20),
                                    ),
                                    prefixIconConstraints: const BoxConstraints(
                                        maxWidth: 30, minWidth: 30),
                                    filled: true,
                                    fillColor: const Color(0xfff9fafb),
                                  ),
                                  icon: const Icon(Icons.arrow_drop_down,
                                      color: colorText1, size: 20),
                                  dropdownColor: const Color(0xfff9fafb),
                                  value: selectedCategoryValue,
                                  onChanged: (String? newValue) {
                                    setState(
                                      () {
                                        selectedCategoryValue = newValue!;

                                        filterProducts(selectedCategoryValue);
                                      },
                                    );
                                  },
                                  items: categoryItems,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
                  child: Text('Más populares',
                      style: Theme.of(context).textTheme.headline2),
                ),
                const SizedBox(height: 15),
                Container(
                    margin: const EdgeInsets.only(left: 20),
                    height: MediaQuery.of(context).size.height * 0.22,
                    child: masPedidosList),
                const SizedBox(height: 15),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
                  child: Text('Resultados',
                      style: Theme.of(context).textTheme.headline2),
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
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    itemBuilder: (ctx, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProductPage(
                                  productModel: _currentProducts[index]),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 10,
                          shadowColor: shadowColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
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
                                        Radius.circular(15.0)),
                                  ),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
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
