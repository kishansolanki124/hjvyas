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

  void showAlert() {
    setState(() {
      showNoInternetDialog();
    });
  }

  void showNoInternetDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Color.fromARGB(255, 31, 47, 80),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '"No Internet Connection',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Unable to connect to the network. Please check your connection and try again.',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Montserrat",
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 123, 138, 195),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 12.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Retry',
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    _initPrefs(); // Initialize shared preferences in initState

    _dataFuture = fetchData(); // Initialize once

    // Configure the animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
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

  // void startTimer() {
  //   //Start a timer that runs for 3 seconds
  //   Timer(Duration(seconds: 1), () {
  //     // Navigate to the home page after 3 seconds
  //     Navigator.of(
  //       context,
  //       //).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
  //     ).pushReplacement(
  //       MaterialPageRoute(builder: (context) => NavigationBarApp()),
  //     );
  //   });
  // }

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
          if (snapshot.error.toString() == 'No internet connection') {
            //showAlert();
            return NoInternetScreen(
              onRetry: () {
                _refreshData();
                //widget._userRepo.logo();
              },
            );
            //return Center(child: Text('Error: Internt issue vhala'));//todo
          } else {
            return Center(child: Text('Error: ${snapshot.error}')); //todo
          }
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
