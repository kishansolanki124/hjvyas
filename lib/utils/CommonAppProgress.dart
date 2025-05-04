import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget getCommonProgressBar() {
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
