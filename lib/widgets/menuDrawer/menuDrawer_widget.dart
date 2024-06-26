import 'package:flutter/material.dart';
import 'package:invelop/models/user_model.dart';
import 'package:invelop/services/auth_service.dart';
import 'package:invelop/theme/invelop_colors.dart';
import 'package:provider/provider.dart';

class MenuDrawerWidget extends StatelessWidget {
  const MenuDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        surfaceTintColor: InVelopColors.light,
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.savings),
              title: const Text("Orçamento"),
              onTap: () {
                Navigator.pushNamed(context, '/budget');
              },
            ),
            ListTile(
                leading: const Icon(Icons.wallet),
                title: const Text("Minhas contas"),
                onTap: () {
                  Navigator.pushNamed(context, '/myAccounts');
                },
              ),
            ListTile(
              leading: const Icon(Icons.money),
              title: const Text("Transações"),
              onTap: () {
                Navigator.pushNamed(context, '/transactions');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Sair"),
              onTap: () {
                AuthService().logout();
                final userProvider = Provider.of<UserProvider>(context, listen: false);
                userProvider.cleanUser();
                Navigator.pushNamed(context, '/');
              },
            ),
          ],
        ));
  }
}
