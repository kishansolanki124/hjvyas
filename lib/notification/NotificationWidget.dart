import 'package:flutter/material.dart';

Widget notificationDesc(String description) {
  return Text(
    description,
    style: TextStyle(
      fontFamily: "Montserrat",
      color: Colors.white,
      fontSize: 14.0, // Adjust as needed
    ),
    textAlign: TextAlign.justify, // Justify the text
  );
}

Widget dateOrTime(String dateOrTime) {
  return Text(
    dateOrTime,
    style: TextStyle(
      fontFamily: "Montserrat",
      color: Color.fromARGB(255, 123, 138, 195),
      fontSize: 14.0,
    ),
  );
}
