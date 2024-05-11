import 'package:flutter/material.dart';
import 'package:invelop/theme/invelop_colors.dart';
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
    DropdownItem("geen", "green"),
    DropdownItem("yellow", "yellow"),
    DropdownItem("blue", "blue"),
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
                    SelectField(items: items, onChanged: (value) => print(value.value)),
                    const SizedBox(height: 32),
                    const InputFieldWidget(
                      label: "Valor inicial",
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
