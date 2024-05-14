import 'package:flutter/material.dart';
import 'package:invelop/models/user_model.dart';
import 'package:invelop/pages/myAccounts/myAccounts_page.dart';
import 'package:invelop/services/user_service.dart';
import 'package:invelop/utils/custom_date_utils.dart';
import 'package:invelop/theme/invelop_colors.dart';
import 'package:invelop/widgets/custom_fab/custom_fab_widget.dart';
import 'package:invelop/widgets/menuDrawer/menuDrawer_widget.dart';
import 'package:invelop/widgets/transactions/no_accounts.dart';
import 'package:invelop/widgets/transactions/no_transactions.dart';
import 'package:invelop/widgets/transactions/transaction_modal.dart';
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

    updateUserData() async {
      final userService = UserService();
      await userService.fetchUserAccountsAndTransactions(context);
    }

    if (transactions != null && transactions.isNotEmpty) {
      transactions.toList().sort((a, b) => b.date.compareTo(a.date));
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
                    return TransactionModal(accounts: accounts);
                  },
                ).then((_) {
                  updateUserData();
                });
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
