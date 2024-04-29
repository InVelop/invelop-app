import 'package:flutter/material.dart';
import 'package:invelop/theme/invelop_colors.dart';

class InputFieldWidget extends StatefulWidget {
  final String? label;
  const InputFieldWidget({super.key, this.label});

  @override
  State<InputFieldWidget> createState() => _InputFieldWidgetState();
}

class _InputFieldWidgetState extends State<InputFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: const TextStyle(color: InVelopColors.light),
        floatingLabelStyle: const TextStyle(color: InVelopColors.light),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: InVelopColors.light),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: InVelopColors.light),
        ),
      ),
    );
  }
}
