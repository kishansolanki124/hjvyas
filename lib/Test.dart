import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Set system UI overlay style to match the dark theme
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return MaterialApp(
      title: 'App Splash Screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  // Replace this with your actual app icon URL
  final String appIconUrl = 'https://www.mithaiwalahjvyas.com/uploads/app_logo_img/1161-logo.png';

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  // Removed unnecessary state variables

  @override
  void initState() {
    super.initState();

    // Configure the animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    // Create a scale animation that starts small and ends larger
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutBack,
      ),
    );

    // Create an opacity animation
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    // Start the animation once the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();

      // Preload the image in the background
      precacheImage(NetworkImage(appIconUrl), context);
    });

    // Navigate to the home screen after animation completes
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Add a short delay after animation completes before navigating
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          }
        });
      }
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
      backgroundColor: const Color(0xFF0A1931), // Dark blue background
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Opacity(
              opacity: _opacityAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: _buildImageContainer(),
              ),
            );
          },
        ),
      ),
    );
  }

  // Removed the intermediate method to directly show the image with built-in loading handling

  Widget _buildImageContainer() {
    return Container(
      width: 180,
      height: 180,
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          appIconUrl,
          fit: BoxFit.contain,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                    : null,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            print('Error loading image: $error');
            return const Center(
              child: Icon(
                Icons.error_outline,
                color: Colors.white,
                size: 50,
              ),
            );
          },
        ),
      ),
    );
  }

// Removed unused helper methods since they're now integrated into _buildImageContainer()
}

// Placeholder for your main app screen
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1931),
      appBar: AppBar(
        title: const Text('Your App'),
        backgroundColor: const Color(0xFF0A1931),
        elevation: 0,
      ),
      body: const Center(
        child: Text(
          'Main App Content',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}