import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionModel {
  String uid = '';
  String text = '';
  String clientId = '';
  String surveyId = '';
  String type = '';
  bool active = false;
  late DateTime createdAt;
  List options = [];

  QuestionModel({
    required this.uid,
    required this.text,
    required this.clientId,
    required this.surveyId,
    required this.type,
    required this.active,
    required this.createdAt,
    required this.options,
  });

  static QuestionModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return QuestionModel(
      uid: snapshot['uid'],
      text: snapshot['text'],
      clientId: snapshot['clientId'],
      surveyId: snapshot['surveyId'],
      type: snapshot['type'],
      active: snapshot['active'],
      createdAt: snapshot['createdAt'].toDate(),
      options: snapshot['options'],
    );
  }
}
