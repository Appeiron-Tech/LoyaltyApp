import 'package:cloud_firestore/cloud_firestore.dart';

class GiftModel {
  String uid = '';
  String clientId = '';
  String idCategory = '';
  String title = '';
  String description = '';
  String image = '';
  late DateTime createdAt;
  int expirationDays = 0;
  String productId = '';
  List requirements = [];

  GiftModel({
    required this.uid,
    required this.clientId,
    required this.idCategory,
    required this.title,
    required this.description,
    required this.image,
    required this.createdAt,
    required this.expirationDays,
    required this.requirements,
    required this.productId,
  });

  GiftModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    clientId = json['clientId'];
    idCategory = json['idCategory'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    createdAt = json['createdAt'];
    expirationDays = json['expirationDays'];
    requirements = json['requirements'];
    productId = json['productId'];
  }

  static GiftModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return GiftModel(
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
