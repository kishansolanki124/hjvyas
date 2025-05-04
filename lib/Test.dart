import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vertical PageView Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: VerticalPageViewDemo(),
    );
  }
}

class VerticalPageViewDemo extends StatefulWidget {
  @override
  _VerticalPageViewDemoState createState() => _VerticalPageViewDemoState();
}

class _VerticalPageViewDemoState extends State<VerticalPageViewDemo> with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  final int _totalPages = 5;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    // Initialize regular page controller for normal navigation after first animation
    _pageController = PageController();

    // Set up animation controller for initial entrance animation
    _animationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    // Create a slide transition from bottom (1.0) to position (0.0)
    _slideAnimation = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutQuart,
    ));

    // Start the entrance animation after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vertical PageView Demo'),
        actions: [
          // Button to reset the entrance animation
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _animationController.reset();
              _pageController.jumpToPage(0);
              setState(() {
                _currentPage = 0;
              });
              _animationController.forward();
            },
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          // When animation value is very close to 1.0, use the PageView directly
          // This prevents issues with gesture detection during animation
          if (_animationController.value > 0.99) {
            return PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              itemCount: _totalPages,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: _buildPage,
            );
          }

          // During initial animation, show the SlideTransition
          return SlideTransition(
            position: _slideAnimation,
            child: _buildPage(context, 0),
          );
        },
      ),
    );
  }

  // Method to build each page with custom transitions
  Widget _buildPage(BuildContext context, int index) {
    return Container(
      color: _getPageColor(index),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Page ${index + 1}',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Text(
              index == _totalPages - 1
                  ? 'You reached the bottom!'
                  : 'Swipe down to continue',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 40),
            // Page indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_totalPages, (i) =>
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: i == index ? Colors.white : Colors.white38,
                    ),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to get different colors for different pages
  Color _getPageColor(int index) {
    switch (index) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.green;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.purple;
      case 4:
        return Colors.red;
      default:
        return Colors.teal;
    }
  }
}