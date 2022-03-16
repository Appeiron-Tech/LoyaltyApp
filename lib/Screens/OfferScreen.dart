import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:testing/Screens/SurveyScreen.dart';
import 'package:testing/Utils/globalVariables.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:testing/Widgets/appBar.dart';

class OfferPage extends StatefulWidget {
  const OfferPage({Key? key}) : super(key: key);

  @override
  State<OfferPage> createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage>
    with SingleTickerProviderStateMixin {
  late TabController _qrController;

  @override
  void initState() {
    _qrController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget qrModal = Container(
      decoration: const BoxDecoration(
        color: linesColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 230,
            child: TabBarView(
              controller: _qrController,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Escanear código',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: QrImage(
                        data: "1234567890",
                        version: QrVersions.auto,
                        size: 150,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'MQ34K2',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text('Ingresar código',
                        style: Theme.of(context).textTheme.bodyText2),
                  ],
                ),
              ],
            ),
          ),
          TabBar(
            controller: _qrController,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(
                25.0,
              ),
              color: mainCTAColor,
            ),
            unselectedLabelColor: colorText1,
            tabs: const [
              Tab(
                text: 'QR',
              ),
              Tab(
                text: 'Código',
              ),
            ],
          ),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: linesColor,
      appBar: const AppBarWidget(
        appBarText: 'Ofertas',
        appbackgroundColor: linesColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.4,
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
                  child: Text('Mocaccino + Hamburguesa',
                      style: Theme.of(context).textTheme.bodyText1),
                ),
                Text('S/. 14.25',
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
                Text('40 min. de activación',
                    style: Theme.of(context).textTheme.bodyText2),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
                'Descripción: To use this class, make sure you set uses-material-design: true in your project',
                style: Theme.of(context).textTheme.bodyText1),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text('Requisitos',
                style: Theme.of(context).textTheme.labelMedium),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 100,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigator.of(context).pop();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SurveyPage(),
                            ),
                          );
                        },
                        child: const Text('Back'),
                      ),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: ElevatedButton(
                        onPressed: () {
                          // modal
                          showMaterialModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) => qrModal,
                          );
                        },
                        child: const Text('Activar'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
