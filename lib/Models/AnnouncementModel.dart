import 'package:cloud_firestore/cloud_firestore.dart';

class AnnouncementModel {
  String uid = '';
  String campaignId = '';
  int order = 0;
  String type = '';
  String description = '';
  String image = '';
  DateTime createdAt;
  String title = '';
  bool active = false;

  AnnouncementModel({
    required this.uid,
    required this.campaignId,
    required this.order,
    required this.type,
    required this.description,
    required this.image,
    required this.createdAt,
    required this.active,
    required this.title,
  });

  static AnnouncementModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return AnnouncementModel(
      uid: snapshot['uid'],
      campaignId: snapshot["campaignId"],
      order: snapshot["order"],
      type: snapshot["type"],
      description: snapshot["description"],
      image: snapshot["image"],
      createdAt: snapshot["createdAt"].toDate(),
      active: snapshot["active"],
      title: snapshot["title"],
    );
  }
}
