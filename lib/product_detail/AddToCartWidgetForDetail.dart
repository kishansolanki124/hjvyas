import 'package:flutter/material.dart';

import '../utils/CommonAppProgress.dart';

class AddToCartWidgetForDetail extends StatefulWidget {

  double productPrice;
  final VoidCallback? onPressed;

  AddToCartWidgetForDetail({
    super.key,
    required this.productPrice,
    required this.onPressed,
  });

  @override
  _AddToCartWidgetForDetailState createState() =>
      _AddToCartWidgetForDetailState();
}

class _AddToCartWidgetForDetailState extends State<AddToCartWidgetForDetail>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
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
                "₹ ${getTwoDecimalPrice(widget.productPrice)}",
                style: const TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Color.fromARGB(255, 31, 47, 80),
                ),
              ),
            ),

            // Add some space between price and button
            ElevatedButton(
              onPressed: () {
                widget.onPressed!();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 123, 138, 195),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
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
                'Add To Cart',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
