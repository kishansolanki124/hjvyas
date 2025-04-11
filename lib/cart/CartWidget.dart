import 'package:flutter/material.dart';
import 'package:hjvyas/product_detail/NetworkImageWithLoading.dart';

Widget CartItemWidget(
  index,
  cartItem,
  _formatPrice,
  _decrementCount,
  _incrementCount,
  _removeItem,
) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 8.0),
    child: Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // 1. Fixed Width and Height Image
            SizedBox(
              width: 200,
              height: 200,
              child: NetworkImageWithLoading(imageUrl: cartItem.imageUrl),
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  // 2. Product Title
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                    child: Text(
                      cartItem.title,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: "Montserrat",
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 2.0),
                  // 3. Price per Weight
                  Text(
                    '${_formatPrice(cartItem.pricePerKg)} (600 GM)',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: "Montserrat",
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  // 4. "+" and "-" Buttons with Count
                  Wrap(
                    children: [
                      Container(
                        height: 35,
                        width: 130,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromARGB(255, 123, 138, 195),
                          ),
                          borderRadius: BorderRadius.circular(0),
                          color: Colors.transparent, // Background color
                        ),
                        // Add some padding inside the border
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                              iconSize: 18,
                              icon: Icon(Icons.remove),
                              color: Colors.white,
                              onPressed: () => _decrementCount(index),
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                0,
                                0,
                                0,
                                0,
                              ),
                              child: Text(
                                cartItem.count.toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontFamily: "Montserrat",
                                ),
                              ),
                            ),

                            IconButton(
                              iconSize: 18,
                              icon: Icon(Icons.add),
                              color: Colors.white,
                              onPressed: () => _incrementCount(index),
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 4.0),
                  // 5. Total Price and Delete Icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                        child: Text(
                          '${_formatPrice(cartItem.totalPrice)}',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: "Montserrat",
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Image.asset(
                          "icons/delete_icon.png",
                          height: 24,
                          width: 24,
                        ),
                        onPressed: () => _removeItem(index),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),

        Center(
          child: Container(
            margin: EdgeInsets.fromLTRB(8, 8, 0, 8),
            height: 160,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromARGB(255, 123, 138, 195),
                width: 1,
              ),
              borderRadius: BorderRadius.all(Radius.circular(0)),
            ),
          ),
        ),
      ],
    ),
  );
}
