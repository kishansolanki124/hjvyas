import 'package:flutter/material.dart';

import '../api/models/ProductDetailResponse.dart';
import '../utils/AppColors.dart';
import '../utils/CommonAppProgress.dart';

Widget addToCartFullWidthButton(double price, _onPressed, String cartText) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    // Optional horizontal padding
    child: SizedBox(
      width: double.infinity, // Makes the button full width
      child: ElevatedButton(
        onPressed: _onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.semiTransWhite,
          // Semi-transparent white
          padding: EdgeInsets.symmetric(vertical: 12.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0), // Rounded corners
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '₹ ${getTwoDecimalPrice(price)}',
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: "Montserrat",
                  color: Colors.black,
                ),
              ),
              Row(
                children: <Widget>[
                  Image.asset(height: 30, width: 30, 'icons/cart_icon.png'),
                  SizedBox(width: 8.0),
                  Text(
                    cartText,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: "Montserrat",
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget proceedToCheckOutButtonFullWidth(proceedToCheckOutClicked) {
  return SizedBox(
      width: double.infinity, // Makes the button full width
      child: ElevatedButton(
        onPressed: proceedToCheckOutClicked,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.semiTransWhite,
          // Semi-transparent white
          padding: EdgeInsets.symmetric(vertical: 12.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0), // Rounded corners
          ),
        ),
        child: Text("Proceed to Checkout",
          style: TextStyle(
            fontSize: 18.0,
            fontFamily: "Montserrat",
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),),
      ),

  );
}
