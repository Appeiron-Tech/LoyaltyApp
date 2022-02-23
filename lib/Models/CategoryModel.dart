import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String uid = '';
  String title = "";
  String image = "";
  String description = "";
  String clientId = "";

  CategoryModel(
      {required this.uid,
      required this.title,
      required this.image,
      required this.clientId,
      required this.description});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    title = json['title'];
    image = json['image'];
    description = json['description'];
    clientId = json['clientId'];
  }

  static CategoryModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return CategoryModel(
      uid: snapshot['uid'],
      title: snapshot['title'],
      image: snapshot['image'],
      description: snapshot['description'],
      clientId: snapshot['clientId'],
    );
  }
}
