import 'package:flutter/material.dart';

Widget formsInput({
  required BuildContext ctx,
  required String description,
  required TextEditingController textController,
  required double sizeWidth,
  required double sizeHeight,
}) {
  Size size = MediaQuery.of(ctx).size;
  return Container(
    margin: const EdgeInsets.only(bottom: 20),
    padding: const EdgeInsets.all(8),
    width: size.width * sizeWidth,
    height: size.height * sizeHeight,
    decoration: BoxDecoration(
        color: Colors.grey[200], borderRadius: BorderRadius.circular(12)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        description,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      TextFormField(
          controller: textController,
          decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)))))
    ]),
  );
}
