import 'package:flutter/material.dart';
import 'package:invelop/services/auth_service.dart';
import 'package:invelop/theme/invelop_colors.dart';
import 'package:invelop/widgets/inputField/inputField_widget.dart';
import 'package:invelop/widgets/logo/logo_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  final AuthService _authService = AuthService();

  register() async {
    if (_form.currentState!.validate()) {
      String email = _email.text.toLowerCase().trim();
      String password = _password.text;
      registerUser(email, password);
    }
  }

  Future<void> registerUser(String email, String password) async {
    // _authService.registerUser(email: email, password: password);
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;

      if (user != null) {
        // Create a user document in Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
            {'name': _name.text, 'email': email, 'displayName': _name.text});

        Navigator.pushNamed(context, '/budget');
      }
    } on FirebaseAuthException catch (e) {
      // Handle authentication errors (e.g., weak password)
      print(e
          .code); // You can display error messages to the user based on the error code
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        _form.currentState!.reset();
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_left_outlined,
                        color: InVelopColors.light,
                        size: 42,
                      ))
                ],
              ),
            )),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: _form,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const LogoWidget(),
                    InputFieldWidget(
                        label: "Nome completo",
                        controller: _name,
                        isRequired: true),
                    const SizedBox(height: 16),
                    InputFieldWidget(
                        label: "Email",
                        controller: _email,
                        inputType: TextInputType.emailAddress,
                        isRequired: true),
                    const SizedBox(height: 16),
                    InputFieldWidget(
                      label: "Senha",
                      inputType: TextInputType.visiblePassword,
                      controller: _password,
                      isRequired: true,
                      validator: (value) {
                        if (value!.length < 6) {
                          return "A senha deve ter pelo menos 6 caractéres";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    InputFieldWidget(
                      label: "Confirmação da Senha",
                      obscureText: true,
                      controller: _confirmPassword,
                      isRequired: true,
                      validator: (value) {
                        if (value != _password.text) {
                          return "A confirmação de senha precisa ser igual a senha";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),
                    Center(
                      child: Column(
                        children: [
                          SizedBox(
                            width: 300.0,
                            height: 50.0,
                            child: ElevatedButton(
                              onPressed: register,
                              style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll<Color>(
                                          InVelopColors.secondary)),
                              child: const Text('Cadastrar',
                                  style: TextStyle(color: Color(0xffffffff))),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
