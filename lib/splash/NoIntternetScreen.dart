import 'package:flutter/material.dart';

import '../utils/AppColors.dart';

class NoInternetScreen extends StatelessWidget {
  final VoidCallback onRetry;
  bool showBackgroundImage = true;

  NoInternetScreen({
    super.key,
    this.showBackgroundImage = true,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    if (showBackgroundImage) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image:
                  showBackgroundImage
                      ? AssetImage("images/bg.jpg")
                      : AssetImage(""),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image
                    Image.asset(
                      'assets/no_connection.png', // Replace with your own asset
                      height: 180,
                      fit: BoxFit.contain,
                      // If you don't have an image, use this placeholder instead:
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.signal_wifi_off_rounded,
                          size: 120,
                          color: AppColors.secondary,
                        );
                      },
                    ),
                    const SizedBox(height: 32),

                    // Title
                    Text(
                      "No Internet Connection",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Montserrat",
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),

                    // Message
                    Text(
                      "Please check your network connection and try again.",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Montserrat",
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 48),

                    // Retry Button
                    ElevatedButton(
                      onPressed: onRetry,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondary,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(180, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        elevation: 0,
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.refresh),
                          SizedBox(width: 8),
                          Text(
                            "Retry",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image
            Image.asset(
              'assets/no_connection.png', // Replace with your own asset
              height: 180,
              fit: BoxFit.contain,
              // If you don't have an image, use this placeholder instead:
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.signal_wifi_off_rounded,
                  size: 120,
                  color: AppColors.secondary,
                );
              },
            ),
            const SizedBox(height: 32),

            // Title
            Text(
              "No Internet Connection",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                fontFamily: "Montserrat",
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // Message
            Text(
              "Please check your network connection and try again.",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Montserrat",
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),

            // Retry Button
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,
                foregroundColor: Colors.white,
                minimumSize: const Size(180, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 0,
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.refresh),
                  SizedBox(width: 8),
                  Text(
                    "Retry",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}
