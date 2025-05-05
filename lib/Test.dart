import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Carousel Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CarouselDemo(),
    );
  }
}

class CarouselDemo extends StatefulWidget {
  const CarouselDemo({Key? key}) : super(key: key);

  @override
  State<CarouselDemo> createState() => _CarouselDemoState();
}

class _CarouselDemoState extends State<CarouselDemo> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  final List<String> imageList = [
    'https://via.placeholder.com/350x200/FF5733/FFFFFF?text=Image+1',
    'https://via.placeholder.com/350x200/33FF57/FFFFFF?text=Image+2',
    'https://via.placeholder.com/350x200/5733FF/FFFFFF?text=Image+3',
    'https://via.placeholder.com/350x200/33B5FF/FFFFFF?text=Image+4',
  ];

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // Animation starts completely off-screen (offset much larger than -1.0)
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, -3.0), // Much higher above the screen
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    // Ensure the animation starts after the widget is properly built and screen is displayed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(milliseconds: 600), () {
        if (mounted) {
          _animationController.forward();
        }
      });
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
      appBar: AppBar(
        title: const Text('Animated Carousel Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Carousel sliding in from top',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            // The carousel is wrapped in a SizedBox to maintain its space in the layout
            SizedBox(
              height: 200, // Match the CarouselSlider height
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // The animated carousel slides in from outside the screen
                  SlideTransition(
                    position: _slideAnimation,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 200.0,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        aspectRatio: 16/9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: const Duration(milliseconds: 800),
                        viewportFraction: 0.8,
                      ),
                      items: imageList.map((item) => Container(
                        margin: const EdgeInsets.all(5.0),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                          child: Stack(
                            children: <Widget>[
                              Image.network(
                                item,
                                fit: BoxFit.cover,
                                width: 1000.0,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return const Center(child: CircularProgressIndicator());
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey[300],
                                    child: const Center(
                                      child: Text('Image not available',
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Positioned(
                                bottom: 0.0,
                                left: 0.0,
                                right: 0.0,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(200, 0, 0, 0),
                                        Color.fromARGB(0, 0, 0, 0)
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10.0,
                                    horizontal: 20.0,
                                  ),
                                  child: Text(
                                    'Item ${imageList.indexOf(item) + 1}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}