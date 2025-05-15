import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/models/LogoResponse.dart';
import '../api/services/HJVyasApiService.dart';
import '../home/navigation.dart';
import '../injection_container.dart';
import '../repositories/HJVyasRepository.dart';
import 'NoIntternetScreen.dart';

class SplashScreenAnimation extends StatefulWidget {
  final HJVyasRepository _userRepo = HJVyasRepository(
    getIt<HJVyasApiService>(),
  );

  Widget nextScreen = NavigationBarApp();
  String appIconPath = "images/logo.png"; // Path to your app icon asset

  SplashScreenAnimation({
    super.key, // required this.nextScreen,
    // required this.appIconPath,
  });

  @override
  State<SplashScreenAnimation> createState() => _SplashScreenAnimationState();
}

class _SplashScreenAnimationState extends State<SplashScreenAnimation>
    with SingleTickerProviderStateMixin {
  late Future<LogoResponse?> _dataFuture;

  // Instance of SharedPreferences
  late SharedPreferences _prefs;

  // Initialize SharedPreferences
  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  late AnimationController _controller;
  late Animation<double> _radiusAnimation;
  late Animation<double> _iconAnimation;

  @override
  void initState() {
    super.initState();

    _initPrefs(); // Initialize shared preferences in initState

    _dataFuture = fetchData(); // Initialize once

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 6000), // Total animation duration
    );

    // Animation for the circular fill (starts after 0.5s, lasts 1s)
    _radiusAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.5, curve: Curves.easeInOut),
      ),
    );

    // Animation for the icon reveal (starts after 1.5s, lasts 1s)
    _iconAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.7, curve: Curves.easeInOut),
      ),
    );

    _controller.forward().then((_) {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => widget.nextScreen));
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

  Future<void> _saveString(String value) async {
    await _prefs.setString("logo", value);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LogoResponse?>(
      //future: widget._userRepo.logo(),
      future: _dataFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _saveString(snapshot.data!.logoList.elementAt(0).image);
        } else if (snapshot.hasError) {
          return NoInternetScreen(
            onRetry: () {
              _refreshData();
            },
          );
        }

        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              // Initial white screen is handled by Scaffold background

              // Circular fill animation
              Center(
                child: AnimatedBuilder(
                  animation: _radiusAnimation,
                  builder: (context, child) {
                    return ClipPath(
                      clipper: CircleRevealClipper(_radiusAnimation.value),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("images/bg.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        //color: const Color.fromARGB(255, 31, 47, 80),
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    );
                  },
                ),
              ),

              // App icon animation
              Center(
                child: AnimatedBuilder(
                  animation: _iconAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _iconAnimation.value,
                      child: Transform.scale(
                        scale: _iconAnimation.value,
                        child: Image.asset(
                          widget.appIconPath,
                          width: 120,
                          height: 120,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CircleRevealClipper extends CustomClipper<Path> {
  final double fraction;

  CircleRevealClipper(this.fraction);

  @override
  Path getClip(Size size) {
    final path = Path();
    final radius = fraction * (size.width + size.height);
    path.addOval(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: radius,
      ),
    );
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
