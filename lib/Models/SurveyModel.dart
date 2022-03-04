import 'package:cloud_firestore/cloud_firestore.dart';

class SurveyModel {
  String uid = '';
  DateTime createdAt;
  String clientId;
  bool active = false;

  SurveyModel({
    required this.uid,
    required this.createdAt,
    required this.clientId,
    required this.active,
  });

  static SurveyModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return SurveyModel(
      uid: snapshot["uid"],
      clientId: snapshot["clientId"],
      createdAt: snapshot["createdAt"].toDate(),
      active: snapshot["active"],
    );
  }
}
