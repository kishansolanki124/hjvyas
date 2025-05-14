import 'package:flutter/material.dart';
import 'package:hjvyas/about/AboutWidgets.dart';

import '../utils/AppColors.dart';

Widget notificationDesc(String description) {
  return loadHTMLContent(description);
  // Text(
  //   description,
  //   style: TextStyle(
  //     fontFamily: "Montserrat",
  //     color: Colors.white,
  //     fontSize: 14.0, // Adjust as needed
  //   ),
  //   textAlign: TextAlign.justify, // Justify the text
  // );
}

Widget notificationTitle(String description) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Text(
      description,
      style: TextStyle(
        fontFamily: "Montserrat",
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 14.0, // Adjust as needed
      ),
      textAlign: TextAlign.justify, // Justify the text
    ),
  );
}

Widget dateOrTime(String dateOrTime) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Text(
      dateOrTime,
      style: TextStyle(
        fontFamily: "Montserrat",
        color: AppColors.secondary,
        fontSize: 14.0,
      ),
    ),
  );
}
