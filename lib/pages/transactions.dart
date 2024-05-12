import 'package:flutter/material.dart';
import 'package:invelop/services/auth_service.dart';
import 'package:invelop/theme/invelop_colors.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transactions',
          style: TextStyle(color: InVelopColors.text),
        ),
        backgroundColor: InVelopColors.background,
      ),
      drawer: Drawer(
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
    );
  }
}
