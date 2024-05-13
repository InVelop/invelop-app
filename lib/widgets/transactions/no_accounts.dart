import 'package:flutter/material.dart';
import 'package:invelop/pages/account/create_account_page.dart';
import 'package:invelop/theme/invelop_colors.dart';
import 'package:invelop/widgets/menuDrawer/menuDrawer_widget.dart';

class NoAccountsWidget extends StatelessWidget {
  const NoAccountsWidget({super.key});

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
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Text(
              'Primeiro você precisa criar uma conta',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: InVelopColors.text),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateAccountPage()),
              );
            },
            child: Text('Criar Conta'),
          ),
        ],
      )),
    );
  }
}
