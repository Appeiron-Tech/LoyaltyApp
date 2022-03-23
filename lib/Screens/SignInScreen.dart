import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';
import 'package:testing/Resources/auth_methods.dart';
import 'package:testing/Screens/GamifyProgram.dart';
import 'package:testing/Utils/globalVariables.dart';
import 'package:testing/Utils/utils.dart';
import 'package:testing/Widgets/appBar.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // input controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _referenciaController = TextEditingController();
  final TextEditingController _distritoController = TextEditingController();
  final TextEditingController _ciudadController = TextEditingController();
  final TextEditingController _provinciaController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nombreController.dispose();
    _apellidoController.dispose();
    _telefonoController.dispose();
    _direccionController.dispose();
    _referenciaController.dispose();
    _distritoController.dispose();
    _ciudadController.dispose();
    _provinciaController.dispose();
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    // registrar al usuario
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        name: _nombreController.text,
        lastName: _apellidoController.text,
        phone: _telefonoController.text,
        address: _direccionController.text,
        reference: _referenciaController.text,
        district: _distritoController.text,
        city: _ciudadController.text,
        province: _provinciaController.text,
        clientId: clientId,
        imageUrl: 'urlgeneric');

    // verificar la respuesta
    if (res == 'Registrado') {
      setState(() {
        _isLoading = false;
      });

      Provider.of<ValueNotifier<int>>(context, listen: false).value = 1;
    } else {
      setState(() {
        _isLoading = false;
      });

      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(
        appBarText: 'Register',
        appbackgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _nombreController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                icon: Icon(Icons.person),
                label: Text("Nombres"),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _apellidoController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                icon: Icon(null),
                label: Text("Apellidos"),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                icon: Icon(Icons.email),
                label: Text("Email"),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                icon: Icon(Icons.password),
                label: Text("Password"),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _telefonoController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                icon: Icon(Icons.phone),
                label: Text("Telefono"),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _direccionController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                icon: Icon(Icons.location_on),
                label: Text("Dirección"),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _referenciaController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                icon: Icon(null),
                label: Text("Detalles/Referencia"),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _distritoController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                icon: Icon(null),
                label: Text("Distrito"),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    controller: _ciudadController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      icon: Icon(null),
                      label: Text("Ciudad"),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: _provinciaController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      label: Text("Provincia"),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: signUpUser,
                child: Text("SIGN UP"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
