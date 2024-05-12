import 'package:flutter/material.dart';
import 'package:invelop/utils/custom_date_utils.dart';
import 'package:invelop/theme/invelop_colors.dart';
import 'package:invelop/widgets/menuDrawer/menuDrawer_widget.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  static const whiteFont = TextStyle(color: InVelopColors.text);

  List<Transaction> transactions = [
    Transaction(
      date: DateTime.now(),
      name: 'Shell-Box',
      category: 'Combustível',
      type: 'outcome',
      amount: -250.00,
    ),
    Transaction(
      date: DateTime.now(),
      name: 'Dona Florinda Rest',
      category: 'Restaurante',
      type: 'outcome',
      amount: -1250.00,
    ),
    Transaction(
      date: DateTime.now(),
      name: 'Baratie West Blue',
      category: 'Restaurante',
      type: 'outcome',
      amount: -1250.00,
    ),
    Transaction(
      date: DateTime.now(),
      name: 'Pix Joaquim',
      category: 'Receita',
      type: 'income',
      amount: 290.00,
    ),
    Transaction(
      date: DateTime.now(),
      name: 'Salário',
      category: 'Receita',
      type: 'income',
      amount: 18750.00,
    ),
    Transaction(
      date: DateTime.now().subtract(Duration(days: 1)),
      name: 'Shell-Box',
      category: 'Combustível',
      type: 'outcome',
      amount: -50.00,
    ),
    Transaction(
      date: DateTime.now().subtract(Duration(days: 1)),
      name: 'Macaule Food',
      category: 'Restaurante',
      type: 'outcome',
      amount: -125.30,
    ),
    Transaction(
      date: DateTime.now().subtract(Duration(days: 1)),
      name: 'Baratie West Blue',
      category: 'Restaurante',
      type: 'outcome',
      amount: -240.70,
    ),
    Transaction(
      date: DateTime.now().subtract(Duration(days: 2)),
      name: 'Pix Joaquim',
      category: 'Receita',
      type: 'income',
      amount: 495.00,
    ),
    Transaction(
      date: DateTime.now().subtract(Duration(days: 2)),
      name: 'Netflix',
      category: 'Serviços',
      type: 'outcome',
      amount: -50.00,
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          final previousTransaction =
              index > 0 ? transactions[index - 1] : null;
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
      // Center the floating action button
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
                          child: Text("Adicionar transação", style: whiteFont)),
                      const PopupMenuItem(
                          value: 2, child: Text("Option 2", style: whiteFont)),
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

class Transaction {
  final DateTime date;
  final String name;
  final String category;
  final String type;
  final double amount;

  Transaction({
    required this.date,
    required this.name,
    required this.category,
    required this.type,
    required this.amount,
  });
}
