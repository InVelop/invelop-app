import 'package:flutter/material.dart';

Widget budgetHeader() {
  return const Column(
    children: [
      Padding(
        padding: EdgeInsets.only(right: 30, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              children: [
                Text("Orçado",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ],
            ),
            SizedBox(width: 25),
            Column(
              children: [
                Text("Disponível",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ],
            )
          ],
        ),
      )
    ],
  );
}
