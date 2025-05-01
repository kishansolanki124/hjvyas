import 'package:flutter/material.dart';
import 'package:hjvyas/splash/splash.dart';
import 'package:lottie/lottie.dart';

class PaymentSuccessPage extends StatefulWidget {
  const PaymentSuccessPage({super.key});

  @override
  _PaymentSuccessPageState createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage>
    with SingleTickerProviderStateMixin {
  // Animation controller for the check animation.
  late AnimationController _animationController;

  // Initialize the animation controller.
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Adjust the duration as needed
    );

    // Start the animation.  It will play once and stop.
    _animationController.forward();
  }

  // Dispose the animation controller to prevent memory leaks.
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 50), // Dark blue background
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Use Lottie animation for the checkmark.
              Lottie.asset(
                'assets/check_animation.json', // Replace with your animation file
                controller: _animationController,
                onLoaded: (composition) {
                  // You can get the duration of the animation here if needed.
                  // print("Animation duration: ${composition.duration}");
                },
                width: 200, // Adjust size as needed
                height: 200,
                repeat: false, // Ensure it plays only once.  0 for no repeat, -1 for infinite
                // Add autoPlay: true if you want it to start automatically without controller.forward()
              ),
              const SizedBox(height: 20),
              const Text(
                'Thank you for your purchase!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Your payment was successful.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the home page (replace with your actual navigation logic)
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>
                      SplashScreen(), // Replace with your HomePage widget
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // White button
                  foregroundColor:
                  const Color.fromARGB(255, 0, 0, 50), // Dark blue text
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        8), // Add some rounding to the button
                  ),
                ),
                child: const Text(
                  'Go to Homepage',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
