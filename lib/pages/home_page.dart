import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invelop/services/auth_service.dart';
import 'package:invelop/theme/invelop_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Envelopes',
          style: TextStyle(color: InVelopColors.text),
        ),
        backgroundColor: InVelopColors.background,
        iconTheme: const IconThemeData(color: InVelopColors.light),
      ),
      drawer: Drawer(
          surfaceTintColor: InVelopColors.light,
          child: ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("Sair"),
                onTap: () {
                  AuthService().logout();
                  Navigator.pushNamed(context, '/');
                },
              )
            ],
          )),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Text("250",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: InVelopColors.text)),
        ),
      ),
    );
  }
}
