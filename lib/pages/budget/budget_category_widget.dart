import 'package:flutter/material.dart';

Widget budgetCategory(String title, List<Widget> subItems) {

  List<Widget> items = [
    const Column(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 40, bottom: 10, top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    Text("Orçado",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ],
                ),
                SizedBox(width: 35),
                Column(
                  children: [
                    Text("Disponível",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ],
                )
              ],
            ),
          )
        ],
      ),
  ];

  items.addAll(subItems);

  return Column(
    children: [
      ExpansionTile(
        title: Text(title,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        //backgroundColor: Colors.white,
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,
        initiallyExpanded: true,
        children: items
      ),
    ],
  );
}
