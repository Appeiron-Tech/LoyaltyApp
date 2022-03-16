import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:testing/Utils/globalVariables.dart';
import 'package:testing/Widgets/appBar.dart';

class GamifyDetailsPage extends StatefulWidget {
  const GamifyDetailsPage(
      {Key? key, required this.userModel, required this.gamifyModel})
      : super(key: key);

  final userModel;
  final gamifyModel;

  @override
  State<GamifyDetailsPage> createState() => _GamifyDetailsPageState();
}

class _GamifyDetailsPageState extends State<GamifyDetailsPage> {
  List compras = [
    "Compra 1",
    "Compra 2",
    "Compra 3",
    "Compra 4",
    "Compra 5",
    "Compra 6"
        "Compra 1",
    "Compra 2",
    "Compra 3",
    "Compra 4",
    "Compra 5",
    "Compra 6"
        "Compra 1",
    "Compra 2",
    "Compra 3",
    "Compra 4",
    "Compra 5",
    "Compra 6"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: linesColor,
      appBar: const AppBarWidget(
        appBarText: 'Detalles de puntaje',
        appbackgroundColor: linesColor,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: cardColor,
              elevation: 10,
              shadowColor: shadowColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Alma cafe',
                            style: Theme.of(context).textTheme.headline1),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Provider.of<ValueNotifier<int>>(context,
                                        listen: false)
                                    .value = 3;
                              },
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage: CachedNetworkImageProvider(
                                    widget.userModel?.imageUrl ??
                                        "https://picsum.photos/100"),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "${widget.userModel?.name} ${widget.userModel?.lastName}",
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                                const SizedBox(height: 10),
                                RatingBar.builder(
                                  initialRating: 3,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 6,
                                  itemSize: 15.0,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 3.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.circle,
                                    color: mainCTAColor,
                                  ),
                                  onRatingUpdate: (rating) {
                                    // print(rating);
                                  },
                                ),
                                const SizedBox(height: 5),
                                Text(
                                    widget.gamifyModel?.level.toString() ?? '0',
                                    style: Theme.of(context).textTheme.caption),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      child: Center(
                        child: Text(
                            widget.gamifyModel?.points.toString() ?? '0',
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white)),
                      ),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Color(0xffa076e8),
                            Color(0xffb1c4f8),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text('Detalle de consumo',
                  style: Theme.of(context).textTheme.headline2),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 300,
              child: ListView.builder(
                // physics: NeverScrollableScrollPhysics(),
                // shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: compras.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xffdddfe1),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Un mocaccino + una hamburguesa',
                                style: Theme.of(context).textTheme.bodyText1),
                            const SizedBox(height: 5),
                            Text('02/03/2022',
                                style: Theme.of(context).textTheme.bodyText2),
                          ],
                        ),
                        Text('0.5pt',
                            style: Theme.of(context).textTheme.caption),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
