import 'package:flutter/material.dart';
import 'package:invelop/services/auth_service.dart';
import 'package:invelop/theme/invelop_colors.dart';
import 'package:invelop/widgets/inputField/inputField_widget.dart';
import 'package:invelop/widgets/logo/logo_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<void>? _signInFuture;

  final _form = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  String? _errorMessage;

  final AuthService _authService = AuthService();

  sign() {
    if (_form.currentState!.validate()) {
      _signInFuture = _trySignIn();
      print("validated");
    }
  }

  Future<void> _trySignIn() async {
    try {
      String email = _email.text;
      String password = _password.text;

      var result =
          await _authService.signUser(email: email, password: password);

      print('_authService result: $result');
      if (result!.contains('is malformed or has expired')) {
        setState(() {
          _errorMessage = 'User not found';
        });
        return;
      } else {
        Navigator.pushNamed(context, '/home');
      }
    } catch (e) {
      print('Firebase error: $e');
      setState(() {
        _errorMessage = 'User not found';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: FutureBuilder(
                future: _signInFuture,
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else {
                    return Form(
                      key: _form,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const LogoWidget(),
                          InputFieldWidget(
                            label: "Email",
                            controller: _email,
                            inputType: TextInputType.emailAddress,
                            isRequired: true,
                          ),
                          const SizedBox(height: 16),
                          InputFieldWidget(
                              label: "Senha",
                              obscureText: true,
                              controller: _password,
                              isRequired: true),
                          const SizedBox(height: 32),
                          Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 300.0,
                                  height: 50.0,
                                  child: ElevatedButton(
                                    onPressed: sign,
                                    style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll<Color>(
                                                InVelopColors.secondary)),
                                    child: const Text('Login',
                                        style: TextStyle(
                                            color: InVelopColors.light)),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                ElevatedButton(
                                  onPressed: () {
                                    _form.currentState!.reset();
                                    Navigator.pushNamed(context, '/sign-up');
                                  },
                                  style: const ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll<Color>(
                                              Colors.transparent),
                                      shadowColor:
                                          MaterialStatePropertyAll<Color>(
                                              Colors.transparent)),
                                  child: const Text('Cadastre-se',
                                      style:
                                          TextStyle(color: InVelopColors.text)),
                                ),
                                if (_errorMessage != null)
                                  Text(
                                    _errorMessage!,
                                    style: const TextStyle(color: Colors.red),
                                  )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }
                }),
          )),
    );
  }
}
