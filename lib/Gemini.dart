import 'package:flutter/material.dart';
import 'dart:math' as math;

class UniqueEmptyCart extends StatefulWidget {
  const UniqueEmptyCart({super.key});

  @override
  State<UniqueEmptyCart> createState() => _UniqueEmptyCartState();
}

class _UniqueEmptyCartState extends State<UniqueEmptyCart>
    with SingleTickerProviderStateMixin {
  late final AnimationController _bounceController = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<double> _bounceAnimation = Tween<double>(
    begin: 0,
    end: 1,
  ).animate(CurvedAnimation(
    parent: _bounceController,
    curve: Curves.elasticOut,
  ));

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 47, 80),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _bounceController,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, -30 * _bounceAnimation.value),
                    child: Transform.rotate(
                      angle: 0.1 * math.sin(_bounceController.value * math.pi * 2),
                      child: child,
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color.fromARGB(255, 123, 138, 195),
                        Colors.white.withOpacity(0.7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(25),
                  child: const Icon(
                    Icons.shopping_bag_outlined,
                    size: 70,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Hungry for Shopping?',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                child: Text(
                  'Your cart is waiting to be filled with amazing products. '
                      'Let\'s find something you\'ll love!',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              FilledButton.tonal(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 123, 138, 195),
                  foregroundColor: Colors.white,
                  shape: StadiumBorder(),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 36, vertical: 16),
                ),
                child: const Text('Explore Products'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}