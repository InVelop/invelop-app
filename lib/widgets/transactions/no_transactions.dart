import 'package:flutter/material.dart';
import 'package:invelop/pages/account/create_account_page.dart';
import 'package:invelop/theme/invelop_colors.dart';
import 'package:invelop/widgets/custom_fab/custom_fab_widget.dart';
import 'package:invelop/widgets/menuDrawer/menuDrawer_widget.dart';

class NoTransactionsWidget extends StatelessWidget {
  const NoTransactionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TRANSAÇÕES',
          style: TextStyle(color: InVelopColors.text),
        ),
        backgroundColor: InVelopColors.background,
        iconTheme: const IconThemeData(color: InVelopColors.light),
      ),
      drawer: const MenuDrawerWidget(),
      body: const Center(
        child: Text(
          'Nenhuma transação encontrada',
          style: TextStyle(color: InVelopColors.text),
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: CustomFabWidget(
          menuItems: const [
            PopupMenuItem(
              value: 1,
              child: Text("Adicionar transação",
                  style: TextStyle(color: InVelopColors.text)),
            ),
            PopupMenuItem(
              value: 2,
              child: Text("Acessar contas",
                  style: TextStyle(color: InVelopColors.text)),
            ),
          ],
          onItemSelected: (value) {
            if (value == 1) {
              // Add transaction
              print("ADD TRANSACTION");
            } else if (value == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreateAccountPage()),
              );
            }
          },
        ),
      ),
    );
  }
}
