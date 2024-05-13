import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget account(String title, double? balance) {
  final formatter = NumberFormat("#,##0.00", "pt_BR");
  String balanceText = "R\$ ${formatter.format(balance! / 100)}";

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: const Color.fromARGB(31, 255, 255, 255),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          balanceText,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}
