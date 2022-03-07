import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testing/Models/UserModel.dart';
import 'package:testing/Resources/auth_methods.dart';
import 'package:testing/Resources/firestore_methods.dart';
import 'package:testing/Utils/utils.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  // input controllers
  late final TextEditingController _nombreController;
  late final TextEditingController _apellidoController;
  late final TextEditingController _telefonoController;
  late final TextEditingController _direccionController;
  late final TextEditingController _referenciaController;
  late final TextEditingController _distritoController;
  late final TextEditingController _ciudadController;
  late final TextEditingController _provinciaController;
  bool isLoading = false;
  UserModel? currentsUser;

  @override
  void dispose() {
    super.dispose();
    _nombreController.dispose();
    _apellidoController.dispose();
    _telefonoController.dispose();
    _direccionController.dispose();
    _referenciaController.dispose();
    _distritoController.dispose();
    _ciudadController.dispose();
    _provinciaController.dispose();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    setState(() {
      isLoading = true;
    });

    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;

      currentsUser = await AuthMethods().getUserDetails();

      _nombreController = TextEditingController(text: currentsUser?.name);
      _apellidoController = TextEditingController(text: currentsUser?.lastName);
      _telefonoController = TextEditingController(text: currentsUser?.phone);
      _direccionController = TextEditingController(text: currentsUser?.address);
      _referenciaController =
          TextEditingController(text: currentsUser?.reference);
      _distritoController = TextEditingController(text: currentsUser?.district);
      _ciudadController = TextEditingController(text: currentsUser?.city);
      _provinciaController =
          TextEditingController(text: currentsUser?.province);

      setState(() {});
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  void updateUser() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    String res = await FirestoreMethods().updateUser(
        userId,
        _nombreController.text,
        _apellidoController.text,
        _telefonoController.text,
        _direccionController.text,
        _referenciaController.text,
        _distritoController.text,
        _ciudadController.text,
        _provinciaController.text);
    if (res == 'Sucess') {
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text('User details'),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _nombreController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      filled: true,
                      icon: Icon(Icons.person),
                      label: Text("Nombres"),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _apellidoController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      filled: true,
                      icon: Icon(null),
                      label: Text("Apellidos"),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _telefonoController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      filled: true,
                      icon: Icon(Icons.phone),
                      label: Text("Telefono"),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _direccionController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      filled: true,
                      icon: Icon(Icons.location_on),
                      label: Text("Dirección"),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _referenciaController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      filled: true,
                      icon: Icon(null),
                      label: Text("Detalles/Referencia"),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _distritoController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      filled: true,
                      icon: Icon(null),
                      label: Text("Distrito"),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          controller: _ciudadController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            filled: true,
                            icon: Icon(null),
                            label: Text("Ciudad"),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: _provinciaController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            filled: true,
                            label: Text("Provincia"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: updateUser,
                      child: const Text("Actualizar"),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
