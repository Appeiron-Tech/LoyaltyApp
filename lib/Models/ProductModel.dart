import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String uid = '';
  String categoryId = '';
  String clientId = '';
  String name = '';
  num offerPctg = 0.0;
  num price = 0.0;
  String image = '';
  String description = '';
  num order = 0;
  num minPreparado = 0;

  ProductModel({
    required this.uid,
    required this.name,
    required this.image,
    required this.description,
    required this.categoryId,
    required this.clientId,
    required this.offerPctg,
    required this.price,
    required this.order,
    required this.minPreparado,
  });

  static ProductModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return ProductModel(
      uid: snapshot['uid'],
      categoryId: snapshot['categoryId'],
      clientId: snapshot['clientId'],
      name: snapshot['name'],
      offerPctg: snapshot['offerPctg'],
      price: snapshot['price'],
      image: snapshot['image'],
      description: snapshot['description'],
      order: snapshot['order'],
      minPreparado: snapshot['minPreparado'],
    );
  }
}
