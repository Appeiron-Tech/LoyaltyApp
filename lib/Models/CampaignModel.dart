import 'package:cloud_firestore/cloud_firestore.dart';

class CampaignModel {
  String uid = '';
  String clientId = '';
  String title = '';
  String description = '';
  late DateTime createdAt;
  bool active = false;

  CampaignModel({
    required this.uid,
    required this.clientId,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.active,
  });

  static CampaignModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return CampaignModel(
      uid: snapshot["uid"],
      clientId: snapshot["clientId"],
      title: snapshot["title"],
      description: snapshot["description"],
      createdAt: snapshot["createdAt"].toDate(),
      active: snapshot["active"],
    );
  }
}
