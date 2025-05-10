import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hjvyas/splash/NoIntternetScreen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/models/LogoResponse.dart';
import '../api/services/HJVyasApiService.dart';
import '../home/navigation.dart';
import '../injection_container.dart';
import '../product_detail/ImageWithProgress.dart';
import '../repositories/HJVyasRepository.dart';

class SplashScreen extends StatefulWidget {
  final HJVyasRepository _userRepo = HJVyasRepository(
    getIt<HJVyasApiService>(),
  );

  SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Future<LogoResponse?> _dataFuture;

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  // Instance of SharedPreferences
  late SharedPreferences _prefs;

  // Initialize SharedPreferences
  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  startAnimation(String imageUrl) {
    _animationController.forward();

    // Preload the image in the background
    ImageWithProgress(imageURL: imageUrl);
  }

  @override
  void initState() {
    super.initState();

    _initPrefs(); // Initialize shared preferences in initState

    _dataFuture = fetchData(); // Initialize once

    // Configure the animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 1,
      ), //todo: change this to 2 before release
    );

    // Create a scale animation that starts small and ends larger
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    // Create an opacity animation
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    // Navigate to the home screen after animation completes
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Add a short delay after animation completes before navigating
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const NavigationBarApp()),
            );
          }
        });
      }
    });
  }

  Future<LogoResponse?> fetchData() async {
    return await widget._userRepo.logo();
  }

  // Method to refresh data
  void _refreshData() {
    setState(() {
      _dataFuture = fetchData(); // Create new Future when needed
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _saveString(String value) async {
    await _prefs.setString("logo", value);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LogoResponse?>(
      //future: widget._userRepo.logo(),
      future: _dataFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          startAnimation(snapshot.data!.logoList.elementAt(0).image);

          _saveString(snapshot.data!.logoList.elementAt(0).image);
          return splashScreenWidget(
            _animationController,
            _opacityAnimation,
            _scaleAnimation,
            snapshot.data!.logoList.elementAt(0).image,
          );
        } else if (snapshot.hasError) {
          return NoInternetScreen(
            onRetry: () {
              _refreshData();
            },
          );

          // if (snapshot.error.toString() == 'No internet connection') {
          //   return NoInternetScreen(
          //     onRetry: () {
          //       _refreshData();
          //     },
          //   );
          // } else {
          //   return Center(child: Text('Error: ${snapshot.error}'));
          // }
        }

        //return Center(child: CircularProgressIndicator());
        return splashScreenWidget(
          _animationController,
          _opacityAnimation,
          _scaleAnimation,
          "",
        );
      },
    );
  }
}

Widget splashScreenWidget(
  animationController,
  opacityAnimation,
  scaleAnimation,
  String imageUrl,
) {
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
          child: AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              return Opacity(
                opacity: opacityAnimation.value,
                child: Transform.scale(
                  scale: scaleAnimation.value,
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: ImageWithProgress(imageURL: imageUrl),
                  ),
                ),
              );
            },
          ),
        ),
    ],
  );
}
