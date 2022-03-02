import 'package:flutter/material.dart';
import 'package:testing/Models/StoreModel.dart';
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
      appBar: AppBar(
        title: Text('Tienda ${widget.storeModel.district}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  ListTile(
                    title: Text(widget.storeModel.district),
                    subtitle: Text(
                      'Secondary Text',
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 150,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Carousel(typeAd: 'GAMIFY'),
                  ),
                ],
              ),
            ),
            Container(
              height: 400,
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
          ],
        ),
      ),
    );
  }
}
