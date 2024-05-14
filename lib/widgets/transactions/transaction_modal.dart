import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invelop/models/account_model.dart';
import 'package:invelop/models/user_model.dart';
import 'package:invelop/services/user_service.dart';
import 'package:invelop/theme/invelop_colors.dart';
import 'package:provider/provider.dart';

class TransactionModal extends StatefulWidget {
  final List<AccountModel>? accounts;

  TransactionModal({required this.accounts});

  @override
  _TransactionModalState createState() => _TransactionModalState();
}

class _TransactionModalState extends State<TransactionModal> {
  final _form = GlobalKey<FormState>();
  final _accountName = TextEditingController();
  final _amount = TextEditingController();
  final _category = TextEditingController();
  final _date = TextEditingController();
  final _name = TextEditingController();
  final _type = TextEditingController();

  String getUserUID() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    return user?.uid ?? '';
  }

  addTransaction() async {
    if (_form.currentState!.validate()) {
      final accountID = Provider.of<UserProvider>(context, listen: false)
          .getAccountID(_accountName.text);
      var userUID = getUserUID();
      if (userUID == null) {
        print("Nenhum usuário está logado.");
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Nenhum usuário está logado.")));
        return;
      }

      var collection = FirebaseFirestore.instance
          .collection('users/$userUID/accounts/$accountID/transactions');

      collection.add({
        'accountName': _accountName.text,
        'amount': double.tryParse(_amount.text),
        'category': _category.text,
        'date': DateFormat('dd-MM-yyyy').parse(_date.text),
        'name': _name.text,
        'type': _type.text == 'Receita' ? 'income' : 'expense',
      }).then((result) {
        _form.currentState!.reset();
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Transação adicionada com sucesso!")));
      }).catchError((err) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Erro ao cadastrar a transação: $err")));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _form,
              child: Column(
                children: <Widget>[
                  InputDecorator(
                    decoration: const InputDecoration(
                      labelText: "Conta",
                      labelStyle: TextStyle(
                        color: InVelopColors.text,
                        fontSize: 20,
                      ),
                      contentPadding: EdgeInsets.only(left: 10),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _accountName.text.isEmpty
                            ? null
                            : _accountName.text,
                        items: widget.accounts?.map((account) {
                          return DropdownMenuItem<String>(
                              value: account.name,
                              child: Text(account.name,
                                  style: const TextStyle(
                                      color: InVelopColors.text)));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _accountName.text = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  InputDecorator(
                    decoration: const InputDecoration(
                      labelText: "Tipo",
                      labelStyle:
                          TextStyle(color: InVelopColors.text, fontSize: 20),
                      contentPadding: EdgeInsets.only(left: 10, top: 10),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        items:
                            <String>['Receita', 'Despesa'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          _type.text = value!;
                        },
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _amount,
                    style: const TextStyle(color: InVelopColors.text),
                    decoration: const InputDecoration(
                      labelText: 'Valor',
                      labelStyle: TextStyle(color: InVelopColors.text),
                      contentPadding: EdgeInsets.only(left: 10),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    controller: _category,
                    style: const TextStyle(color: InVelopColors.text),
                    decoration: const InputDecoration(
                      labelText: 'Categoria',
                      labelStyle: TextStyle(color: InVelopColors.text),
                      contentPadding: EdgeInsets.only(left: 10),
                    ),
                  ),
                  TextFormField(
                    controller: _date,
                    readOnly: true,
                    style: const TextStyle(color: InVelopColors.text),
                    decoration: const InputDecoration(
                      labelText: 'Data',
                      labelStyle: TextStyle(color: InVelopColors.text),
                      contentPadding: EdgeInsets.only(left: 10),
                    ),
                    onTap: () async {
                      var date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (date != null) {
                        _date.text = DateFormat('dd-MM-yyyy').format(date);
                      }
                    },
                  ),
                  TextFormField(
                    controller: _name,
                    style: const TextStyle(color: InVelopColors.text),
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                      labelStyle: TextStyle(color: InVelopColors.text),
                      contentPadding: EdgeInsets.only(left: 10),
                    ),
                  ),
                  TextButton(
                    child: const Text('Add Transaction',
                        style: TextStyle(color: InVelopColors.text)),
                    onPressed: () {
                      addTransaction();
                    },
                  ),
                ],
              ),
            )));
  }
}
