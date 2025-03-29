import 'package:flutter/material.dart';

Widget homeImageItem(String url) {
  return Stack(
    fit: StackFit.expand, // Make the Stack fill the screen
    children: <Widget>[
      // Background Image
      Image.network(
        url,
        fit: BoxFit.cover, // Cover the entire screen
      ),

      // Text at Center Bottom
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Color.fromARGB(31, 0,0,0), Colors.transparent],
            ),
          ),
          child: Text(
            "Standard\nKachori",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ],
  );
  // return Image.network(
  //   url,
  //   fit: BoxFit.cover,
  //   height: double.infinity,
  //   width: double.infinity,
  //   alignment: Alignment.center,
  // );
}
