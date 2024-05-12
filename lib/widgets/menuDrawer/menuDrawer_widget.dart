import 'package:flutter/material.dart';
import 'package:invelop/services/auth_service.dart';
import 'package:invelop/theme/invelop_colors.dart';

class MenuDrawerWidget extends StatelessWidget {
  
  const MenuDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
              ),
              ListTile(
                leading: const Icon(Icons.wallet),
                title: const Text("Criar conta"),
                onTap: () {
                  Navigator.pushNamed(context, '/create-account');
                },
              )
            ],
          ));
  }
}
