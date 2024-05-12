import 'package:flutter/material.dart';
import 'package:invelop/pages/myAccounts/account_widget.dart';
import 'package:invelop/theme/invelop_colors.dart';
import 'package:invelop/widgets/menuDrawer/menuDrawer_widget.dart';

class CreateMyAccountsPage extends StatefulWidget {
  const CreateMyAccountsPage({super.key});

  @override
  State<CreateMyAccountsPage> createState() => _MyAccountsPage();
}

class _MyAccountsPage extends State<CreateMyAccountsPage> {
  save() {
    print("Salve");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Minhas contas',
          style: TextStyle(color: InVelopColors.text),
        ),
        backgroundColor: InVelopColors.primary,
        iconTheme: const IconThemeData(color: InVelopColors.light),
      ),
      drawer: const MenuDrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(children: <Widget>[
          account('Todas', 'R\$ 13.537,00'),
          account('Bradesco', 'R\$ 3.537,00'),
          account('Itaú', 'R\$ 2.537,00'),
          account('NuInvest', 'R\$ 537,00'),
          account('Nubank', 'R\$ 227,00'),
          account('XP Corretora', 'R\$ 1333,00'),
          account('XP Corretora', 'R\$ 121,00'),
        ]),
      ),
    );
  }
}
