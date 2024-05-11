import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invelop/theme/invelop_colors.dart';
import 'package:invelop/utils/CurrencyFormat.dart';
import 'package:invelop/widgets/button/button_widget.dart';
import 'package:invelop/widgets/inputField/inputField_widget.dart';
import 'package:invelop/widgets/menuDrawer/menuDrawer_widget.dart';
import 'package:invelop/widgets/selectField/selectField_widget.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _form = GlobalKey<FormState>();
  final List<DropdownItem> items = [
    DropdownItem("Cartão de crédito", "credit_card"),
    DropdownItem("Cartão de débito", "debit_card"),
    DropdownItem("Dinheiro", "money"),
    DropdownItem("Conta poupança", "savings_account"),
    DropdownItem("Conta corrente", "current_account"),
    DropdownItem("Corretora de valores", "stock_brokerage"),
  ];

  save() {
    print("Salve");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cadastrar contas',
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
                    const InputFieldWidget(
                      label: "Nome",
                    ),
                    const SizedBox(height: 32),
                    SelectField(
                        items: items, onChanged: (value) => print(value.value)),
                    const SizedBox(height: 32),
                    InputFieldWidget(
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
                ))),
      ),
    );
  }
}
