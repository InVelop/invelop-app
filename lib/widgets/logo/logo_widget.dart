import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child:
              Image.asset('assets/invelop_logo.png', width: 100, height: 100),
        ),
        const Text(
          "InVelop",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0XFF000000)),
        ),
      ],
    );
  }
}
