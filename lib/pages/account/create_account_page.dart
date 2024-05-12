import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:invelop/theme/invelop_colors.dart';
import 'package:invelop/utils/CurrencyFormat.dart';
import 'package:invelop/widgets/button/button_widget.dart';
import 'package:invelop/widgets/inputField/inputField_widget.dart';
import 'package:invelop/widgets/menuDrawer/menuDrawer_widget.dart';
import 'package:invelop/widgets/selectField/selectField_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _form = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController initialValueController = TextEditingController();
  String selectedDropdownValue = "credit_card";

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

      var collection = FirebaseFirestore.instance.collection('users/$userUID/accounts');
      collection.add({
        'name': nameController.text,
        'account_type': selectedDropdownValue,
        'balance': initialValueController.text
      }).then((result) {
        print("Conta cadastrada com sucesso!");
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Conta cadastrada com sucesso!")));
      }).catchError((err) {
        print("Erro ao cadastrar conta: $err");
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
