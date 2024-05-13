import 'package:flutter/material.dart';
import 'package:invelop/pages/account/create_account_page.dart';
import 'package:invelop/pages/budget/avaliable_money_widget.dart';
import 'package:invelop/pages/budget/budget_category_widget.dart';
import 'package:invelop/pages/budget/budget_item_widget.dart';
import 'package:invelop/pages/transactions/transactions.dart';
import 'package:invelop/services/account_types_service.dart';
import 'package:invelop/services/user_service.dart';
import 'package:invelop/theme/invelop_colors.dart';
import 'package:invelop/widgets/custom_fab/custom_fab_widget.dart';
import 'package:invelop/widgets/menuDrawer/menuDrawer_widget.dart';
import 'package:invelop/pages/budget/month_selector_widget.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  @override
  void initState() {
    super.initState();
    saveAccountTypes();
    updateUserData();
  }

  saveAccountTypes() async {
    final accountTypesService = AccountTypesService();
    await accountTypesService.fetchAccountTypes(context);
  }

  updateUserData() async {
    final userService = UserService();
    await userService.fetchUserAccountsAndTransactions(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Orçamento',
          style: TextStyle(color: InVelopColors.text),
        ),
        backgroundColor: InVelopColors.background,
        iconTheme: const IconThemeData(color: InVelopColors.light),
      ),
      drawer: const MenuDrawerWidget(),
      body: ListView(
        children: <Widget>[
          const MonthSelector(),
          avaliableMoney(),
          budgetCategory('🏠 Habitação', [
            budgetItem('Aluguel', 1500, 2500),
            budgetItem('Energia', 40, 250),
            budgetItem('Água', 60, -40),
          ]),
          budgetCategory('🍽️ Alimentação', [
            budgetItem('Mercado', 800, 1000),
            budgetItem('Restaurante', 302, -500),
            budgetItem('Lanches', 250, 1000),
          ]),
          budgetCategory('🚗 Transporte', [
            budgetItem('APP', 600, 1000),
            budgetItem('Ônibus', 200, 1000),
            budgetItem('Uber', 150, 1000),
          ]),
          budgetCategory('🎳 Lazer', [
            budgetItem('Cinema', 120, 1000),
            budgetItem('Bar', 300, -157),
            budgetItem('Viagem', 2549, 1000),
          ]),
          budgetCategory('📚 Educação', [
            budgetItem('Cursos', 600, 1000),
            budgetItem('Livros', 150, 1000),
            budgetItem('Material', 200, 1000),
          ]),
          budgetCategory('🧑🏼‍⚕️ Saúde', [
            budgetItem('Plano de saúde', 250, 1000),
            budgetItem('Remédios', 89, 1000),
            budgetItem('Consultas', 300, 1000),
          ]),
          budgetCategory('👕 Vestuário', [
            budgetItem('Roupas', 400, -1000),
            budgetItem('Calçados', 250, 1000),
            budgetItem('Acessórios', 152, 1000),
          ]),
          budgetCategory('💸 Investimentos', [
            budgetItem('Ações', 3000, 1000),
            budgetItem('Tesouro direto', 2000, 1000),
            budgetItem('Fundos', 500, 1000),
          ]),
          // Qualidade de vida
          budgetCategory('🧘🏼 Qualidade de vida', [
            budgetItem('Academia', 150, 1000),
            budgetItem('Terapia', 200, 1000),
            budgetItem('Viagens', 1200, 1000),
          ]),
          budgetCategory('🌍 Viagem', [
            budgetItem('Passagens', 6000, 1000),
            budgetItem('Hospedagem', 2000, 1000),
            budgetItem('Alimentação', 1000, 1000),
          ]),
        ],
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
              child: Text("Adicionar uma conta",
                  style: TextStyle(color: InVelopColors.text)),
            ),
          ],
          onItemSelected: (value) {
            if (value == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TransactionsPage()),
              );
            } else if (value == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreateAccountPage()),
              );
            }
          },
        ),
      ),
    );
  }
}
