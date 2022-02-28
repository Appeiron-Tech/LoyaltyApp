import 'package:cloud_firestore/cloud_firestore.dart';

class StoreModel {
  String uid = '';
  String clientId = '';
  String locationId = '';
  GeoPoint geopoint;
  String city = '';
  String province = '';
  String district = '';
  String address = '';
  List images = [];
  List phones = [];

  StoreModel({
    required this.uid,
    required this.clientId,
    required this.locationId,
    required this.geopoint,
    required this.city,
    required this.province,
    required this.district,
    required this.address,
    required this.phones,
    required this.images,
  });

  static StoreModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return StoreModel(
      uid: snapshot["uid"],
      clientId: snapshot["clientId"],
      locationId: snapshot["locationId"],
      geopoint: snapshot["geopoint"],
      city: snapshot["city"],
      province: snapshot["province"],
      district: snapshot["district"],
      address: snapshot["address"],
      phones: snapshot["phones"],
      images: snapshot["images"],
    );
  }
}
