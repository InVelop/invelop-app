import 'package:flutter/material.dart';
import 'package:invelop/models/transaction_model.dart';
import 'package:invelop/models/user_model.dart';
import 'package:invelop/pages/account/create_account_page.dart';
import 'package:invelop/utils/custom_date_utils.dart';
import 'package:invelop/theme/invelop_colors.dart';
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
  static const whiteFont = TextStyle(color: InVelopColors.text);

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

    print(uid);
    print(email);
    print(accounts);
    print(transactions);

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
                  trailing: Text(
                    '${transaction.type == 'income' ? '' : '-'} R\$ ${transaction.amount.abs().toStringAsFixed(2)}',
                    style: TextStyle(
                      color: transaction.type == 'income'
                          ? Colors.green
                          : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        floatingActionButton: Align(
          alignment: Alignment.bottomCenter,
          child: FractionallySizedBox(
            widthFactor: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {
                    final RenderBox renderBox =
                        context.findRenderObject() as RenderBox;
                    final size = renderBox.size;
                    final offset = renderBox.localToGlobal(Offset.zero);
                    showMenu(
                      color: Color(InVelopColors.primary.value),
                      context: context,
                      position: RelativeRect.fromLTRB(
                        offset.dx,
                        offset.dy + size.height + 100,
                        offset.dx + size.width,
                        offset.dy,
                      ),
                      items: [
                        const PopupMenuItem(
                            value: 1,
                            child:
                                Text("Adicionar transação", style: whiteFont)),
                        const PopupMenuItem(
                            value: 2,
                            child: Text("Option 2", style: whiteFont)),
                      ],
                    ).then((value) {
                      print("value: $value");
                    });
                  },
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(Icons.add, color: InVelopColors.text),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
