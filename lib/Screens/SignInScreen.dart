import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:testing/Resources/auth_methods.dart';
import 'package:testing/Screens/GamifyProgram.dart';
import 'package:testing/Utils/utils.dart';

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
      nombres: _nombreController.text,
      apellidos: _apellidoController.text,
      telefono: _telefonoController.text,
      direccion: _direccionController.text,
      referencia: _referenciaController.text,
      distrito: _distritoController.text,
      ciudad: _ciudadController.text,
      provincia: _provinciaController.text,
    );

    // verificar la respuesta
    if (res == 'Registrado') {
      setState(() {
        _isLoading = false;
      });

      Map<String, String> route = {'title': GamifyProgram.routeName};

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => GamifyProgram(),
          settings: RouteSettings(arguments: route),
        ),
      );
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
      appBar: AppBar(title: const Text('Registro')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
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
            SizedBox(height: 10),
            TextFormField(
              controller: _apellidoController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                filled: true,
                icon: Icon(null),
                label: Text("Apellidos"),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                filled: true,
                icon: Icon(Icons.email),
                label: Text("Email"),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                filled: true,
                icon: Icon(Icons.password),
                label: Text("Password"),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _telefonoController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                filled: true,
                icon: Icon(Icons.phone),
                label: Text("Telefono"),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _direccionController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                filled: true,
                icon: Icon(Icons.location_on),
                label: Text("Dirección"),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _referenciaController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                filled: true,
                icon: Icon(null),
                label: Text("Detalles/Referencia"),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _distritoController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                filled: true,
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
                      filled: true,
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
                      filled: true,
                      label: Text("Provincia"),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: signUpUser,
                child: Text("Registrar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
