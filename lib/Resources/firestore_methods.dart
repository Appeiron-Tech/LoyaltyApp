import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testing/Models/AnnouncementModel.dart';
import 'package:testing/Models/ClientModel.dart';

class FirestoreMethods {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<ClientModel> getClient(String clientId) async {
    DocumentSnapshot snap =
        await _firestore.collection('clients').doc(clientId).get();
    return ClientModel.fromSnap(snap);
  }

  static Future<List<AnnouncementModel>> getAnnouncements(
      String activeCampaignId, String typeAd) async {
    List<AnnouncementModel> listAnnouncements = [];
    QuerySnapshot querySnap = await _firestore
        .collection('announcements')
        .where('campaignId', isEqualTo: activeCampaignId)
        .where('type', isEqualTo: typeAd)
        .orderBy('order')
        .get();
    querySnap.docs.forEach((document) {
      listAnnouncements.add(AnnouncementModel.fromSnap(document));
    });
    return listAnnouncements;
  }
}
