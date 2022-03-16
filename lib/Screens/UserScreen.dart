import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testing/Models/UserModel.dart';
import 'package:testing/Resources/auth_methods.dart';
import 'package:testing/Resources/firestore_methods.dart';
import 'package:testing/Screens/MainMenu.dart';
import 'package:testing/Utils/globalVariables.dart';
import 'package:testing/Utils/utils.dart';
import 'package:testing/Widgets/appBar.dart';

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

  void logout() async {
    await FirebaseAuth.instance.signOut();

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const MainMenu()));
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
            backgroundColor: Colors.white,
            appBar: const AppBarWidget(
              appBarText: 'User',
              appbackgroundColor: Colors.white,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.only(left: 50, right: 50, bottom: 70),
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: CachedNetworkImageProvider(
                          currentsUser?.imageUrl ??
                              'https://picsum.photos/100'),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Theme(
                    data: ThemeData(
                      inputDecorationTheme: const InputDecorationTheme(
                        labelStyle: TextStyle(
                          color: colorText1,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: colorText1),
                        ),
                      ),
                    ),
                    child: TextFormField(
                      controller: _nombreController,
                      decoration: const InputDecoration(
                        label: Text("Nombres"),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Theme(
                    data: ThemeData(
                      inputDecorationTheme: const InputDecorationTheme(
                        labelStyle: TextStyle(
                          color: colorText1,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: colorText1),
                        ),
                      ),
                    ),
                    child: TextFormField(
                      controller: _apellidoController,
                      decoration: const InputDecoration(
                        label: Text("Apellidos"),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Theme(
                    data: ThemeData(
                      inputDecorationTheme: const InputDecorationTheme(
                        labelStyle: TextStyle(
                          color: colorText1,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: colorText1),
                        ),
                      ),
                    ),
                    child: TextFormField(
                      controller: _telefonoController,
                      decoration: const InputDecoration(
                        label: Text("Telefono"),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Theme(
                    data: ThemeData(
                      inputDecorationTheme: const InputDecorationTheme(
                        labelStyle: TextStyle(
                          color: colorText1,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: colorText1),
                        ),
                      ),
                    ),
                    child: TextFormField(
                      controller: _direccionController,
                      decoration: const InputDecoration(
                        label: Text("Dirección"),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Theme(
                    data: ThemeData(
                      inputDecorationTheme: const InputDecorationTheme(
                        labelStyle: TextStyle(
                          color: colorText1,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: colorText1),
                        ),
                      ),
                    ),
                    child: TextFormField(
                      controller: _referenciaController,
                      decoration: const InputDecoration(
                        label: Text("Detalles/Referencia"),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Theme(
                    data: ThemeData(
                      inputDecorationTheme: const InputDecorationTheme(
                        labelStyle: TextStyle(
                          color: colorText1,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: colorText1),
                        ),
                      ),
                    ),
                    child: TextFormField(
                      controller: _distritoController,
                      decoration: const InputDecoration(
                        label: Text("Distrito"),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Theme(
                          data: ThemeData(
                            inputDecorationTheme: const InputDecorationTheme(
                              labelStyle: TextStyle(
                                color: colorText1,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: colorText1),
                              ),
                            ),
                          ),
                          child: TextFormField(
                            controller: _ciudadController,
                            decoration: const InputDecoration(
                              label: Text("Ciudad"),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Theme(
                          data: ThemeData(
                            inputDecorationTheme: const InputDecorationTheme(
                              labelStyle: TextStyle(
                                color: colorText1,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: colorText1),
                              ),
                            ),
                          ),
                          child: TextFormField(
                            controller: _provinciaController,
                            decoration: const InputDecoration(
                              label: Text("Provincia"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: updateUser,
                      child: const Text("Actualizar"),
                    ),
                  ),
                  const SizedBox(height: 7),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: logout,
                      child: const Text("Cerrar sesión"),
                    ),
                  ),
                  const SizedBox(height: 7),
                ],
              ),
            ),
          );
  }
}
