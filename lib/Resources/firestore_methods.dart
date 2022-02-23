import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testing/Models/AnnouncementModel.dart';
import 'package:testing/Models/ClientModel.dart';
import 'package:testing/Utils/globalVariables.dart';

import '../Models/CategoryModel.dart';

class FirestoreMethods {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<String> getCoverUrl() async {
    QuerySnapshot querySnap = await _firestore
        .collection('covers')
        .where('clientId', isEqualTo: clientId)
        .get();
    var data = querySnap.docs[0].data() as Map<String, dynamic>;
    return data['image'];
  }

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

  static Future<List<CategoryModel>> getCategories(String clientId) async {
    List<CategoryModel> listCategories = [];
    QuerySnapshot querySnap = await _firestore
        .collection('categories')
        .where('clientId', isEqualTo: clientId)
        .orderBy('order')
        .get();
    querySnap.docs.forEach((document) {
      listCategories.add(CategoryModel.fromSnap(document));
    });
    return listCategories;
  }
}
