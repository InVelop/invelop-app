import 'package:flutter/material.dart';
import 'package:invelop/theme/invelop_colors.dart';

class SelectField extends StatefulWidget {
  final List<DropdownItem> items;
  final Function(DropdownItem) onChanged;

  const SelectField({super.key, required this.items, required this.onChanged });

  @override
  State<SelectField> createState() => _SelectFieldState();
}

class _SelectFieldState extends State<SelectField> {
  late DropdownItem currentChoice;

  @override
  void initState() {
    currentChoice = widget.items[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Tipo",
              style: TextStyle(color: InVelopColors.text, fontSize: 16),
            ),
            DropdownButton(
              isExpanded: true,
              style: const TextStyle(color: InVelopColors.text),
              value: currentChoice,
              underline: Container(
                height: 1,
                color: InVelopColors.text,
              ),
              selectedItemBuilder: (BuildContext context) {
                return widget.items.map((DropdownItem item) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      item.label,
                      style: const TextStyle(color: InVelopColors.text),
                    ),
                  );
                }).toList();
              },
              items: widget.items
                  .map<DropdownMenuItem<DropdownItem>>(
                      (DropdownItem item) => DropdownMenuItem<DropdownItem>(
                            value: item,
                            child: Text(
                              item.label,
                              style: const TextStyle(color: InVelopColors.dark),
                            ),
                          ))
                  .toList(),
              onChanged: (DropdownItem? value) => {
                setState(() => currentChoice = value!),
                widget.onChanged(value!)
              },
            ),
          ],
        ));
  }
}

class DropdownItem {
  DropdownItem(this.label, this.value);
  final String label;
  final String value;
}
