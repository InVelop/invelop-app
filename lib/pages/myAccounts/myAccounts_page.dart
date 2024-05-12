import 'package:flutter/material.dart';
import 'package:invelop/pages/myAccounts/account_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:invelop/theme/invelop_colors.dart';


class CreateMyAccountsPage extends StatefulWidget {
  const CreateMyAccountsPage({super.key});

  @override
  State<CreateMyAccountsPage> createState() => _MyAccountsPage();
}

class _MyAccountsPage extends State<CreateMyAccountsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Minhas contas',
          style: TextStyle(color: InVelopColors.text),
        ),
        backgroundColor: InVelopColors.background,
        iconTheme: const IconThemeData(color: InVelopColors.light),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('accounts').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Algo deu errado');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              return account(
                data['name'],
                data['balance'],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
