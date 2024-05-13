import 'package:flutter/material.dart';
import 'package:invelop/theme/invelop_colors.dart';
import 'package:invelop/widgets/menuDrawer/menuDrawer_widget.dart';

class NoTransactionsWidget extends StatelessWidget {
  const NoTransactionsWidget({super.key});

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
      body: const Center(
        child: Text(
          'Nenhuma transação encontrada',
          style: TextStyle(color: InVelopColors.text),
        ),
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
                          child: Text("Adicionar transação",
                              style: TextStyle(color: InVelopColors.text))),
                      const PopupMenuItem(
                          value: 2,
                          child: Text("Option 2",
                              style: TextStyle(color: InVelopColors.text))),
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
