import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../home/navigation.dart';
import '../product_detail/ProductDetailWidget.dart';
import '../utils/AppColors.dart';

class EmptyCart extends StatefulWidget {
  bool showBackButton = false;

  EmptyCart({super.key, this.showBackButton = false});

  @override
  State<EmptyCart> createState() => _EmptyCartState();
}

class _EmptyCartState extends State<EmptyCart>
    with SingleTickerProviderStateMixin {
  late final AnimationController _bounceController = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<double> _bounceAnimation = Tween<double>(
    begin: 0,
    end: 1,
  ).animate(
    CurvedAnimation(parent: _bounceController, curve: Curves.elasticOut),
  );

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  // Keep track of the selected option
  void _onBackPressed(BuildContext context) {
    Navigator.pop(context, "text");
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        Navigator.pop(context, "text");
        // Return false to prevent the default back button behavior
        // since we've already handled the navigation
        return;
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _bounceController,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, -30 * _bounceAnimation.value),
                          child: Transform.rotate(
                            angle:
                                0.1 *
                                math.sin(_bounceController.value * math.pi * 2),
                            child: child,
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.secondary,
                              //Colors.white.withOpacity(0.7),
                              Color.fromARGB(200, 255, 255, 255),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(25),
                        child: const Icon(
                          Icons.shopping_cart_rounded,
                          size: 70,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'Hungry for Shopping?',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontFamily: "Montserrat",
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 22,
                      ),
                      child: Text(
                        'Your cart is waiting to be filled with amazing products. '
                        'Let\'s find something you\'ll love!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Montserrat",
                          fontSize: 14,
                        ),
                      ),
                    ),

                    FilledButton.tonal(
                      onPressed: () {
                        if (widget.showBackButton) {
                          print('back button pressed');
                          Navigator.of(context).pop();
                        } else {
                          NavigationExample.of(context)?.navigateToMenuPage();
                        }
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.secondary,
                        foregroundColor: Colors.white,
                        shape: StadiumBorder(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 36,
                          vertical: 16,
                        ),
                      ),
                      child: const Text(
                        'Start Shopping',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              if (widget.showBackButton)
                backButton(() => _onBackPressed(context)),
            ],
          ),
        ),
      ),
    );
  }
}
