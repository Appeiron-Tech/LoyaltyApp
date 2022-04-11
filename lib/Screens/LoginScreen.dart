import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';
import 'package:testing/Resources/auth_methods.dart';
import 'package:testing/Screens/GamifyProgram.dart';
import 'package:testing/Screens/SignInScreen.dart';
import 'package:testing/Utils/globalVariables.dart';
import 'package:testing/Utils/utils.dart';
import 'package:testing/Widgets/appBar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);

    if (res == "Logeado") {
      Provider.of<ValueNotifier<int>>(context, listen: false).value = 2;

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

  void loginUserGoogle(BuildContext _context) async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().loginUserGoogle();

    if (res == 'Logeado con Google') {
      // ir a otra pagina
      Provider.of<ValueNotifier<int>>(_context, listen: false).value = 2;
      // ValueNotifier<int> a =
      //     Provider.of<ValueNotifier<int>>(context, listen: false);
      // a.value = 2;

      print('se logueó');
      setState(() {
        _isLoading = false;
      });
    } else {
      print('not working');
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
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(
        appBarText: 'Sign In',
        appbackgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Email address"),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Password"),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: loginUser,
                        child: Text("Ingresar"),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text('OR', style: Theme.of(context).textTheme.bodyText2),
                    SizedBox(height: 15),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: SignInButton(
                        Buttons.Google,
                        text: "Ingresa con Google",
                        onPressed: () => loginUserGoogle(context),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .center, //Center Row contents horizontally,
                      crossAxisAlignment: CrossAxisAlignment
                          .center, //Center Row contents vertically,
                      children: [
                        Text('Not a user yet?',
                            style: Theme.of(context).textTheme.bodyText1),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const SignInPage(),
                              ),
                            );
                          },
                          child: Text("Sign up",
                              style: Theme.of(context).textTheme.labelMedium),
                        ),
                      ],
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
