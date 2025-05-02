import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home/navigation.dart';

class PaymentSuccessPage extends StatefulWidget {
  const PaymentSuccessPage({super.key});

  @override
  State<PaymentSuccessPage> createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage>
    with TickerProviderStateMixin {
  bool _isDelayedAnimationPlaying = false;
  late AnimationController _animationController; // Combine controllers
  late Animation<double> _fadeAnimation;
  static const Color backgroundColor = Color.fromARGB(
    255,
    31,
    47,
    80,
  ); //constant color
  static const TextStyle titleTextStyle = TextStyle(
    //constant text style
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    fontFamily: "Montserrat",
  );
  static const TextStyle subtitleTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w500,
    fontFamily: "Montserrat",
    fontSize: 16,
  );

  void openHomePageAndClearPreviousPages() {
    Navigator.of(context).pushAndRemoveUntil(
      // Create the new route for the destination page.
      MaterialPageRoute(builder: (context) => const NavigationBarApp()),
      // A predicate that is always false removes all existing routes.
      (Route<dynamic> route) => false,
    );
  }

  // Instance of SharedPreferences
  late SharedPreferences _prefs;

  Future<void> clearSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.clear();
    print("SharedPreferences cleared!"); // Optional: Confirmation
  }

  @override
  void initState() {
    super.initState();
    clearSharedPreferences();

    // Start the timer in initState
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isDelayedAnimationPlaying = true;
      });
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800), // Use a single controller
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      //simplified
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    // Start animations in sequence
    Future.delayed(const Duration(milliseconds: 300), () {
      _animationController.forward(); // Start the animation
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor, //use constant color
      body: Center(
        child: LayoutBuilder(
          // Use LayoutBuilder to get the available width
          builder: (context, constraints) {
            final width = constraints.maxWidth; // Get the maximum width
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated checkmark
                if (_isDelayedAnimationPlaying)
                  SizedBox(
                    width: width, // Use the available width
                    height: width, // Make height equal to width (square)
                    child: Lottie.asset(
                      'assets/success_anime.json',
                      // Replace with your Lottie asset path
                      fit: BoxFit.contain,
                      // Or any other BoxFit as needed.  contain is usually best
                      repeat: false,
                    ),
                  ),

                if(!_isDelayedAnimationPlaying)
                  SizedBox(
                    width: width, // Use the available width
                    height: width, // Make height equal to width (square)
                    child: LoadingAnimationWidget.fourRotatingDots(
                      color: Colors.white,
                      size: 20,
                    ),
                  ),

                const SizedBox(height: 40),

                // Thank you text (with fade animation)
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      const Text(
                        'Payment Successful!',
                        style: titleTextStyle, //use constant text style
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Thank you for your purchase',
                        style: subtitleTextStyle, //use constant text style
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // Home button (with fade animation)
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: ElevatedButton(
                      onPressed: () {
                        openHomePageAndClearPreviousPages();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: backgroundColor,
                        //use constant color
                        minimumSize: const Size(200, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                      ),
                      child: const Text(
                        'Back to Home',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
