import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:invelop/models/account_model.dart';
import 'package:invelop/models/user_model.dart';
import 'package:invelop/pages/budget/budget_page.dart';
import 'package:invelop/theme/invelop_colors.dart';
import 'package:invelop/utils/CurrencyFormat.dart';
import 'package:invelop/widgets/button/button_widget.dart';
import 'package:invelop/widgets/inputField/inputField_widget.dart';
import 'package:invelop/widgets/menuDrawer/menuDrawer_widget.dart';
import 'package:invelop/widgets/selectField/selectField_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _form = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController initialValueController = TextEditingController();
  String selectedDropdownValue = "1St2h7anOBLj71kpxeyt";

  final List<DropdownItem> items = [
    DropdownItem("Conta Corrente", "kBUAiQxs0ZJnyPksepxv"),
    DropdownItem("Conta poupança", "PfEmKK9VM4eg7lCenqAp"),
    DropdownItem("Cartão de crédito", "1St2h7anOBLj71kpxeyt"),
    DropdownItem("Dinheiro", "wuR1bswDsUyLH7qAROZ4")
  ];

  String? getUserUID() {
    final user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  void save() {
    if (_form.currentState!.validate()) {
      var userUID = getUserUID();
      if (userUID == null) {
        print("Nenhum usuário está logado.");
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Nenhum usuário está logado.")));
        return;
      }

      var collection =
          FirebaseFirestore.instance.collection('users/$userUID/accounts');

      double? balance = double.tryParse(initialValueController.text
          .replaceAll("R\$ ", "")
          .replaceAll(".", "")
          .replaceAll(",", "."));
      if (balance == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Valor do balanço inválido.")));
        return;
      }

      collection.add({
        'name': nameController.text,
        'account_type': selectedDropdownValue,
        'balance': balance
      }).then((result) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Conta cadastrada com sucesso!")));
            
            AccountModel newAccount = AccountModel(accountType: selectedDropdownValue, balance: balance, name: nameController.text, uid: result.id);
            var userProvider = Provider.of<UserProvider>(context, listen: false);
            userProvider.updateAccounts([newAccount]);
            Navigator.pushNamed(context, '/budget');
      }).catchError((err) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Erro ao cadastrar conta: $err")));
      }); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cadastrar conta',
          style: TextStyle(color: InVelopColors.text),
        ),
        backgroundColor: InVelopColors.background,
        iconTheme: const IconThemeData(color: InVelopColors.light),
      ),
      drawer: const MenuDrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Form(
              key: _form,
              child: Column(
                children: [
                  InputFieldWidget(
                    controller: nameController,
                    label: "Nome",
                  ),
                  const SizedBox(height: 32),
                  SelectField(
                    items: items,
                    onChanged: (value) =>
                        setState(() => selectedDropdownValue = value.value),
                  ),
                  const SizedBox(height: 32),
                  InputFieldWidget(
                    controller: initialValueController,
                    label: "Valor inicial",
                    inputType:
                        const TextInputType.numberWithOptions(decimal: true),
                    formatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CurrencyPtBrInputFormatter()
                    ],
                  ),
                  const SizedBox(height: 64),
                  ButtonWidget(
                    label: "Salvar",
                    onPressed: save,
                  )
                ],
              )),
        ),
      ),
    );
  }
}
