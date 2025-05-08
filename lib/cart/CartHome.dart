import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hjvyas/checkout/Checkout.dart';
import 'package:hjvyas/utils/CommonAppProgress.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/models/CartItemModel.dart';
import '../api/models/ProductCartResponse.dart';
import '../api/models/ProductTesterResponse.dart';
import '../api/services/HJVyasApiService.dart';
import '../home/navigation.dart';
import '../injection_container.dart';
import '../product/ProductPaginationController.dart';
import '../product_detail/FullWidthButton.dart';
import '../splash/NoIntternetScreen.dart';
import 'CartItemWidget.dart';
import 'EmptyCart.dart';
import 'TesterItemWidget.dart';

class CartPage extends StatefulWidget {
  bool showBackButton;

  final ProductPaginationController paginationController =
      ProductPaginationController(getIt<HJVyasApiService>());

  CartPage({super.key, this.showBackButton = false});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Offset> _slideAnimation;

  List<CartItemModel> _cartItemShaaredPrefList = [];
  List<ProductCartListItem>? _cartItems;
  List<ProductTesterListItem>? _productTesterItems;
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

  void initAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Much higher above the screen
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutQuad),
    );

    // Stagger the animations based on index
    Future.delayed(Duration(milliseconds: 1000), () {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    initAnimation();
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

      await widget.paginationController.getProductCart(
        productIds.replaceAll("combo_", ""),
        productType,
      ); // Explicit call

      getProductTester();
    }
  }

  Future<void> getProductTester() async {
    String productIds = _cartItemShaaredPrefList
        .map((cartItem) => cartItem.productPackingId)
        .join(',');

    double total = 0;

    for (int i = 0; i < _cartItemShaaredPrefList.length; i++) {
      total +=
          int.parse(_cartItemShaaredPrefList.elementAt(i).quantity) *
          double.parse(
            widget.paginationController.cartItems.elementAt(i).packingPrice,
          );
    }

    widget.paginationController.getProductTester(
      productIds.replaceAll("combo_", ""),
      total.toString(),
    );
  }

  int freeSelectedIndex = -1;
  bool isTesterEnabled = false;
  String productTesterId = "";

  // Function to increment item count
  void _incrementCount(int index) {
    if (cartMaxQty.toString() ==
        _cartItemShaaredPrefList.elementAt(index).quantity) {
      showSnackbar(context, "You have added max quantity.");
      return;
    }
    setState(() {
      int currentQuantity = int.parse(_cartItemShaaredPrefList[index].quantity);
      _cartItemShaaredPrefList[index].quantity =
          (currentQuantity + 1).toString();
    });
  }

  // Function to increment item count
  void _updateFreeSelectedIndex(int index) {
    setState(() {
      freeSelectedIndex = index;

      productTesterId = _productTesterItems!.elementAt(index).testerId;
    });
  }

  void proceedToCheckOutClicked() {
    if (isTesterEnabled && freeSelectedIndex == -1) {
      showSnackbar(context, "Please Select Any One Free Product Tester");
      return;
    }
    double total = 0;

    for (int i = 0; i < _cartItemShaaredPrefList.length; i++) {
      total +=
          int.parse(_cartItemShaaredPrefList.elementAt(i).quantity) *
          double.parse(
            widget.paginationController.cartItems.elementAt(i).packingPrice,
          );
    }

    setState(() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder:
              (context) => Checkout(
                total: total,
                productTesterId: productTesterId,
                cartItemShaaredPrefList: _cartItemShaaredPrefList,
                cartItemsFromAPIforPrice: _cartItems!,
              ),
        ),
      );
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

    await getProductTester();

    showSnackbar(context, "Cart updated."); // Show the message

    //updating cart total
    NavigationExample.of(context)?.loadSharedPrefItemsList();
  }

  // Function to format price
  String _formatPrice(String price) {
    return "₹ ${getTwoDecimalPrice(double.parse(price))}";
  }

  Future<void> fetchData() async {
    await loadCartProductsFromSharedPref();
  }

  void _refreshData() {
    fetchData();
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
        body: Obx(() {
          //internet or API issue
          if (widget.paginationController.isError.value) {
            return NoInternetScreen(
              onRetry: () {
                _refreshData();
              },
            );
          }

          if (!widget.paginationController.cartItemsLoading.value &&
              widget.paginationController.cartItems.isEmpty) {
            return EmptyCart(showBackButton: widget.showBackButton);
          }

          cartMaxQty = widget.paginationController.cartMaxQty;
          _cartItems = widget.paginationController.cartItems;

          _productTesterItems = widget.paginationController.productTesterList;
          isTesterEnabled =
              (widget
                          .paginationController
                          .productTesterResponse
                          .value
                          ?.productTesterStatus ==
                      "on")
                  ? true
                  : false;

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

                      if (widget.paginationController.cartItems.isEmpty &&
                          widget
                              .paginationController
                              .cartItemsLoading
                              .value) ...[
                        //API called
                        getCommonProgressBar(),
                      ],

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
                                    index: index,
                                    formatPrice: _formatPrice,
                                    decrementCount: _decrementCount,
                                    incrementCount: _incrementCount,
                                    removeItem: _removeItem,
                                    cartItem: cartItem,
                                    cartItemModel: _cartItemShaaredPref,
                                  );
                                },
                              ),

                              if (widget
                                      .paginationController
                                      .productTesterList
                                      .isEmpty &&
                                  widget
                                      .paginationController
                                      .testerItemsLoading
                                      .value) ...[
                                getCommonProgressBar(),
                              ],

                              //horizontal list of free products
                              if (!widget
                                      .paginationController
                                      .testerItemsLoading
                                      .value &&
                                  widget
                                      .paginationController
                                      .productTesterList
                                      .isNotEmpty &&
                                  null !=
                                      widget
                                          .paginationController
                                          .productTesterResponse
                                          .value &&
                                  widget
                                          .paginationController
                                          .productTesterResponse
                                          .value!
                                          .productTesterStatus ==
                                      "on") ...[
                                SizedBox(height: 16.0),

                                // 4. Horizontal List of Images
                                //free product 2 text
                                Html(
                                  data:
                                      widget
                                          .paginationController
                                          .productTesterResponse
                                          .value!
                                          .productTesterMsg,
                                  style: {
                                    "body": Style(
                                      fontWeight: FontWeight.w400,
                                      //fontSize: 14,
                                      fontFamily: "Montserrat",
                                      fontSize: FontSize.medium,
                                      textAlign: TextAlign.justify,
                                      color: Colors.white,
                                    ),
                                    //"h1": Style(fontSize: FontSize.xxLarge),
                                    "p": Style(
                                      fontWeight: FontWeight.w400,
                                      //fontSize: 14,
                                      fontFamily: "Montserrat",
                                      fontSize: FontSize.medium,
                                      textAlign: TextAlign.justify,
                                      color: Colors.white,
                                    ),
                                    "strong": Style(
                                      fontWeight: FontWeight.w600,
                                      //fontSize: 14,
                                      fontFamily: "Montserrat",
                                      fontSize: FontSize.large,
                                      textAlign: TextAlign.justify,
                                      color: Colors.white,
                                    ),
                                    //"a": Style(color: Colors.blue, decoration: TextDecoration.underline),
                                    //"table": Style(border: Border.all(color: Colors.grey)),
                                    //"th": Style(padding: EdgeInsets.all(8), backgroundColor: Colors.lightBlue),
                                    //"td": Style(padding: EdgeInsets.all(8)),
                                    //"div": Style(margin: EdgeInsets.only(bottom: 10)),
                                    // "img": Style(
                                    //   width: Width.percent(100), // Make images responsive.
                                    //   height: Height.auto(),
                                    // ),
                                  },
                                ),

                                SizedBox(height: 10),

                                SizedBox(
                                  height:
                                      230, // Fixed height for the horizontal list
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _productTesterItems?.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          _updateFreeSelectedIndex(index);
                                        },
                                        child: TesterItemWidget(
                                          index: index,
                                          productTesterListItem:
                                              _productTesterItems![index],
                                          freeSelectedIndex: freeSelectedIndex,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],

                              SizedBox(height: 10),

                              if (!widget
                                      .paginationController
                                      .cartItemsLoading
                                      .value &&
                                  widget
                                      .paginationController
                                      .cartItems
                                      .isNotEmpty) ...[
                                //proceed to checkout button
                                SlideTransition(
                                  position: _slideAnimation,
                                  child: FadeTransition(
                                    opacity: _animationController,
                                    child: proceedToCheckOutButtonFullWidth(
                                      proceedToCheckOutClicked,
                                    ),
                                  ),
                                ),

                                SizedBox(height: 100),
                              ],
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
      ),
    );
  }
}
