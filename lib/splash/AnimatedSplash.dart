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

  late Animation<Offset> _fromTopSlideAnimation;
  late Animation<Offset> _fromBottomSlideAnimation;
  late Animation<Offset> _fromBottomSlideAnimation2;
  late Animation<Offset> _fromLeftSlideAnimation;
  late Animation<Offset> _fromRightSlideAnimation;

  static const double startTimeForSlide = 0.5;
  static const double endTimeForSlide = 0.7;

  @override
  void initState() {
    super.initState();

    _initPrefs(); // Initialize shared preferences in initState

    _dataFuture = fetchData(); // Initialize once

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 6000), // Total animation duration
    );

    // Animation starts completely off-screen (offset much larger than -1.0)
    _fromBottomSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Much higher above the screen
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          startTimeForSlide,
          endTimeForSlide,
          curve: Curves.easeOutQuart,
        ),
      ),
    );

    _fromBottomSlideAnimation2 = Tween<Offset>(
      begin: const Offset(0, 4), // Much higher above the screen
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          startTimeForSlide,
          endTimeForSlide,
          curve: Curves.easeOutQuart,
        ),
      ),
    );

    // Animation starts completely off-screen (offset much larger than -1.0)
    _fromLeftSlideAnimation = Tween<Offset>(
      begin: const Offset(-3.0, 0.0), // Start from far left, outside
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          startTimeForSlide,
          endTimeForSlide,
          curve: Curves.easeOutQuart,
        ),
      ),
    );

    // Animation starts completely off-screen (offset much larger than -1.0)
    _fromRightSlideAnimation = Tween<Offset>(
      begin: const Offset(3.0, 0.0), // Start from far right, outside
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          startTimeForSlide,
          endTimeForSlide,
          curve: Curves.easeOutQuart,
        ),
      ),
    );

    // Animation starts completely off-screen (offset much larger than -1.0)
    _fromTopSlideAnimation = Tween<Offset>(
      begin: const Offset(0.0, -3.0), // Much higher above the screen
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          startTimeForSlide,
          endTimeForSlide,
          curve: Curves.easeOutCubic,
        ),
      ),
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
                        // decoration: BoxDecoration(
                        //   image: DecorationImage(
                        //     image: AssetImage("images/bg.jpg"),
                        //     fit: BoxFit.cover,
                        //   ),
                        // ),
                        color: const Color.fromARGB(255, 31, 47, 80),
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    );
                  },
                ),
              ),

              //top left
              Align(
                alignment: AlignmentDirectional.topStart,
                child: SlideTransition(
                  position: _fromTopSlideAnimation,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 32, 0, 0),
                    child: Image.asset(
                      width: 151,
                      height: 112,
                      "images/bg_icon1.png",
                    ),
                  ),
                ),
              ),

              //top right
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: SlideTransition(
                  position: _fromTopSlideAnimation,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 75, 75, 0),
                    child: Image.asset(
                      width: 58,
                      height: 58,
                      "images/bg_icon2.png",
                    ),
                  ),
                ),
              ),

              // center below app icon
              Align(
                alignment: AlignmentDirectional.center,
                child: SlideTransition(
                  position: _fromBottomSlideAnimation2,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 250.0),
                    child: Image.asset(
                      width: 58,
                      height: 58,
                      "images/bg_icon2.png",
                    ),
                  ),
                ),
              ),

              //bottom center
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: SlideTransition(
                  position: _fromBottomSlideAnimation,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: Image.asset(
                      width: 169,
                      height: 106,
                      "images/bg_icon7.png",
                    ),
                  ),
                ),
              ),

              //left side item 1
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: SlideTransition(
                  position: _fromLeftSlideAnimation,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(32.0, 16, 16, 300),
                    child: Image.asset(
                      width: 141,
                      height: 117,
                      "images/bg_icon3.png",
                    ),
                  ),
                ),
              ),

              //left side item 2
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: SlideTransition(
                  position: _fromLeftSlideAnimation,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(40.0, 300, 16, 16),
                    child: Image.asset(
                      width: 73,
                      height: 172,
                      "images/bg_icon5.png",
                    ),
                  ),
                ),
              ),

              //right side item 1
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: SlideTransition(
                  position: _fromRightSlideAnimation,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 16, 32, 300),
                    child: Image.asset(
                      width: 130,
                      height: 118,
                      "images/bg_icon4.png",
                    ),
                  ),
                ),
              ),

              //right side item 2
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: SlideTransition(
                  position: _fromRightSlideAnimation,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 300, 32, 16),
                    child: Image.asset(
                      width: 73,
                      height: 133,
                      "images/bg_icon6.png",
                    ),
                  ),
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
                          width: 180,
                          height: 180,
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
