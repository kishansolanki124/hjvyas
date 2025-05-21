import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hjvyas/splash/AnimatedSplash.dart';
import 'package:hjvyas/utils/AppColors.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'injection_container.dart';
import 'notification/NotificationList.dart';

void main() {
  setupDependencies(); // Initialize GetIt
  runApp(const MyApp());

  // Enable verbose logging for debugging (remove in production)
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  // Initialize with your OneSignal App ID
  OneSignal.initialize("5ad91476-e571-4235-92ce-6a0453e16415");
  // Use this method to prompt for push notifications.
  // We recommend removing this method after testing and instead use In-App
  // Messages to prompt for notification permission.
  OneSignal.Notifications.requestPermission(false); //todo: change this to true
  // for permission

  // Handle notification click with navigation
  OneSignal.Notifications.addClickListener((OSNotificationClickEvent event) {
    if (kDebugMode) {
      print("Clicked notification: ${event.notification.title}");
    }

    navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (context) => NotificationList()),
    );
  });
}

// Global navigator key to access navigation from anywhere
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.background,
        statusBarIconBrightness:
            Brightness.light, // For dark icons, use Brightness.dark
      ),
    );

    return SafeArea(
      child: MaterialApp(
        navigatorKey: navigatorKey,
        // Set navigator key here
        debugShowCheckedModeBanner: false,
        // Remove the debug banner
        title: 'HJ Vyas App',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: AppColors.secondary, //cursor color
          ),
        ),
        //home: const MyHomePage(title: 'Flutter Demo Home Page'),
        //home: const SplashPage(),
        home: Scaffold(
          body: SplashScreenAnimation(
            // backgroundImagePath: 'images/bg.jpg', // Replace with your background image path
            // logoImagePath: 'images/logo.png', // Replace with your logo image path
            // logoWidth: 200, // Optional: customize the logo size
            // logoHeight: 200,
          ),
        ),
      ),
    );
  }
}
