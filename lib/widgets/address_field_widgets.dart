import 'package:flutter/material.dart';

Widget AddressField(
    {required String description, required String addressField}) {
  return Container(
    height: 75,
    child: Column(
      children: [
        Text(
          description,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(addressField)
      ],
    ),
  );
}
