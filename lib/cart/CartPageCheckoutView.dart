import 'package:flutter/material.dart';

import '../utils/AppColors.dart';
import '../utils/CommonAppProgress.dart';

class CartPageCheckoutView extends StatefulWidget {
  double cartTotal = 0;
  final VoidCallback? onPressed;

  CartPageCheckoutView({required this.cartTotal,
    required this.onPressed});

  @override
  _CartPageCheckoutViewState createState() => _CartPageCheckoutViewState();
}

class _CartPageCheckoutViewState extends State<CartPageCheckoutView>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            50,
          ), // Rounded corners for the container
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          // Make the Row wrap its content
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "₹ ${getTwoDecimalPrice(widget.cartTotal)}",
                style: const TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: AppColors.background,
                ),
              ),
            ),

            if (widget.cartTotal > 0) ...[
              // Add some space between price and button
              ElevatedButton(
                onPressed: () {
                  widget.onPressed!();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 36,
                    vertical: 16,
                  ),
                  // Padding for the button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      50,
                    ), // Rounded corners for the button
                  ),
                  visualDensity:
                      VisualDensity.compact, // Make button more compact
                ),
                child: const Text(
                  'Checkout',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
