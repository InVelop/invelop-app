import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:invelop/pages/account/create_account_page.dart';
import 'package:invelop/pages/myAccounts/account_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:invelop/pages/transactions/transactions.dart';
import 'package:invelop/theme/invelop_colors.dart';
import 'package:invelop/widgets/custom_fab/custom_fab_widget.dart';
import 'package:invelop/widgets/menuDrawer/menuDrawer_widget.dart';

class CreateMyAccountsPage extends StatefulWidget {
  const CreateMyAccountsPage({super.key});

  @override
  State<CreateMyAccountsPage> createState() => _MyAccountsPage();
}

class _MyAccountsPage extends State<CreateMyAccountsPage> {
  String? getUserUID() {
    final user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  @override
  Widget build(BuildContext context) {
    var userUID = getUserUID();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Minhas contas',
          style: TextStyle(color: InVelopColors.text),
        ),
        backgroundColor: InVelopColors.background,
        iconTheme: const IconThemeData(color: InVelopColors.light),
      ),
      drawer: const MenuDrawerWidget(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users/$userUID/accounts')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Algo deu errado');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              double? balance = double.tryParse(data['balance']
                  .toString()
                  .replaceAll("R\$ ", "")
                  .replaceAll(".", "")
                  .replaceAll(",", "."));
              return account(
                data['name'],
                balance,
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: CustomFabWidget(
          menuItems: const [
            PopupMenuItem(
              value: 1,
              child: Text("Nova conta",
                  style: TextStyle(color: InVelopColors.text)),
            ),
            PopupMenuItem(
              value: 2,
              child: Text("Transações",
                  style: TextStyle(color: InVelopColors.text)),
            ),
          ],
          onItemSelected: (value) {
            if (value == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreateAccountPage()),
              );
            } else if (value == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TransactionsPage()),
              );
            }
          },
        ),
      ),
    );
  }
}
