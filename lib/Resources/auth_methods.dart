import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:testing/Models/UserModel.dart' as model;

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // registrar al usuario
  Future<String> signUpUser({
    required String email,
    required String password,
    required String nombres,
    required String apellidos,
    required String telefono,
    required String direccion,
    required String referencia,
    required String distrito,
    required String ciudad,
    required String provincia,
  }) async {
    String res = "Ocurrió un error";
    print("Estoy en signup");

    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          nombres.isNotEmpty ||
          apellidos.isNotEmpty ||
          telefono.isNotEmpty ||
          direccion.isNotEmpty ||
          referencia.isNotEmpty ||
          distrito.isNotEmpty ||
          ciudad.isNotEmpty ||
          provincia.isNotEmpty) {
        // si ninguno de los campos es vacio => registrar al usuario
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        model.User _user = model.User(
            uid: cred.user!.uid,
            email: email,
            nombres: nombres,
            apellidos: apellidos,
            telefono: telefono,
            direccion: direccion,
            referencia: referencia,
            ciudad: ciudad,
            distrito: distrito,
            provincia: provincia);

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
  Future<model.User> getUserDetails() async {
    User currentuser = _auth.currentUser!;
    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentuser.uid).get();

    return model.User.fromSnap(documentSnapshot);
  }
}
