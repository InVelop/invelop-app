import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invelop/models/account_model.dart';
import 'package:invelop/models/user_model.dart';
import 'package:invelop/theme/invelop_colors.dart';
import 'package:provider/provider.dart';

class TransactionModal extends StatefulWidget {
  final List<AccountModel> accounts;

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

  addTransaction() async {
    print("Adding transaction");
    final accountID = Provider.of<UserProvider>(context, listen: false)
        .getAccountID(_accountName.text);
    print("Account ID: ${accountID}");
    print("Account: ${_accountName.text}");
    print("Amount: ${_amount.text}");
    print("Category: ${_category.text}");
    print("Date: ${_date.text}");
    print("Name: ${_name.text}");
    print("Type: ${_type.text}");

    if (_form.currentState!.validate()) {
      print("Validated");
      // Add your Firebase logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
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
                value: _accountName.text.isEmpty ? null : _accountName.text,
                items: widget.accounts?.map((account) {
                  return DropdownMenuItem<String>(
                    value: account.name,
                    child: Text(account.name),
                  );
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
              labelStyle: TextStyle(color: InVelopColors.text, fontSize: 20),
              contentPadding: EdgeInsets.only(left: 10, top: 10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                items: <String>['Income', 'Outcome'].map((String value) {
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
    ));
  }
}
