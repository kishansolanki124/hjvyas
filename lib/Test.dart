import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buzz Effect Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BuzzEffectDemo(),
    );
  }
}

class BuzzEffectDemo extends StatefulWidget {
  @override
  _BuzzEffectDemoState createState() => _BuzzEffectDemoState();
}

class _BuzzEffectDemoState extends State<BuzzEffectDemo>
    with TickerProviderStateMixin {
  late AnimationController _waveController;
  late AnimationController _buzzController;
  late Animation<double> _waveAnimation;
  late Animation<Offset> _buzzAnimation;

  final List<Color> _gradientColors = [
    Colors.red,
    Colors.redAccent,
    Colors.deepOrange,
  ];

  @override
  void initState() {
    super.initState();

    // Wave animation controller
    _waveController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    // Buzz animation controller (vibration effect)
    _buzzController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    _waveAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _waveController,
        curve: Curves.easeOut,
      ),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _waveController.reset();
      }
    });

    // Create a shaking/vibration effect
    _buzzAnimation = TweenSequence<Offset>(
      [
        TweenSequenceItem(
          tween: Tween<Offset>(begin: Offset.zero, end: Offset(-0.03, 0)),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: Tween<Offset>(begin: Offset(-0.03, 0), end: Offset(0.03, 0)),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: Tween<Offset>(begin: Offset(0.03, 0), end: Offset(-0.03, 0)),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: Tween<Offset>(begin: Offset(-0.03, 0), end: Offset.zero),
          weight: 1,
        ),
      ],
    ).animate(
      CurvedAnimation(
        parent: _buzzController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _waveController.dispose();
    _buzzController.dispose();
    super.dispose();
  }

  void _startAnimation() {
    // Reset and start both animations
    _waveController.reset();
    _buzzController.reset();
    _waveController.forward();
    _buzzController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Buzz Effect Demo')),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Wave effect
            AnimatedBuilder(
              animation: _waveAnimation,
              builder: (context, child) {
                return CustomPaint(
                  painter: WavePainter(
                    progress: _waveAnimation.value,
                    colors: _gradientColors,
                  ),
                  size: Size(200, 200),
                );
              },
            ),

            // Button with buzz effect
            AnimatedBuilder(
              animation: _buzzAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: _buzzAnimation.value * 20,
                  child: ElevatedButton(
                    onPressed: _startAnimation,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 8,
                    ),
                    child: Text(
                      'BUZZ ME!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  final double progress;
  final List<Color> colors;

  WavePainter({required this.progress, required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width / 2;
    final currentRadius = maxRadius * progress;

    // Create gradient
    final gradient = RadialGradient(
      colors: colors,
      stops: [0.0, 0.5, 1.0],
    );

    final paint = Paint()
      ..shader = gradient.createShader(
        Rect.fromCircle(center: center, radius: currentRadius),
      )
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    // Draw the filled circle with gradient
    canvas.drawCircle(center, currentRadius, paint);

    // Optional: Add a subtle border
    canvas.drawCircle(
      center,
      currentRadius,
      Paint()
        ..color = colors.first.withOpacity(0.8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0,
    );
  }

  @override
  bool shouldRepaint(covariant WavePainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.colors != colors;
  }
}