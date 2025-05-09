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
        //color: Colors.white,
        color: Color.fromARGB(255, 123, 138, 195),
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
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // Ensure the column takes up minimal space.
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // Stretch children horizontally.
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: const Text(
                      'Cart Total:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 31, 47, 80),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: const Text(
                      "₹ 500.00",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 31, 47, 80), // Set the color of the Total Price
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
                // Handle checkout action
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Proceeding to Checkout...'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 24), // Add horizontal padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                elevation: 2, // Add a small elevation
              ),
              child: const Text(
                'Proceed to Checkout',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Montserrat",
                  color: Color.fromARGB(255, 31, 47, 80),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
