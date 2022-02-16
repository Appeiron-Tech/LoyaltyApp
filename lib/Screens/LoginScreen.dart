import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:testing/Resources/auth_methods.dart';
import 'package:testing/Screens/GamifyProgram.dart';
import 'package:testing/Screens/SignInScreen.dart';
import 'package:testing/Utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  // ----------------------------------------------------------------

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // ------------------------------------------------------------------

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);

    if (res == "Logeado") {
      // ir a otra pagina
      Map<String, String> route = {'title': GamifyProgram.routeName};

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => GamifyProgram(),
          settings: RouteSettings(arguments: route),
        ),
      );

      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(context, res);
    }
  }

  void loginUserGoogle() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().loginUserGoogle();

    if (res == 'Logeado con Google') {
      // ir a otra pagina
      Map<String, String> route = {'title': GamifyProgram.routeName};

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => GamifyProgram(),
          settings: RouteSettings(arguments: route),
        ),
      );

      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(context, res);
    }
  }

  // ---------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  filled: true,
                  icon: Icon(Icons.email),
                  label: Text("Email"),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  filled: true,
                  icon: Icon(Icons.password),
                  label: Text("Contraseña"),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: loginUser,
                      child: Text("Ingresar"),
                    ),
                    SizedBox(height: 5),
                    SignInButton(
                      Buttons.Google,
                      text: "Ingresa con Google",
                      onPressed: loginUserGoogle,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const SignInPage(),
                          ),
                        );
                      },
                      child: const Text("¿No tienes una cuenta? Registrate"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
