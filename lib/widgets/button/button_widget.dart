import 'package:flutter/material.dart';
import 'package:invelop/theme/invelop_colors.dart';

class ButtonWidget extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const ButtonWidget({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: const ButtonStyle(
          backgroundColor:
              MaterialStatePropertyAll<Color>(InVelopColors.primary)),
      child: Text(label, style: const TextStyle(color: InVelopColors.light)),
    );
  }
}
