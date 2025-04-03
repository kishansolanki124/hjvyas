import 'package:flutter/material.dart';

Widget productListTitleWidget(String title, [Color? color]) {
  color ??= Colors.white;

  return Padding(
    padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 0),
    child: Text(
      '$title\n',
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: TextStyle(
        color: color,
        //color: Color.fromARGB(255, 255, 255, 254),
        fontSize: 18,
        fontFamily: "Montserrat",
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
