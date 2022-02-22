import 'package:cloud_firestore/cloud_firestore.dart';

class ClientModel {
  String uid = '';
  String name = '';
  String description = '';
  List<String> activesCampaignId = [];
  String type = '';

  ClientModel({
    required this.uid,
    required this.name,
    required this.description,
    required this.activesCampaignId,
    required this.type,
  });

  static ClientModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return ClientModel(
      uid: snapshot["uid"],
      name: snapshot["name"],
      description: snapshot["description"],
      activesCampaignId: List<String>.from(snapshot["activesCampaignId"]),
      type: snapshot["type"],
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "description": description,
        "activesCampaignId": activesCampaignId,
        "type": type,
      };
}
