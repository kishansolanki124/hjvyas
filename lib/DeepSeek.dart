import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vertical PageView',
      home: VerticalPageViewScreen(),
    );
  }
}

class VerticalPageViewScreen extends StatefulWidget {
  @override
  _VerticalPageViewScreenState createState() => _VerticalPageViewScreenState();
}

class _VerticalPageViewScreenState extends State<VerticalPageViewScreen> {
  final PageController _pageController = PageController(
    viewportFraction: 0.8,
  );
  int _currentPage = 0;
  bool _initialAnimationDone = false;

  @override
  void initState() {
    super.initState();
    // Trigger initial animation after first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _runInitialAnimation();
    });
  }

  void _runInitialAnimation() async {
    // Start below the screen
    _pageController.position.jumpTo(-MediaQuery.of(context).size.height * 0.2);
    // Animate to first position
    await _pageController.animateTo(
      0,
      duration: Duration(milliseconds: 800),
      curve: Curves.easeOutQuart,
    );
    setState(() {
      _initialAnimationDone = true;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: 5,
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double value = 0.0;
                  if (_pageController.position.haveDimensions) {
                    value = index - _pageController.page!;
                    value = (value * 0.1).clamp(-1.0, 1.0);
                  }

                  // Initial animation state
                  if (!_initialAnimationDone && index == 0) {
                    return Transform.translate(
                      offset: Offset(0, MediaQuery.of(context).size.height * 0.2),
                      child: Opacity(
                        opacity: 0.5,
                        child: child,
                      ),
                    );
                  }

                  // Regular scroll animation
                  return Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..translate(0.0, -value * MediaQuery.of(context).size.height * 0.4)
                      ..scale(1.0 - value.abs() * 0.1),
                    alignment: Alignment.bottomCenter,
                    child: Opacity(
                      opacity: 1.0 - value.abs() * 0.5,
                      child: child,
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.primaries[index % Colors.primaries.length],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 20,
                        spreadRadius: 5,
                      )
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Page ${index + 1}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return Container(
                  width: 8,
                  height: 8,
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.5),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}