import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/models/LogoResponse.dart';
import '../api/services/HJVyasApiService.dart';
import '../home/navigation.dart';
import '../injection_container.dart';
import '../product_detail/ImageWithProgress.dart';
import '../repositories/HJVyasRepository.dart';

class SplashScreen extends StatefulWidget {
  final HJVyasRepository _userRepo = HJVyasRepository(getIt<HJVyasApiService>());

  SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // Instance of SharedPreferences
  late SharedPreferences _prefs;

  // Initialize SharedPreferences
  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }


  @override
  void initState() {
    super.initState();
    _initPrefs(); // Initialize shared preferences in initState
  }

  Future<void> _saveString(String value) async {
    await _prefs.setString("logo", value);
  }

  void startTimer() {
    //Start a timer that runs for 3 seconds
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
    return FutureBuilder<LogoResponse>(
      future: widget._userRepo.getUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          startTimer();
          _saveString(snapshot.data!.logoList.elementAt(0).image);
          return splashScreenWidget(snapshot.data!.logoList.elementAt(0).image);
        } else if (snapshot.hasError) {
          if (snapshot.error.toString() == 'No internet connection') {
            return Center(child: Text('Error: Internt issue vhala'));
          } else {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
        }
        //return Center(child: CircularProgressIndicator());
        return splashScreenWidget("");
      },
    );
  }
}

Widget splashScreenWidget(String imageUrl) {
  return Stack(
    fit: StackFit.expand, // Ensures the background image fills the screen
    children: <Widget>[
      // Background Image
      Image.asset(
        "images/bg.jpg",
        fit: BoxFit.cover, // Cover the entire screen
      ),

      if (imageUrl.isEmpty)
        Center(
          child: LoadingAnimationWidget.fourRotatingDots(
            color: Colors.white,
            size: 20,
          ),
        ),

      // Centered Logo
      if (imageUrl.isNotEmpty)
        Center(
          child: SizedBox(
            width: 200,
            height: 200,
            child: ImageWithProgress(imageURL: imageUrl),
          ),
          //Image.asset("images/logo.png", width: 200, height: 200)
        ),
    ],
  );
}
