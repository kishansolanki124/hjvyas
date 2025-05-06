import 'package:flutter/material.dart';

import '../api/models/CartItemModel.dart';
import '../api/models/ProductCartResponse.dart';
import '../product_detail/NetworkImageWithLoading.dart';

class CartItemWidget extends StatefulWidget {
  int index;
  ProductCartListItem cartItem;
  CartItemModel cartItemModel;
  Function(String) formatPrice;
  Function(int) decrementCount;
  Function(int) incrementCount;
  Function(int) removeItem;

  CartItemWidget({
    required this.index,
    required this.cartItem,
    required this.cartItemModel,
    required this.formatPrice,
    required this.decrementCount,
    required this.incrementCount,
    required this.removeItem,
  });

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                width: 180,
                height: 180,
                child: NetworkImageWithLoading(
                  imageUrl: widget.cartItem.productImage,
                ),
              ),
            ],
          ),

          //box border sky blue
          Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(8, 8, 4, 8),
              height: 170,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(255, 123, 138, 195),
                  width: 1,
                ),
                borderRadius: BorderRadius.all(Radius.circular(0)),
              ),
            ),
          ),

          //right side portion of item
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // 1. Fixed Width and Height Image
              SizedBox(width: 180, height: 180),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    // 2. Product Title
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Text(
                        widget.cartItem.productName,
                        textAlign: TextAlign.right,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          backgroundColor: Color.fromARGB(255, 31, 47, 80),
                          fontSize: 14.0,
                          fontFamily: "Montserrat",
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    // 3. Price per Weight
                    Text(
                      '${widget.formatPrice(widget.cartItem.packingPrice)} (${widget.cartItem.packingWeight})',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        backgroundColor: Color.fromARGB(255, 31, 47, 80),
                        fontSize: 12.0,
                        fontFamily: "Montserrat",
                        color: Colors.white,
                      ),
                    ),

                    // 4. "+" and "-" Buttons with Count
                    Wrap(
                      children: [
                        ColoredBox(
                          color: Color.fromARGB(255, 31, 47, 80),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 6),
                            child: Container(
                              height: 30,
                              width: 120,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromARGB(255, 123, 138, 195),
                                ),
                                borderRadius: BorderRadius.circular(0),
                                color: Color.fromARGB(
                                  255,
                                  31,
                                  47,
                                  80,
                                ), // Background color
                              ),
                              // Add some padding inside the border
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  IconButton(
                                    iconSize: 16,
                                    icon: Icon(Icons.remove),
                                    color: Colors.white,
                                    onPressed:
                                        () =>
                                            widget.decrementCount(widget.index),
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
                                      widget.cartItemModel.quantity,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontFamily: "Montserrat",
                                      ),
                                    ),
                                  ),

                                  IconButton(
                                    iconSize: 16,
                                    icon: Icon(Icons.add),
                                    color: Colors.white,
                                    onPressed:
                                        () =>
                                            widget.incrementCount(widget.index),
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                          child: Text(
                            '${widget.formatPrice((double.parse(widget.cartItem.packingPrice) * double.parse(widget.cartItemModel.quantity)).toString())}',
                            style: TextStyle(
                              fontSize: 14.0,
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
                          onPressed: () => widget.removeItem(widget.index),
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
        ],
      ),
    );
  }
}
