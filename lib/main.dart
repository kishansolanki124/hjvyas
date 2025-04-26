import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hjvyas/splash/splash.dart';

import 'injection_container.dart';

void main() {
  setupDependencies(); // Initialize GetIt
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 32, 47, 80),
        statusBarIconBrightness:
        Brightness.light, // For dark icons, use Brightness.dark
      ),
    );

    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Remove the debug banner
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
        ),
        //home: const MyHomePage(title: 'Flutter Demo Home Page'),
        //home: const SplashPage(),
        home: Scaffold(
          body: SplashScreen(
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
