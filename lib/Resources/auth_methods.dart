import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:testing/Models/UserModel.dart';

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // registrar al usuario
  Future<String> signUpUser({
    required String email,
    required String password,
    required String name,
    required String lastName,
    required String phone,
    required String address,
    required String reference,
    required String district,
    required String city,
    required String province,
    required String clientId,
    required String imageUrl,
  }) async {
    String res = "Ocurrió un error";
    print("Estoy en signup");

    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          name.isNotEmpty ||
          lastName.isNotEmpty ||
          phone.isNotEmpty ||
          address.isNotEmpty ||
          reference.isNotEmpty ||
          district.isNotEmpty ||
          city.isNotEmpty ||
          province.isNotEmpty ||
          clientId.isNotEmpty) {
        // si ninguno de los campos es vacio => registrar al usuario
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        UserModel _user = UserModel(
          uid: cred.user!.uid,
          email: email,
          name: name,
          lastName: lastName,
          phone: phone,
          address: address,
          reference: reference,
          city: city,
          district: district,
          province: province,
          clientId: clientId,
          imageUrl: imageUrl,
        );

        // enviar los datos del usuario a firestore
        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(_user.toJson());

        res = "Registrado";
      } else {
        res = "Ingrese todos los campos";
      }
    } catch (e) {
      return e.toString();
    }

    return res;
  }

  // logear al usuario
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Ocurrió un error";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Logeado";
      } else {
        res = "Ingresa todos los campos";
      }
    } catch (e) {
      return e.toString();
    }
    return res;
  }

  // logear usuario con google
  Future<String> loginUserGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    String res = "Ocurrió un error";

    try {
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);

        // Getting users credential
        UserCredential result =
            await _auth.signInWithCredential(authCredential);
        User? user = result.user;

        if (result != null) {
          res = 'Logeado con Google';
        } //
      } else {
        print('murio');
      }
    } catch (e) {
      return e.toString();
    }

    return res;
  }

  // desloagear
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // obtener datos del usuario
  Future<UserModel> getUserDetails() async {
    User currentuser = _auth.currentUser!;
    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentuser.uid).get();
    print("estoy en future");
    return UserModel.fromSnap(documentSnapshot);
  }
}
