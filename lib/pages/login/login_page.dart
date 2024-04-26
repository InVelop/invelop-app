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
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/home');
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            InVelopColors.secondary)),
                    child: const Text('Login',
                        style: TextStyle(color: Color(0xffffffff))),
                  ),
                  const SizedBox(height: 24),
                  const Text("Esqueci a senha")
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
