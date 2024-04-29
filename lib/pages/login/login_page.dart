import 'package:flutter/material.dart';
import 'package:invelop/theme/invelop_colors.dart';
import 'package:invelop/widgets/logo/logo_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LogoWidget(),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: InVelopColors.light),
                floatingLabelStyle: TextStyle(color: InVelopColors.light),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: InVelopColors.light),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: InVelopColors.light),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
                labelStyle: TextStyle(color: InVelopColors.light),
                floatingLabelStyle: TextStyle(color: InVelopColors.light),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: InVelopColors.light),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: InVelopColors.light),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Center(
              child: Column(
                children: [
                  SizedBox(
                    width: 300.0,
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/home');
                      },
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                              InVelopColors.secondary)),
                      child: const Text('Login',
                          style: TextStyle(color: Color(0xffffffff))),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/home');
                    },
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Colors.transparent),
                        shadowColor: MaterialStatePropertyAll<Color>(
                            Colors.transparent)),
                    child: const Text('Cadastre-se',
                        style: TextStyle(color: InVelopColors.text)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
