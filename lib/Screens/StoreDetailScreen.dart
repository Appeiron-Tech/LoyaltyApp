import 'package:flutter/material.dart';
import 'package:testing/Models/StoreModel.dart';
import 'package:testing/Utils/globalVariables.dart';
import 'package:testing/Widgets/Carousel.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'dart:async';

class StoreDetailPage extends StatefulWidget {
  const StoreDetailPage({Key? key, required this.storeModel}) : super(key: key);

  final StoreModel storeModel;

  @override
  _StoreDetailPageState createState() => _StoreDetailPageState();
}

class _StoreDetailPageState extends State<StoreDetailPage> {
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  CameraPosition _initialPosition =
      CameraPosition(target: LatLng(40.7128, -74.0060));

  Completer<GoogleMapController> _controller = Completer();

  final Set<Marker> _markers = Set();
  final double _zoom = 6;

  @override
  void initState() {
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void dispose() {
    _customInfoWindowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double lat = widget.storeModel.geopoint.latitude;
    double long = widget.storeModel.geopoint.longitude;

    _markers.add(
      Marker(
        markerId: MarkerId("marker_id"),
        position: LatLng(lat, long),
        onTap: () {
          _customInfoWindowController.addInfoWindow!(
            Column(
              children: [
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4)),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(widget.storeModel.district),
                              Text(widget.storeModel.province),
                              Expanded(
                                child: Image.network(
                                    widget.storeModel.images[0],
                                    fit: BoxFit.fitWidth),
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.start,
                          )),
                      width: double.infinity,
                      height: double.infinity),
                )
              ],
            ),
            LatLng(lat, long),
          );
        },
      ),
    );

    return Scaffold(
      backgroundColor: linesColor,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: colorText2,
        backgroundColor: linesColor,
        centerTitle: true,
        title: Text('Tienda ${widget.storeModel.district}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 35, right: 35, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(0),
              width: double.infinity,
              child: Card(
                color: cardColor,
                elevation: 10,
                shadowColor: shadowColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                clipBehavior: Clip.antiAlias,
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 25, left: 25, top: 20, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.storeModel.district,
                          style: Theme.of(context).textTheme.bodyText1),
                      Text('Horario: 9am - 5pm',
                          style: Theme.of(context).textTheme.caption),
                      Text('Contacto: +51 123 456 789',
                          style: Theme.of(context).textTheme.bodyText2),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text('Ubicación',
                    style: Theme.of(context).textTheme.headline1)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(4),
              height: 300,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                child: Stack(
                  children: [
                    GoogleMap(
                      onTap: (position) {
                        _customInfoWindowController.hideInfoWindow!();
                      },
                      onCameraMove: (position) {
                        _customInfoWindowController.onCameraMove!();
                      },
                      onMapCreated: (GoogleMapController controller) async {
                        _customInfoWindowController.googleMapController =
                            controller;
                      },
                      markers: _markers,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(lat, long),
                        zoom: _zoom,
                      ),
                    ),
                    CustomInfoWindow(
                      controller: _customInfoWindowController,
                      height: 200,
                      width: 150,
                      offset: 50,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Hacer una reserva'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
