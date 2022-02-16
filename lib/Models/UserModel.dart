import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String email;
  final String nombres;
  final String apellidos;
  final String telefono;
  final String direccion;
  final String referencia;
  final String ciudad;
  final String distrito;
  final String provincia;

  User(
      {required this.uid,
      required this.email,
      required this.nombres,
      required this.apellidos,
      required this.telefono,
      required this.direccion,
      required this.referencia,
      required this.ciudad,
      required this.distrito,
      required this.provincia});

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      uid: snapshot["uid"],
      email: snapshot["email"],
      nombres: snapshot["nombre"],
      apellidos: snapshot["apellidos"],
      telefono: snapshot["telefono"],
      direccion: snapshot["direccion"],
      referencia: snapshot["referencia"],
      ciudad: snapshot["ciudad"],
      distrito: snapshot["distrito"],
      provincia: snapshot["provincia"],
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "nombres": nombres,
        "apellidos": apellidos,
        "telefono": telefono,
        "direccion": direccion,
        "referencia": referencia,
        "ciudad": ciudad,
        "distrito": distrito,
        "provincia": provincia,
      };
}
