import 'package:flutter/material.dart';
import 'package:invelop/theme/invelop_colors.dart';
import 'package:invelop/widgets/menuDrawer/menuDrawer_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Envelopes',
          style: TextStyle(color: InVelopColors.text),
        ),
        backgroundColor: InVelopColors.background,
        iconTheme: const IconThemeData(color: InVelopColors.light),
      ),
      drawer: const MenuDrawerWidget(),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Text("Home",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: InVelopColors.text)),
        ),
      ),
    );
  }
}
