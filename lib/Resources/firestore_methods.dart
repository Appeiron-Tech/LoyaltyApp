import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testing/Models/AnnouncementModel.dart';
import 'package:testing/Models/AnswerModel.dart';
import 'package:testing/Models/ClientModel.dart';
import 'package:testing/Models/GamifyModel.dart';
import 'package:testing/Models/GiftModel.dart';
import 'package:testing/Models/OfferModel.dart';
import 'package:testing/Models/ProductModel.dart';
import 'package:testing/Models/QuestionModel.dart';
import 'package:testing/Models/StoreModel.dart';
import 'package:testing/Models/SurveyModel.dart';
import 'package:testing/Utils/globalVariables.dart';
import 'package:uuid/uuid.dart';

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
    for (var document in querySnap.docs) {
      listAnnouncements.add(AnnouncementModel.fromSnap(document));
    }
    return listAnnouncements;
  }

  static Future<List<CategoryModel>> getCategories(String clientId) async {
    List<CategoryModel> listCategories = [];
    QuerySnapshot querySnap = await _firestore
        .collection('categories')
        .where('clientId', isEqualTo: clientId)
        .orderBy('order')
        .get();
    for (var document in querySnap.docs) {
      listCategories.add(CategoryModel.fromSnap(document));
    }
    return listCategories;
  }

  static Future<List<ProductModel>> getProducts() async {
    List<ProductModel> list = [];
    QuerySnapshot querySnap = await _firestore
        .collection('products')
        .where('clientId', isEqualTo: clientId)
        .where('active', isEqualTo: true)
        .get();
    for (var document in querySnap.docs) {
      list.add(ProductModel.fromSnap(document));
    }
    return list;
  }

  Future<List<OfferModel>> getOffers(String idUser) async {
    List<OfferModel> list = [];

    // get uid for each Offer per userId
    QuerySnapshot querySnap = await _firestore
        .collection('offerUsers')
        .where('idUser', isEqualTo: idUser)
        .get();

    // get info of offer using uid
    for (var document in querySnap.docs) {
      DocumentSnapshot snap = await _firestore
          .collection('offers')
          .doc(document.get('idOffer'))
          .get();
      list.add(OfferModel.fromSnap(snap));
    }
    return list;
  }

  Future<List<GiftModel>> getGifts(String idUser) async {
    List<GiftModel> list = [];

    // get uid for each Offer per userId
    QuerySnapshot querySnap = await _firestore
        .collection('giftUsers')
        .where('idUser', isEqualTo: idUser)
        .get();
    // get info of offer using uid
    for (var document in querySnap.docs) {
      DocumentSnapshot snap = await _firestore
          .collection('gifts')
          .doc(document.get('idGift'))
          .get();
      list.add(GiftModel.fromSnap(snap));
    }

    return list;
  }

  Future<GamifyModel> getGamify(String idUser) async {
    QuerySnapshot snap = await _firestore
        .collection('gamify')
        .where('idUser', isEqualTo: idUser)
        .get();
    return GamifyModel.fromSnap(snap.docs[0]);
  }

  Future<List<StoreModel>> getStores() async {
    List<StoreModel> list = [];
    QuerySnapshot querySnap = await _firestore
        .collection('stores')
        .where('clientId', isEqualTo: clientId)
        .get();
    for (var document in querySnap.docs) {
      list.add(StoreModel.fromSnap(document));
    }
    return list;
  }

  Future<List<QuestionModel>> getQuestions() async {
    List<QuestionModel> list = [];
    QuerySnapshot querySnap = await _firestore
        .collection('questions')
        .where('clientId', isEqualTo: clientId)
        .where('surveyId', isEqualTo: surveyId)
        .get();
    for (var document in querySnap.docs) {
      list.add(QuestionModel.fromSnap(document));
    }
    return list;
  }

  Future<String> uploadAnswer(String idQuestion, String text) async {
    String res = "Some error occurred";
    try {
      String answerId = Uuid().v1();

      AnswerModel answer = AnswerModel(
        uid: answerId,
        questionId: idQuestion,
        text: text,
        createdAt: DateTime.now(),
        surveyId: surveyId,
      );

      _firestore.collection('answers').doc(answerId).set(answer.toJson());
      res = answerId;
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> updateUser(
    String uid,
    String name,
    String lastName,
    String phone,
    String address,
    String reference,
    String district,
    String city,
    String province,
  ) async {
    String res = "Some error occurred";
    try {
      _firestore.collection('users').doc(uid).update({'name': name});
      _firestore.collection('users').doc(uid).update({'lastName': lastName});
      _firestore.collection('users').doc(uid).update({'phone': phone});
      _firestore.collection('users').doc(uid).update({'address': address});
      _firestore.collection('users').doc(uid).update({'reference': reference});
      _firestore.collection('users').doc(uid).update({'district': district});
      _firestore.collection('users').doc(uid).update({'city': city});
      _firestore.collection('users').doc(uid).update({'province': province});
      res = "Sucess";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
