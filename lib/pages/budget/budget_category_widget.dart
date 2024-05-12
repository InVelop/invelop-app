import 'package:flutter/material.dart';

Widget budgetCategory(String title, List<Widget> items) {
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
          children: items,
        ),
      ],
    );
  }