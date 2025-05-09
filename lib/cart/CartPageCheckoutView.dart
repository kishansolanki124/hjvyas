import 'package:flutter/material.dart';

class CartPageCheckoutView extends StatefulWidget {
  CartPageCheckoutView();

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
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          // Add a shadow for better visibility
          BoxShadow(
            color: Color.fromARGB(50, 0, 0, 0), // Shadow color
            blurRadius: 10.0, // Spread of the shadow
            offset: Offset(0, -3), // Offset to the top
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // Ensure the column takes up minimal space.
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // Stretch children horizontally.
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: const Text(
                      'Total Price:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black, // Set the color of the Total Price
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: const Text(
                      "₹ 500",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black, // Set the color of the Total Price
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            // Add some spacing
            ElevatedButton(
              onPressed: () {
                //todo: here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 123, 138, 195),
                // Button color
                padding: const EdgeInsets.symmetric(vertical: 15),
                // Add vertical padding
                shape: RoundedRectangleBorder(
                  // Apply rounded corners to the button
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: const Text(
                'Proceed to Checkout',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Montserrat",
                  color: Colors.white, // Text color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
