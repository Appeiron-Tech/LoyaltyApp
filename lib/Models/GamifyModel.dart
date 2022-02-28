import 'package:cloud_firestore/cloud_firestore.dart';

class GamifyModel {
  String uid = '';
  late DateTime createdAt;
  num giftsTaken = 0;
  String idUser = '';
  late DateTime lastLogin;
  num level = 0;
  num offersTaken = 0;
  num points = 0;

  GamifyModel({
    required this.createdAt,
    required this.idUser,
    required this.level,
    required this.offersTaken,
    required this.uid,
    required this.lastLogin,
    required this.giftsTaken,
    required this.points,
  });

  static GamifyModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return GamifyModel(
      uid: snapshot["uid"],
      createdAt: snapshot["createdAt"].toDate(),
      idUser: snapshot["idUser"],
      level: snapshot["level"],
      offersTaken: snapshot["offersTaken"],
      giftsTaken: snapshot["giftsTaken"],
      lastLogin: snapshot["lastLogin"].toDate(),
      points: snapshot["points"],
    );
  }
}
