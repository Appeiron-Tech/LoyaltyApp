import 'package:cloud_firestore/cloud_firestore.dart';

class RequirementModel {
  String uid = '';
  String description = '';
  late DateTime createdAt;

  RequirementModel({
    required this.uid,
    required this.description,
    required this.createdAt,
  });

  static RequirementModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return RequirementModel(
        uid: snapshot['uid'],
        description: snapshot['description'],
        createdAt: snapshot['createdAt'].toDate());
  }
}
