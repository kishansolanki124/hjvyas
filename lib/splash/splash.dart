import 'dart:async';

import 'package:flutter/material.dart';

import '../home/navigation.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen();

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Start a timer that runs for 3 seconds
    Timer(Duration(seconds: 1), () {
      // Navigate to the home page after 3 seconds
      Navigator.of(
        context,
        //).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
      ).pushReplacement(
        MaterialPageRoute(builder: (context) => NavigationBarApp()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand, // Ensures the background image fills the screen
      children: <Widget>[
        // Background Image
        Image.asset(
          "images/bg.jpg",
          fit: BoxFit.cover, // Cover the entire screen
        ),

        // Centered Logo
        Center(child: Image.asset("images/logo.png", width: 200, height: 200)),
      ],
    );
  }
}
