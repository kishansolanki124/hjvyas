import 'dart:async';

import 'package:flutter/material.dart';

import '../home/home.dart';

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
    Timer(Duration(seconds: 3), () {
      // Navigate to the home page after 3 seconds
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
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

// class SplashPage extends StatefulWidget {
//   const SplashPage({super.key});
//
//   @override
//   State<SplashPage> createState() => _SplashPageState();
// }
//
// class _SplashPageState extends State<SplashPage> {
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       // appBar: AppBar(
//       //   // TRY THIS: Try changing the color here to a specific color (to
//       //   // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//       //   // change color while the other colors stay the same.
//       //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//       //   // Here we take the value from the SplashPage object that was created by
//       //   // the App.build method, and use it to set our appbar title.
//       //   title: Text(""),
//       // ),
//       body: Container(
//         child: Image.asset("images/bg.jpg"),
//       ),
//       );
//   }
// }

//
// class BackgroundImageWithLogo extends StatelessWidget {
//   final String backgroundImagePath;
//   final String logoImagePath;
//   final double logoWidth; // Optional: Specify logo width
//   final double logoHeight; // Optional: Specify logo height
//
//   BackgroundImageWithLogo({
//     required this.backgroundImagePath,
//     required this.logoImagePath,
//     this.logoWidth = 150.0, // Default logo width
//     this.logoHeight = 150.0, // Default logo height
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       fit: StackFit.expand, // Ensures the background image fills the screen
//       children: <Widget>[
//         // Background Image
//         Image.asset(
//           backgroundImagePath,
//           fit: BoxFit.cover, // Cover the entire screen
//         ),
//
//         // Centered Logo
//         Center(
//           child: Image.asset(
//             logoImagePath,
//             width: logoWidth,
//             height: logoHeight,
//           ),
//         ),
//       ],
//     );
//   }
// }
