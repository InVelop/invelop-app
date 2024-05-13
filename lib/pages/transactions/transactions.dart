import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invelop/models/transaction_model.dart';
import 'package:invelop/models/user_model.dart';
import 'package:invelop/pages/account/create_account_page.dart';
import 'package:invelop/pages/myAccounts/myAccounts_page.dart';
import 'package:invelop/utils/custom_date_utils.dart';
import 'package:invelop/theme/invelop_colors.dart';
import 'package:invelop/widgets/custom_fab/custom_fab_widget.dart';
import 'package:invelop/widgets/menuDrawer/menuDrawer_widget.dart';
import 'package:invelop/widgets/transactions/no_accounts.dart';
import 'package:invelop/widgets/transactions/no_transactions.dart';
import 'package:provider/provider.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  final _form = GlobalKey<FormState>();
  final _accountName = TextEditingController();
  final _amount = TextEditingController();
  final _category = TextEditingController();
  final _date = TextEditingController();
  final _name = TextEditingController();
  final _type = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    final uid = user?.uid;
    final email = user?.email;
    final accounts = user?.accounts;
    final transactions =
        user?.accounts?.expand((account) => account.transactions ?? []);

    if (transactions != null && transactions.isNotEmpty) {
      transactions.toList().sort((a, b) => b.date.compareTo(a.date));
    }

    addTransaction() async {
      print("Adding transaction");
      print("Account: ${_accountName.text}");
      print("Amount: ${_amount.text}");
      print("Category: ${_category.text}");
      print("Date: ${_date.text}");
      print("Name: ${_name.text}");
      print("Type: ${_type.text}");

      if (_form.currentState!.validate()) {
        print("Validated");
      }
    }

    if (accounts == null || accounts.isEmpty) {
      return const NoAccountsWidget();
    } else if (accounts.isNotEmpty &&
        transactions != null &&
        transactions.isEmpty) {
      return const NoTransactionsWidget();
    } else {
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
        body: ListView.builder(
          itemCount: transactions!.length,
          itemBuilder: (context, index) {
            final transaction = transactions.toList()[index];
            final previousTransaction =
                index > 0 ? transactions.toList()[index - 1] : null;
            final showDate = previousTransaction == null ||
                transaction.date.day != previousTransaction.date.day;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showDate)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            CustomDateUtils.formatDateTransaction(
                                transaction.date),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: InVelopColors.text,
                            ),
                          ),
                        ),
                        const Divider(
                            color: InVelopColors.subtle,
                            indent: 20,
                            endIndent: 20),
                      ],
                    ),
                  ),
                ListTile(
                  title: Text(transaction.name,
                      style: const TextStyle(color: InVelopColors.text)),
                  subtitle: Text(
                    transaction.category,
                    style: const TextStyle(color: InVelopColors.subtle),
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        '${transaction.type == 'income' ? '' : '-'} R\$ ${transaction.amount.abs().toStringAsFixed(2)}',
                        style: TextStyle(
                            color: transaction.type == 'income'
                                ? Colors.green
                                : Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                      Text(
                        transaction.accountName ?? 'Conta',
                        style: const TextStyle(
                            color: InVelopColors.subtle, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
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
                showModalBottomSheet(
                  context: context,
                  backgroundColor: InVelopColors.background,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Form(
                          key: _form,
                          child: Column(
                            children: <Widget>[
                              InputDecorator(
                                decoration: const InputDecoration(
                                  labelText: "Conta",
                                  labelStyle:
                                      TextStyle(color: InVelopColors.text),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: _accountName.text.isEmpty
                                        ? null
                                        : _accountName.text,
                                    items: accounts?.map((account) {
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
                              TextFormField(
                                controller: _amount,
                                style:
                                    const TextStyle(color: InVelopColors.text),
                                decoration: const InputDecoration(
                                  labelText: 'Valor',
                                  labelStyle:
                                      TextStyle(color: InVelopColors.text),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                              TextFormField(
                                controller: _category,
                                style:
                                    const TextStyle(color: InVelopColors.text),
                                decoration: const InputDecoration(
                                  labelText: 'Categoria',
                                  labelStyle:
                                      TextStyle(color: InVelopColors.text),
                                ),
                              ),
                              TextFormField(
                                controller: _date,
                                readOnly: true,
                                style:
                                    const TextStyle(color: InVelopColors.text),
                                decoration: const InputDecoration(
                                  labelText: 'Data',
                                  labelStyle:
                                      TextStyle(color: InVelopColors.text),
                                ),
                                onTap: () async {
                                  var date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                  );
                                  if (date != null) {
                                    _date.text =
                                        DateFormat('dd-MM-yyyy').format(date);
                                  }
                                },
                              ),
                              TextFormField(
                                controller: _name,
                                style:
                                    const TextStyle(color: InVelopColors.text),
                                decoration: const InputDecoration(
                                  labelText: 'Nome',
                                  labelStyle:
                                      TextStyle(color: InVelopColors.text),
                                ),
                              ),
                              InputDecorator(
                                decoration: const InputDecoration(
                                  labelText: "Tipo",
                                  labelStyle:
                                      TextStyle(color: InVelopColors.text),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    items: <String>['Income', 'Outcome']
                                        .map((String value) {
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
                              TextButton(
                                child: const Text('Add Transaction',
                                    style:
                                        TextStyle(color: InVelopColors.text)),
                                onPressed: () {
                                  addTransaction();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else if (value == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreateMyAccountsPage()),
                );
              }
            },
          ),
        ),
      );
    }
  }
}
