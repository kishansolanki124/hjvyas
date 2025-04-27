import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hjvyas/checkout/Checkout.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/models/CartItemModel.dart';
import '../api/models/ProductCartResponse.dart';
import '../api/services/HJVyasApiService.dart';
import '../injection_container.dart';
import '../product/ProductPaginationController.dart';
import '../product_detail/FullWidthButton.dart';
import 'CartWidget.dart';

class CartItem {
  String imageUrl;
  String title;
  double pricePerKg;
  int count;

  CartItem({
    required this.imageUrl,
    required this.title,
    required this.pricePerKg,
    this.count = 1,
  });

  double get totalPrice => pricePerKg * count;
}

class CartPage extends StatefulWidget {
  final ProductPaginationController paginationController =
      ProductPaginationController(getIt<HJVyasApiService>());

  CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartItemModel> _cartItemShaaredPrefList = [];
  List<ProductCartListItem>? _cartItems;
  int cartMaxQty = 0;

  // Instance of SharedPreferences
  late SharedPreferences _prefs;

  // Initialize SharedPreferences
  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Helper function to load the list from SharedPreferences
  Future<void> _loadList() async {
    await _initPrefs();
    final List<String>? stringList = _prefs.getStringList("cart_list");
    if (stringList == null) {
      return;
    }

    try {
      _cartItemShaaredPrefList
          .clear(); // Clear the existing list before loading
      _cartItemShaaredPrefList.addAll(
        stringList
            .map((item) => CartItemModel.fromJson(jsonDecode(item)))
            .toList(),
      );
      if (kDebugMode) {
        print(
          'initial size of _cartItemShaaredPrefList is ${_cartItemShaaredPrefList.length}',
        );
      }
      //_setMessage('List loaded successfully!');
    } catch (e) {
      //_setMessage('Error loading list: $e'); // Important: show errors to the user
      _cartItemShaaredPrefList.clear(); // Clear corrupted data.
      if (kDebugMode) {
        print(
          'initial size of _cartItemShaaredPrefList catch is ${_cartItemShaaredPrefList.length}',
        );
      }
    }
    setState(() {}); //update
  }

  @override
  void initState() {
    super.initState();
    loadCartProductsFromSharedPref();
  }

  Future<void> loadCartProductsFromSharedPref() async {
    await _loadList();
    if (_cartItemShaaredPrefList.isNotEmpty) {
      String productIds = _cartItemShaaredPrefList
          .map((cartItem) => cartItem.productPackingId)
          .join(',');

      String productType = _cartItemShaaredPrefList
          .map((cartItem) => cartItem.productType.replaceAll("combo_", ""))
          .join(',');

      widget.paginationController.getProductCart(
        productIds.replaceAll("combo_", ""),
        productType,
      ); // Explicit call
    }
  }

  int freeSelectedIndex = -1;

  void showSnackbar(String s) {
    var snackBar = SnackBar(
      backgroundColor: Colors.white,
      content: Text(
        s,
        style: TextStyle(
          fontSize: 14.0,
          fontFamily: "Montserrat",
          color: Color.fromARGB(255, 32, 47, 80),
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Function to increment item count
  void _incrementCount(int index) {
    if (cartMaxQty.toString() ==
        _cartItemShaaredPrefList.elementAt(index).quantity) {
      showSnackbar("You have added max quantity.");
      return;
    }
    setState(() {
      int currentQuantity = int.parse(_cartItemShaaredPrefList[index].quantity);
      _cartItemShaaredPrefList[index].quantity =
          (currentQuantity + 1).toString();

      //todo: test this
      // selectedItemQuantity++;
      // floatingButtonPrice =
      //     double.parse(_selectedVariant!.productPackingPrice) *
      //         selectedItemQuantity;
    });
    // setState(() {
    //   _cartItems[index].count++;
    // });
  }

  // Function to increment item count
  void _updateFreeSelectedIndex(int index) {
    setState(() {
      freeSelectedIndex = index;
    });
  }

  void proceedToCheckOutClicked() {
    setState(() {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => Checkout()));
    });
  }

  // Function to decrement item count
  void _decrementCount(int index) {
    if (int.parse(_cartItemShaaredPrefList.elementAt(index).quantity) > 1) {
      setState(() {
        _cartItemShaaredPrefList[index].quantity =
            (int.parse(_cartItemShaaredPrefList.elementAt(index).quantity) - 1)
                .toString();
      });
    }

    // setState(() {
    //   if (_cartItems[index].count > 1) {
    //     _cartItems[index].count--;
    //   }
    // });
  }

  // Function to remove item from cart
  Future<void> _removeItem(int index) async {
    _cartItems!.removeAt(index);
    _cartItemShaaredPrefList.removeAt(index);

    final List<String> stringList =
        _cartItemShaaredPrefList
            .map((item) => jsonEncode(item.toJson()))
            .toList();
    await _prefs.setStringList("cart_list", stringList);

    showSnackbar("Cart updated."); // Show the message
  }

  // Function to format price
  String _formatPrice(String price) {
    return "₹ $price";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (widget.paginationController.cartItems.isEmpty &&
            widget.paginationController.cartItemsLoading.value) {
          //API called
          //todo: change this
          return Container(
            color: Color.fromARGB(255, 31, 47, 80),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (!widget.paginationController.cartItemsLoading.value &&
            widget.paginationController.cartItems.isEmpty) {
          //either no API called or no data exist
          return Center(child: Text("Empty Cart"));
        }

        cartMaxQty = widget.paginationController.cartMaxQty;
        _cartItems = widget.paginationController.cartItems;

        return SafeArea(
          child: Scaffold(
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/bg.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                // Remove SingleChildScrollView from the outermost level
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // 1. Title
                    SizedBox(height: 20.0),

                    //text my bag
                    Text(
                      "My Bag",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontFamily: "Montserrat",
                      ),
                    ),

                    SizedBox(height: 10.0),

                    Expanded(
                      // Wrap the scrollable part in Expanded
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 3. Vertical List of cart items
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              // Disable nested scrolling
                              itemCount: _cartItems?.length,
                              itemBuilder: (context, index) {
                                final cartItem = _cartItems![index];
                                final _cartItemShaaredPref =
                                    _cartItemShaaredPrefList[index];
                                return CartItemWidget(
                                  index,
                                  cartItem,
                                  _cartItemShaaredPref,
                                  _formatPrice,
                                  _decrementCount,
                                  _incrementCount,
                                  _removeItem,
                                );
                              },
                            ),

                            SizedBox(height: 16.0),
                            // 4. Horizontal List of Images
                            //free product 2 text
                            Text(
                              "For our prestigious Customers :",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Montserrat",
                              ),
                            ),

                            SizedBox(height: 5),

                            Text(
                              "Please Select Anyone Free Product Tester & Proceed To Checkout Below",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: "Montserrat",
                              ),
                            ),

                            SizedBox(height: 10),

                            //todo: here for free products API and data
                            // //horizontal list of free products
                            // SizedBox(
                            //   height:
                            //       230, // Fixed height for the horizontal list
                            //   child: ListView.builder(
                            //     scrollDirection: Axis.horizontal,
                            //     itemCount: _imageList.length,
                            //     itemBuilder: (context, index) {
                            //       return GestureDetector(
                            //         onTap: () {
                            //           _updateFreeSelectedIndex(index);
                            //         },
                            //         child: Padding(
                            //           padding: const EdgeInsets.symmetric(
                            //             horizontal: 8.0,
                            //           ),
                            //           child: Stack(
                            //             alignment: Alignment.center,
                            //             children: [
                            //               Column(
                            //                 children: [
                            //                   //product image
                            //                   Padding(
                            //                     padding: EdgeInsets.all(4),
                            //                     child: SizedBox(
                            //                       width: 150,
                            //                       height: 150,
                            //                       child:
                            //                           NetworkImageWithLoading(
                            //                             imageUrl:
                            //                                 _imageList[index],
                            //                           ),
                            //                     ),
                            //                   ),
                            //
                            //                   //product text
                            //                   SizedBox(
                            //                     width: 150,
                            //                     height: 40,
                            //                     child: Center(
                            //                       child: Text(
                            //                         maxLines: 2,
                            //                         textAlign: TextAlign.center,
                            //                         overflow:
                            //                             TextOverflow.ellipsis,
                            //                         "${_itemNameList[index]}",
                            //                         style: TextStyle(
                            //                           fontSize: 12,
                            //                           fontWeight:
                            //                               FontWeight.w500,
                            //                           fontFamily: "Montserrat",
                            //                           color: Colors.white,
                            //                         ),
                            //                       ),
                            //                     ),
                            //                   ),
                            //                 ],
                            //               ),
                            //
                            //               //background border
                            //               Align(
                            //                 alignment: Alignment.topCenter,
                            //                 child: Container(
                            //                   decoration: BoxDecoration(
                            //                     border: Border.all(
                            //                       color: Color.fromARGB(
                            //                         255,
                            //                         123,
                            //                         138,
                            //                         195,
                            //                       ),
                            //                       width: 1.0,
                            //                     ),
                            //                     borderRadius:
                            //                         BorderRadius.circular(0),
                            //                   ),
                            //                   width: 166,
                            //                   height: 210,
                            //                 ),
                            //               ),
                            //
                            //               //bottom selector default
                            //               if (freeSelectedIndex != index)
                            //                 Align(
                            //                   alignment: Alignment.bottomCenter,
                            //                   child: Container(
                            //                     width: 35,
                            //                     height: 35,
                            //                     decoration: BoxDecoration(
                            //                       shape: BoxShape.circle,
                            //                       color: Color.fromARGB(
                            //                         255,
                            //                         31,
                            //                         47,
                            //                         80,
                            //                       ),
                            //                     ),
                            //                     child: Container(
                            //                       width: 30,
                            //                       height: 30,
                            //                       decoration: BoxDecoration(
                            //                         shape: BoxShape.circle,
                            //                         color: Colors.white,
                            //                         border: Border.all(
                            //                           width: 5,
                            //                           color: Color.fromARGB(
                            //                             255,
                            //                             31,
                            //                             47,
                            //                             80,
                            //                           ),
                            //                         ),
                            //                       ),
                            //                     ),
                            //                   ),
                            //                 ),
                            //
                            //               //bottom selector selected
                            //               if (freeSelectedIndex == index)
                            //                 Align(
                            //                   alignment: Alignment.bottomCenter,
                            //                   child: Container(
                            //                     width: 33,
                            //                     height: 33,
                            //                     decoration: BoxDecoration(
                            //                       shape: BoxShape.circle,
                            //                       color: Colors.white,
                            //                     ),
                            //                     child: Container(
                            //                       width: 30,
                            //                       height: 30,
                            //                       decoration: BoxDecoration(
                            //                         shape: BoxShape.circle,
                            //                         color: Color.fromARGB(
                            //                           255,
                            //                           31,
                            //                           47,
                            //                           80,
                            //                         ),
                            //                         border: Border.all(
                            //                           width: 2,
                            //                           color: Colors.white,
                            //                         ),
                            //                       ),
                            //                     ),
                            //                   ),
                            //                 ),
                            //             ],
                            //           ),
                            //         ),
                            //       );
                            //     },
                            //   ),
                            // ),
                            SizedBox(height: 10),

                            //proceed to checkout button
                            proceedToCheckOutButtonFullWidth(
                              proceedToCheckOutClicked,
                            ),

                            SizedBox(height: 100),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
