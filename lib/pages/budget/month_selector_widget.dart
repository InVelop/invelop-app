import 'package:flutter/material.dart';

class MonthSelector extends StatefulWidget {
  const MonthSelector({super.key});

  @override
  MonthSelectorState createState() => MonthSelectorState();
}

class MonthSelectorState extends State<MonthSelector> {
  static const List<String> months = [
    'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
    'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'
  ];
  DateTime currentDate = DateTime.now();

  void _changeMonth(bool isNext) {
    setState(() {
      int newMonth = isNext ? currentDate.month % 12 + 1 : currentDate.month - 1;
      if (newMonth == 0) newMonth = 12;
      int newYear = currentDate.year;
      if (isNext && currentDate.month == 12) {
        newYear++;
      } else if (!isNext && currentDate.month == 1) {
        newYear--;
      }
      currentDate = DateTime(newYear, newMonth);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.arrow_left),
          onPressed: () => _changeMonth(false),
          iconSize: 40,
          color: Colors.white,
        ),
        const SizedBox(width: 20), // Espaço para manter os ícones afastados do texto
        Expanded(
          child: Text(
            '${months[currentDate.month - 1]} ${currentDate.year}',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        const SizedBox(width: 20), // Espaço para manter os ícones afastados do texto
        IconButton(
          icon: const Icon(Icons.arrow_right),
          onPressed: () => _changeMonth(true),
          iconSize: 40,
          color: Colors.white,
        ),
      ],
    );
  }
}
