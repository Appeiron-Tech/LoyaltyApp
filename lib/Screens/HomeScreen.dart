import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing/Utils/globalVariables.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Center(
    //     child: ElevatedButton(
    //       child: Text('Alma cafe'),
    //       onPressed: () {
    //         Provider.of<ValueNotifier<int>>(context, listen: false).value = 1;
    //       },
    //     ),
    //   ),
    // );
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xfff93c64), Color(0xfff78b63)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              child: const Align(
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage('assets/images/logo_splash.png'),
                  height: 130,
                  width: 130,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Search',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xfff9fafb), width: 1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xfff9fafb), width: 1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xfff9fafb), width: 1),
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
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: MediaQuery.of(context).size.width * 0.85,
              child: Text(
                'Busquedas populares',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Wrap(
                spacing: 7,
                children: [
                  ChoiceChip(
                    label: Text('Pastas'),
                    selected: true,
                  ),
                  ChoiceChip(
                    label: Text('Tortas'),
                    selected: false,
                  ),
                  ChoiceChip(
                    label: Text('Helados'),
                    selected: false,
                  ),
                  ChoiceChip(
                    label: Text('Panes'),
                    selected: false,
                  ),
                  ChoiceChip(
                    label: Text('Kekes'),
                    selected: false,
                  ),
                  ChoiceChip(
                    label: Text('Pizzas'),
                    selected: false,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: MediaQuery.of(context).size.width * 0.85,
              child: Text(
                'Cafés y pastelerias',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: GestureDetector(
                onTap: () {
                  Provider.of<ValueNotifier<int>>(context, listen: false)
                      .value = 1;
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
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 80.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(
                                  'https://picsum.photos/500/500'),
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15.0)),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Alma Café',
                                  style: Theme.of(context).textTheme.bodyText1),
                              Text('8am - 6pm',
                                  style: Theme.of(context).textTheme.caption),
                              Text('Café de autor y pasteleria gourment',
                                  style: Theme.of(context).textTheme.bodyText2),
                            ],
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
      ),
    );
  }
}
