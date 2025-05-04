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

class _VerticalPageViewDemoState extends State<VerticalPageViewDemo>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  final int _totalPages = 5;
  int _currentPage = 0;
  bool _isFirstLoad = true;

  @override
  void initState() {
    super.initState();

    // Initialize page controller with viewportFraction set to 0.8
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);

    // Set up animation controller for animations
    _animationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    // Create a slide transition from bottom (1.0) to position (0.0)
    _slideAnimation = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutBack, // Using easeOutBack for bounce effect
      ),
    );

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

  // Trigger animation for page change
  void _animatePageChange(int page) {
    if (!_isFirstLoad) {
      // Reset the animation
      _animationController.reset();

      // Jump to the new page without animation
      _pageController.jumpToPage(page);

      // Start the animation
      _animationController.forward();
    }
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vertical PageView Demo'),
        actions: [
          // Button to reset the page and animation
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _isFirstLoad = true;
                _currentPage = 0;
              });
              _animationController.reset();
              _pageController.jumpToPage(0);
              _animationController.forward();

              // After initial animation completes, set isFirstLoad to false
              Future.delayed(Duration(milliseconds: 800), () {
                if (mounted) {
                  setState(() {
                    _isFirstLoad = false;
                  });
                }
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Main PageView with animation
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              // Check if animation completed on first load
              if (_isFirstLoad &&
                  _animationController.status == AnimationStatus.completed) {
                Future.delayed(Duration(milliseconds: 100), () {
                  if (mounted) {
                    setState(() {
                      _isFirstLoad = false;
                    });
                  }
                });
              }

              return PageView.builder(
                padEnds: false,
                scrollDirection: Axis.vertical,
                controller: _pageController,
                itemCount: _totalPages,
                physics:
                    _isFirstLoad
                        ? NeverScrollableScrollPhysics()
                        : CustomBouncePhysics(),
                onPageChanged: (index) {
                  if (!_isFirstLoad) {
                    _animatePageChange(index);
                  }
                },
                itemBuilder: (context, index) {
                  // Apply slide transition to each page
                  if (index == _currentPage) {
                    return SlideTransition(
                      position: _slideAnimation,
                      child: _buildPage(context, index),
                    );
                  } else {
                    return _buildPage(context, index);
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }

  // Method to build each page
  Widget _buildPage(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0),
      child: Container(
        decoration: BoxDecoration(
          color: _getPageColor(index),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
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
                style: TextStyle(fontSize: 18, color: Colors.white70),
              ),
              SizedBox(height: 40),
              // Page indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _totalPages,
                  (i) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: i == index ? Colors.white : Colors.white38,
                    ),
                  ),
                ),
              ),
            ],
          ),
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

// Custom scroll physics to create a pronounced bounce effect
class CustomBouncePhysics extends ScrollPhysics {
  const CustomBouncePhysics({ScrollPhysics? parent}) : super(parent: parent);

  @override
  CustomBouncePhysics applyTo(ScrollPhysics? ancestor) {
    return CustomBouncePhysics(parent: buildParent(ancestor));
  }

  @override
  SpringDescription get spring => SpringDescription(
    mass: 80, // Higher mass for more pronounced bounce
    stiffness: 100, // Lower stiffness for more elasticity
    damping: 1, // Lower damping for more oscillation
  );

  // Increase bounce distance
  @override
  double get minFlingVelocity => super.minFlingVelocity * 0.7;

  @override
  double get maxFlingVelocity => super.maxFlingVelocity * 1.5;

  // Create custom ballistic simulation with more pronounced bounce
  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    final Tolerance tolerance = this.tolerance;

    // If we're already at the edge but still receiving a user scroll
    if (position.outOfRange) {
      double direction = velocity.sign;

      // Create a more pronounced bounce effect
      return BouncingScrollSimulation(
        spring: spring,
        position: position.pixels,
        velocity: velocity * 0.9,
        // Slightly reduce velocity for control
        leadingExtent: position.minScrollExtent,
        trailingExtent: position.maxScrollExtent,
        tolerance: tolerance,
      );
    }

    // Let's make regular flings more bouncy too
    if (velocity.abs() > tolerance.velocity || position.outOfRange) {
      return BouncingScrollSimulation(
        spring: spring,
        position: position.pixels,
        velocity: velocity,
        leadingExtent: position.minScrollExtent,
        trailingExtent: position.maxScrollExtent,
        tolerance: tolerance,
      );
    }

    return null;
  }
}
