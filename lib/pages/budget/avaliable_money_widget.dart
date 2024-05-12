import 'package:flutter/material.dart';

Widget avaliableMoney() {
  return Container(
      margin: const EdgeInsets.only(bottom: 20),
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.green,
        ),
        child: const Padding(
          padding: EdgeInsets.only(top: 5, bottom: 5, left: 40, right: 40),
          child: Column(
            children: [
              Text('Valor disponível',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              Text('R\$5000.00',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ],
          ),
        ),
      ));
}