import 'package:flutter/material.dart';
import 'package:invelop/theme/invelop_colors.dart';

class InputFieldWidget extends StatelessWidget {
  final String? label;
  final bool? obscureText;
  final bool? isRequired;
  final TextInputType inputType;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  const InputFieldWidget(
      {super.key,
      this.label,
      this.obscureText = false,
      this.inputType = TextInputType.text,
      this.controller,
      this.validator,
      this.isRequired = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: inputType,
      obscureText: obscureText! || inputType == TextInputType.visiblePassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      validator: (value) {
        if (isRequired! && (value == null || value.isEmpty)) {
          return "Campo obrigatório";
        } else if (validator != null) {
          return validator!(value);
        }
        return null;
      },
      style: const TextStyle(color: InVelopColors.text),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: InVelopColors.light),
        floatingLabelStyle: const TextStyle(color: InVelopColors.light),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: InVelopColors.light),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: InVelopColors.light),
        ),
        errorStyle: const TextStyle(
          color: InVelopColors.error,
          fontWeight: FontWeight.bold, // Estilo personalizado
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: InVelopColors.error),
        ),
      ),
    );
  }
}
