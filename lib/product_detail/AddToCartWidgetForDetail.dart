import 'package:flutter/material.dart';

import '../utils/CommonAppProgress.dart';
import 'ProductDetailWidget.dart';

class AddToCartWidgetForDetail extends StatefulWidget {
  double productPrice;
  int selectedItemQuantity;
  final VoidCallback? onPressed;
  final VoidCallback? decrementQuantity;
  final VoidCallback? incrementQuantity;

  AddToCartWidgetForDetail({
    super.key,
    required this.productPrice,
    required this.selectedItemQuantity,
    required this.onPressed,
    required this.decrementQuantity,
    required this.incrementQuantity,
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

    print('selectedItemQuantity is ${widget.selectedItemQuantity}');
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

            if (widget.selectedItemQuantity > 0) ...[
              Container(
                width: 160,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 123, 138, 195),
                  borderRadius: BorderRadius.circular(
                    50,
                  ), // Rounded corners for the container
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: productDetailItemCounterNew(
                    widget.decrementQuantity,
                    widget.incrementQuantity,
                    widget.selectedItemQuantity,
                  ),
                ),
              ),
            ],

            if (widget.selectedItemQuantity == 0) ...[
              // Add some space between price and button
              Container(
                width: 160,
                child: ElevatedButton(
                  onPressed: () {
                    widget.onPressed!();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 123, 138, 195),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
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
                      fontSize: 15,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
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
