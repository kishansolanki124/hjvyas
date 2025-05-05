import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

Widget getCommonProgressBarFullScreen() {
  return Scaffold(
    body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/bg.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 150, // Use the available width
          height: 150, // Make height equal to width (square)
          child: Lottie.asset(
            'assets/happy_load.json', // Replace with your Lottie asset path
            fit: BoxFit.contain,
            // Or any other BoxFit as needed.  contain is usually best
            repeat: true,
          ),
        ),
      ),
    ),
  );
}

Widget getCommonProgressBar() {
  return Align(
    alignment: Alignment.topCenter,
    child: SizedBox(
      width: 150, // Use the available width
      height: 150, // Make height equal to width (square)
      child: Lottie.asset(
        'assets/happy_load.json', // Replace with your Lottie asset path
        fit: BoxFit.contain,
        // Or any other BoxFit as needed.  contain is usually best
        repeat: true,
      ),
    ),
  );
}

String getTwoDecimalPrice(double doublePrice) {
  String twoDecimalPrice = "";
  final NumberFormat formatter = NumberFormat("#.00");
  if (doublePrice != 0) {
    twoDecimalPrice = formatter.format(doublePrice);
    return twoDecimalPrice;
  }
  return "";
}
