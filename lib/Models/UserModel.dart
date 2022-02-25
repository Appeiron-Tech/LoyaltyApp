import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String name;
  final String lastName;
  final String phone;
  final String address;
  final String reference;
  final String city;
  final String district;
  final String province;
  final String clientId;

  UserModel({
    required this.uid,
    required this.clientId,
    required this.email,
    required this.name,
    required this.lastName,
    required this.phone,
    required this.address,
    required this.reference,
    required this.city,
    required this.district,
    required this.province,
  });

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
      uid: snapshot["uid"],
      email: snapshot["email"],
      name: snapshot["name"],
      lastName: snapshot["lastName"],
      phone: snapshot["phone"],
      address: snapshot["address"],
      reference: snapshot["reference"],
      city: snapshot["city"],
      district: snapshot["district"],
      province: snapshot["province"],
      clientId: snapshot["clientId"],
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "lastName": lastName,
        "email": email,
        "phone": phone,
        "address": address,
        "reference": reference,
        "city": city,
        "district": district,
        "province": province,
        "clientId": clientId
      };
}
