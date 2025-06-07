import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/AppColors.dart'; // Import url_launcher

class AppUpdateBottomSheet extends StatelessWidget {
  final String updateUrl;

  const AppUpdateBottomSheet({super.key, required this.updateUrl});

  void _launchURL(BuildContext context) async {
    if (await canLaunchUrl(Uri.parse(updateUrl))) {
      await launchUrl(
        Uri.parse(updateUrl),
        mode: LaunchMode.externalApplication,
      );

      // After launching, dismiss the bottom sheet
      // Check if the widget is still mounted before popping
      if (context.mounted) {
        Navigator.pop(context);
      }
    } else {
      // Handle the error, e.g., show a toast
      if (kDebugMode) {
        print('Could not launch $updateUrl');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Make the column take minimum space
          children: <Widget>[
            // Title
            const Text(
              "Update Available!",
              style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            // Image with rocket icon
            Image.asset('icons/ic_update.png', height: 100, width: 100),
            // const Icon(
            //   Icons.rocket_launch,
            //   // Or a custom image asset: Image.asset('assets/rocket_icon.png', height: 80)
            //   size: 80,
            //   color: AppColors.secondary,
            // ),
            const SizedBox(height: 24),
            // Description text
            const Text(
              "A new version of app is available. Please update to the latest version.",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Montserrat",
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            // Update Now button
            SizedBox(
              width: double.infinity, // Full width
              child: ElevatedButton(
                onPressed: () {
                  _launchURL(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.background,
                  //use constant color
                  minimumSize: const Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  elevation: 5,
                ),
                child: const Text(
                  'Update Now',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Some space at the bottom for safety
          ],
        ),
      ),
    );
  }
}
