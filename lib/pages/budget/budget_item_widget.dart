import 'package:flutter/material.dart';

Widget budgetItem(String name, double budgeted, double available) {
  // Criando o TextEditingController e inicializando com o valor de budgeted
  TextEditingController controller = TextEditingController(text: budgeted.toStringAsFixed(2));

  return Container(
    margin: const EdgeInsets.only(left: 10, right: 10, bottom: 8),
    padding: const EdgeInsets.only(left: 20, right: 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white12,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: controller,  // Usando o TextEditingController no TextField
                  style: const TextStyle(color: Colors.lightBlue),
                  decoration: InputDecoration(
                    prefixText: 'R\$ ',
                    hintText: budgeted.toStringAsFixed(2),
                    hintStyle: const TextStyle(color: Colors.lightBlue),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: available < 0 ? Colors.red : Colors.green,
              ),
              child: Text(
                'R\$${available.toStringAsFixed(2)}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
