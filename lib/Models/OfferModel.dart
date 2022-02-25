import 'package:cloud_firestore/cloud_firestore.dart';

class OfferModel {
  String uid = '';
  String clientId = '';
  String idCategory = '';
  String title = '';
  String description = '';
  String image = '';
  late DateTime createdAt;
  num expirationDays = 0;
  String productId = '';
  List requirements = [];

  OfferModel({
    required this.uid,
    required this.clientId,
    required this.idCategory,
    required this.title,
    required this.image,
    required this.description,
    required this.createdAt,
    required this.expirationDays,
    required this.productId,
    required this.requirements,
  });

  OfferModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    clientId = json['clientId'];
    idCategory = json['idCategory'];
    title = json['title'];
    image = json['image'];
    description = json['description'];
    createdAt = json['createdAt'].toDate();
    expirationDays = json['expirationDays'];
    productId = json['productId'];
    requirements = json['requirements'];
  }

  static OfferModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return OfferModel(
      uid: snapshot['uid'],
      clientId: snapshot['clientId'],
      idCategory: snapshot['idCategory'],
      title: snapshot['title'],
      description: snapshot['description'],
      image: snapshot['image'],
      createdAt: snapshot['createdAt'].toDate(),
      expirationDays: snapshot['expirationDays'],
      requirements: snapshot['requirements'],
      productId: snapshot['productId'],
    );
  }
}
