import 'package:flutter/material.dart';
import 'package:invelop/theme/invelop_colors.dart';

class CustomFabWidget extends StatelessWidget {
  final List<PopupMenuItem<int>> menuItems;
  final Function(int) onItemSelected;

  const CustomFabWidget(
      {super.key, required this.menuItems, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        final RenderBox renderBox = context.findRenderObject() as RenderBox;
        final size = renderBox.size;
        final offset = renderBox.localToGlobal(Offset.zero);
        showMenu(
          color: Color(InVelopColors.primary.value),
          context: context,
          position: RelativeRect.fromLTRB(
            offset.dx,
            offset.dy + size.height,
            offset.dx + size.width,
            offset.dy,
          ),
          items: menuItems,
        ).then((value) {
          if (value != null) {
            onItemSelected(value);
          }
        });
      },
      backgroundColor: Colors.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: const Icon(Icons.add, color: InVelopColors.text),
    );
  }
}
