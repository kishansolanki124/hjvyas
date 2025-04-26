import 'dart:convert';

import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hjvyas/cart/CartHome.dart';
import 'package:hjvyas/product_detail/ImageWithProgress.dart';
import 'package:hjvyas/product_detail/ProductDetailController.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/models/CartItemModel.dart';
import '../api/models/ProductDetailResponse.dart';
import '../api/services/HJVyasApiService.dart';
import '../injection_container.dart';
import '../product/ProductListWidgets.dart';
import '../utils/FloatingImageViewer.dart';
import '../utils/NetworkImageWithProgress.dart';
import 'AudioFilesDialog.dart';
import 'FullWidthButton.dart';
import 'ProductDetailWidget.dart';

class ProductDetail extends StatefulWidget {
  final String productId;
  final bool isOutOfStock;

  const ProductDetail({
    super.key,
    required this.productId,
    required this.isOutOfStock,
  });

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FoodProductDetailsPage(
        productId: widget.productId,
        isOutOfStock: widget.isOutOfStock,
      ),
    );
  }
}

class FoodProductDetailsPage extends StatefulWidget {
  final ProductDetailController categoryController = ProductDetailController(
    getIt<HJVyasApiService>(),
  );

  String productId = "";
  bool isOutOfStock = false;

  FoodProductDetailsPage({
    super.key,
    required this.productId,
    required this.isOutOfStock,
  });

  @override
  _FoodProductDetailsPageState createState() => _FoodProductDetailsPageState();
}

class _FoodProductDetailsPageState extends State<FoodProductDetailsPage>
    with TickerProviderStateMixin {
  // Instance of SharedPreferences
  late SharedPreferences _prefs;

  List<CartItemModel> _myList = [];

  // Initialize SharedPreferences
  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Helper function to load the list from SharedPreferences
  Future<void> _loadList() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? stringList = prefs.getStringList("cart_list");
    if (stringList == null) {
      //_setMessage('No list found, initializing empty list.');
      return; //  Return, don't try to decode null
    }

    // Decode each JSON string back into a CustomObject
    try {
      _myList.clear(); // Clear the existing list before loading
      _myList.addAll(
        stringList
            .map((item) => CartItemModel.fromJson(jsonDecode(item)))
            .toList(),
      );
      if (kDebugMode) {
        print('initial size of _myList is ${_myList.length}');
      }
      //_setMessage('List loaded successfully!');
    } catch (e) {
      //_setMessage('Error loading list: $e'); // Important: show errors to the user
      _myList.clear(); // Clear corrupted data.
      if (kDebugMode) {
        print('initial size of _myList catch is ${_myList.length}');
      }
    }
    setState(() {}); //update
  }

  int getQuantity() {
    int initialQuantity = 1;
    if (kDebugMode) {
      print('_myList size is $_myList');
    }
    if (_myList.isNotEmpty) {
      for (var i = 0; i < _myList.length; i++) {
        //check if item exist in cart, then update quantity only
        if (_myList.elementAt(i).productPackingId ==
            _selectedVariant!.packingId) {
          initialQuantity = int.parse(_myList.elementAt(i).quantity);
          if (kDebugMode) {
            print('initialQuantity is $initialQuantity');
          }
          break;
        }
      }
    }

    return initialQuantity;
  }

  void initPriceAndQuantity() {
    int initialQuantity = 1;
    if (kDebugMode) {
      print('_myList size is $_myList');
    }
    if (_myList.isNotEmpty) {
      for (var i = 0; i < _myList.length; i++) {
        //check if item exist in cart, then update quantity only
        if (_myList.elementAt(i).productPackingId ==
            _selectedVariant!.packingId) {
          initialQuantity = int.parse(_myList.elementAt(i).quantity);
          if (kDebugMode) {
            print('initialQuantity is $initialQuantity');
          }
          break;
        }
      }
    }

    //setState(() {
    selectedItemQuantity = initialQuantity;
    floatingButtonPrice =
        double.parse(_selectedVariant!.productPackingPrice) *
        selectedItemQuantity;
    //});
  }

  Future<void> _addToCart() async {
    // Convert each CustomObject in the list to a JSON map,
    // then encode the whole list as a JSON string
    CartItemModel cartItemModel = CartItemModel(
      productType: "product",
      productPackingId: _selectedVariant!.packingId,
      quantity: selectedItemQuantity.toString(),
      productDetail: productDetailResponse!.productDetail,
      productPackingList: productDetailResponse!.productPackingList,
    );

    bool itemExist = false;
    int itemExistPosition = -1;

    if (kDebugMode) {
      print('_myList size addtoCart is ${_myList.length}');
    }

    if (_myList.isNotEmpty) {
      for (var i = 0; i < _myList.length; i++) {
        //check if item exist in cart, then update quantity only
        if (_myList.elementAt(i).productPackingId ==
            _selectedVariant!.packingId) {
          //item exist
          itemExist = true;
          itemExistPosition = i;
          print('itemExistPosition addtoCart is $itemExistPosition');
          break;
        }
      }
    }

    if (itemExist) {
      _myList[itemExistPosition] = cartItemModel;
    } else {
      _myList.add(cartItemModel);
    }

    if (kDebugMode) {
      print('_myList is inside addTocart is $_myList');
    }

    final List<String> stringList =
        _myList.map((item) => jsonEncode(item.toJson())).toList();
    await _prefs.setStringList("cart_list", stringList);
    showSnackbar("Cart updated.");
  }

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

  bool _showBottomNavBar = true; //BottomNavigationBar visibility

  int _currentImageIndex = 0;

  double floatingButtonPrice = 0;
  int selectedItemQuantity = 1;

  ProductPackingListItem? _selectedVariant;
  ProductDetailResponse? productDetailResponse;
  ProductDetailItem? productDetailItem;
  late TabController _tabController;
  int activeTabIndex = 0;

  // Controllers for the TextField values
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize shared preferences in initState
    _initPrefs();
    _loadList();
    widget.categoryController.getProductDetail(
      widget.productId,
    ); // Explicit call

    _tabController = TabController(
      length: 2, //initialIndex : 0,
      vsync: this,
    );

    _tabController.addListener(() {
      setState(() {
        activeTabIndex = _tabController.index;
      });
    });

    _scrollController.addListener(_onScroll); // Listen to scroll events
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll); // Remove the listener
    _scrollController.dispose();

    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile No. is required';
    }
    if (value.length != 10) {
      return 'Mobile No. must be 10 digits';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!EmailValidator.validate(value)) {
      return 'Invalid email address';
    }
    return null;
  }

  void onNotifyMeClick() {
    if (_validatePhone(_phoneController.text) != null) {
      showSnackbar(_validatePhone(_phoneController.text).toString());
    } else if (_validateEmail(_emailController.text) != null) {
      showSnackbar(_validateEmail(_emailController.text).toString());
    } else {
      showSuccessDialogForNotifyMe();
    }
  }

  void showSuccessDialogForNotifyMe() async {
    // Show loading on button
    widget.categoryController.adInquiryLoading.value = true;

    try {
      // Call API
      await widget.categoryController.addInquiry(
        widget.productId,
        "product",
        _phoneController.text,
        _emailController.text,
      );

      // Check if widget is still mounted before showing dialog
      if (mounted) {
        _phoneController.text = "";
        _emailController.text = "";

        showAlertWithCallback(
          context: context,
          title: 'Success',
          message: widget.categoryController.addInquiryResponse.value!.message,
          onOkPressed: () {
            // Optional callback after dialog dismissal
            if (kDebugMode) {
              print('User acknowledged success');
            }
          },
        );
      }
    } finally {
      // Hide loading regardless of success/failure
      if (mounted) {
        widget.categoryController.adInquiryLoading.value = false;
      }
    }
  }

  // This method will be called by ScrollWidget when the user scrolls
  void _updateBottomNavBarVisibility(bool show) {
    if (mounted) {
      // //check if the widget is mounted before calling setState
      setState(() {
        _showBottomNavBar = show;
      });
    }
  }

  final ScrollController _scrollController = ScrollController();

  void showImageViewer(BuildContext context, String imageUrl) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Image Viewer",
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) {
        return FloatingImageViewer(imageUrl: imageUrl, onClose: () => {});
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  // Example usage:
  void showAudioFilesDialog(BuildContext context) {
    List<String> audioTitles = [];
    List<String> audioFiles = [];

    if (productDetailResponse!.productDetail
        .elementAt(0)
        .productAudioEnglish
        .isNotEmpty) {
      audioFiles.add(
        productDetailResponse!.productDetail.elementAt(0).productAudioEnglish,
      );
      audioTitles.add("English");
    }

    if (productDetailResponse!.productDetail
        .elementAt(0)
        .productAudioHindi
        .isNotEmpty) {
      audioFiles.add(
        productDetailResponse!.productDetail.elementAt(0).productAudioHindi,
      );
      audioTitles.add("Hindi");
    }

    if (productDetailResponse!.productDetail
        .elementAt(0)
        .productAudioGujarati
        .isNotEmpty) {
      audioFiles.add(
        productDetailResponse!.productDetail.elementAt(0).productAudioGujarati,
      );
      audioTitles.add("Gujarati");
    }

    showDialog(
      context: context,
      builder:
          (context) => AudioFilesDialog(
            audioFiles: audioFiles,
            audioTitles: audioTitles,
          ),
    );
  }

  void _onScroll() {
    // Check the scroll direction
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      // If scrolling down, hide the BottomNavigationBar
      _updateBottomNavBarVisibility(false);
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      // If scrolling up, show the BottomNavigationBar
      _updateBottomNavBarVisibility(true);
    }
    // You might also want to hide it if the user scrolls to the very bottom or top.
    if (_scrollController.offset <=
        _scrollController.position.minScrollExtent) {
      _updateBottomNavBarVisibility(true);
    }
  }

  void _incrementQuantity() {
    //todo: product_max_qty handle here
    setState(() {
      selectedItemQuantity++;
      floatingButtonPrice =
          double.parse(_selectedVariant!.productPackingPrice) *
          selectedItemQuantity;
    });
  }

  void _onChangedDropDownValue(ProductPackingListItem newValue) {
    setState(() {
      _selectedVariant = newValue;
      selectedItemQuantity = getQuantity();
      if (kDebugMode) {
        print('selectedItemQuantity is $selectedItemQuantity');
      }
      floatingButtonPrice =
          double.parse(_selectedVariant!.productPackingPrice) *
          selectedItemQuantity;
    });
  }

  void _decrementQuantity() {
    if (selectedItemQuantity > 1) {
      setState(() {
        selectedItemQuantity--;
        floatingButtonPrice =
            double.parse(_selectedVariant!.productPackingPrice) *
            selectedItemQuantity;
      });
    }
  }

  void _onPageChange(int index) {
    setState(() {
      _currentImageIndex = index;
    });
  }

  void _onPressed() {
    setState(() {
      _addToCart();
      if (kDebugMode) {
        print('Add to Cart button pressed!');
      }
    });
  }

  void _onBackPressed() {
    setState(() {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (widget.categoryController.loading.value) {
        //todo change this
        return Center(child: CircularProgressIndicator());
      }

      if (widget.categoryController.error.value.isNotEmpty) {
        //todo change this
        return Center(child: Text('Error: ${widget.categoryController.error}'));
      }

      productDetailResponse ??=
          widget.categoryController.productDetailResponse.value;

      productDetailItem ??= productDetailResponse!.productDetail.elementAt(0);

      if (_selectedVariant == null) {
        _selectedVariant = productDetailResponse!.productPackingList.elementAt(
          0,
        );
        initPriceAndQuantity();
        if (kDebugMode) {
          print('selectedItemQuantity is $selectedItemQuantity');
        }
      }

      if (floatingButtonPrice == 0) {
        floatingButtonPrice = double.parse(
          productDetailResponse!.productPackingList
              .elementAt(0)
              .productPackingPrice,
        );
      }
      //_selectedVariantInquiry ??= cateogories.inquiryType.split(', ').first;
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  controller: _scrollController, // Attach the scroll controller
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // 1. Image Carousel with Dots
                          productDetailViewpager(
                            productDetailResponse!.productGalleryList,
                            _onPageChange,
                          ),

                          // 2. Image Carousel Dots and volume
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              productDetailCorosoulDots(
                                productDetailResponse!.productGalleryList,
                                _currentImageIndex,
                              ),
                              //volume or audio icon
                              if (productDetailItem!
                                      .productAudioGujarati
                                      .isNotEmpty ||
                                  productDetailItem!
                                      .productAudioHindi
                                      .isNotEmpty ||
                                  productDetailItem!
                                      .productAudioEnglish
                                      .isNotEmpty)
                                GestureDetector(
                                  onTap: () {
                                    showAudioFilesDialog(context);
                                  },
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                      20,
                                      10,
                                      30,
                                      0,
                                    ),
                                    child: Image.asset(
                                      height: 30,
                                      width: 30,
                                      "images/audio_icon.png",
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),

                      //square border app color
                      IgnorePointer(
                        child: Container(
                          height: 680,
                          margin: EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                            bottom: 0,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: Color.fromARGB(255, 123, 138, 195),
                                width: 2.0,
                              ),
                              bottom: BorderSide(
                                color: Color.fromARGB(255, 123, 138, 195),
                                width: 2.0,
                              ),
                              right: BorderSide(
                                color: Color.fromARGB(255, 123, 138, 195),
                                width: 2.0,
                              ),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                          ),
                        ),
                      ),

                      Column(
                        children: [
                          SizedBox(height: 600),

                          //3. name and price
                          // 4. Dropdown of variant and Counter (Horizontal)
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                //3. name and price
                                productDetailNameAndPrice(
                                  productDetailResponse!.productDetail
                                      .elementAt(0)
                                      .productName,
                                  productDetailResponse!.productDetail
                                      .elementAt(0)
                                      .productPrice,
                                  widget.isOutOfStock,
                                ),

                                //out of stock
                                //notify me content
                                if (widget.isOutOfStock)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    // Align text to the left
                                    children: <Widget>[
                                      // 1. "We're Sorry!" text in bold
                                      Text(
                                        "We're Sorry!",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.0,
                                          // Adjust size as needed
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Montserrat",
                                        ),
                                      ),

                                      SizedBox(height: 8.0),
                                      // Add some vertical spacing
                                      // 2. "This item has sold out" text in normal font
                                      Text(
                                        "This Item Has Sold Out. We Will Get Back Soon With This Product.",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.0,
                                          // Adjust size as needed
                                          fontFamily: "Montserrat",
                                        ),
                                      ),

                                      SizedBox(height: 16.0),

                                      // 3. "Notify Me !" Text with leading email icon
                                      Row(
                                        children: [
                                          Image.asset(
                                            width: 24,
                                            height: 24,
                                            "icons/notify_me_icon.png",
                                          ),
                                          // Use the email icon
                                          SizedBox(width: 8.0),

                                          Text(
                                            "Notify Me !",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.0,
                                              // Adjust size as needed
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Montserrat",
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 8.0),

                                      // 4. Text "Notify me when Product is Available"
                                      Text(
                                        "Notify Me When Product Is Available.",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.0,
                                          // Adjust size as needed
                                          fontFamily: "Montserrat",
                                        ),
                                      ),

                                      SizedBox(height: 8.0),

                                      // 5. Input text or Edit text with hint "Enter your mobile no."
                                      // with 10 digit max length and input type should be only numbers
                                      TextField(
                                        controller: _phoneController,
                                        keyboardType: TextInputType.number,
                                        maxLength: 10,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        ],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Montserrat",
                                          fontSize: 14,
                                        ),
                                        // Set text color to white
                                        decoration: InputDecoration(
                                          hintText: "Enter Your Mobile No.",
                                          hintStyle: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Montserrat",
                                            fontSize: 14,
                                          ),

                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(0),
                                            ),
                                            borderSide: BorderSide(
                                              width: 1,
                                              color: Color.fromARGB(
                                                255,
                                                123,
                                                138,
                                                195,
                                              ),
                                            ),
                                          ),
                                          // disabledBorder: OutlineInputBorder(
                                          //   borderRadius: BorderRadius.all(Radius.circular(4)),
                                          //   borderSide: BorderSide(width: 1,color: Colors.orange),
                                          // ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(0),
                                            ),
                                            borderSide: BorderSide(
                                              width: 1,
                                              color: Color.fromARGB(
                                                255,
                                                123,
                                                138,
                                                195,
                                              ),
                                            ),
                                          ),

                                          // border: OutlineInputBorder(
                                          //     borderRadius: BorderRadius.all(Radius.circular(4)),
                                          //     borderSide: BorderSide(width: 1,)
                                          // ),
                                          // errorBorder: OutlineInputBorder(
                                          //     borderRadius: BorderRadius.all(Radius.circular(4)),
                                          //     borderSide: BorderSide(width: 1,color: Colors.black)
                                          // ),
                                          // focusedErrorBorder: OutlineInputBorder(
                                          //     borderRadius: BorderRadius.all(Radius.circular(4)),
                                          //     borderSide: BorderSide(width: 1,color: Colors.yellowAccent)
                                          // ),
                                          contentPadding: EdgeInsets.all(8),
                                          isDense:
                                              true, //make textfield compact
                                        ),
                                      ),

                                      // 6. Input text or Edit text with hint "Enter your email id"
                                      // with input type email
                                      TextField(
                                        controller: _emailController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Montserrat",
                                          fontSize: 14,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: "Enter your email id",
                                          hintStyle: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Montserrat",
                                            fontSize: 14,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(0),
                                            ),
                                            borderSide: BorderSide(
                                              width: 1,
                                              color: Color.fromARGB(
                                                255,
                                                123,
                                                138,
                                                195,
                                              ),
                                            ),
                                          ),
                                          // disabledBorder: OutlineInputBorder(
                                          //   borderRadius: BorderRadius.all(Radius.circular(4)),
                                          //   borderSide: BorderSide(width: 1,color: Colors.orange),
                                          // ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(0),
                                            ),
                                            borderSide: BorderSide(
                                              width: 1,
                                              color: Color.fromARGB(
                                                255,
                                                123,
                                                138,
                                                195,
                                              ),
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.all(8),
                                          isDense:
                                              true, //make textfield compact
                                        ),
                                      ),

                                      SizedBox(height: 18.0),

                                      // 7. Notify Me square Button in black color text and sky color background
                                      SizedBox(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            onNotifyMeClick();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color.fromARGB(
                                              255,
                                              123,
                                              138,
                                              195,
                                            ),
                                            // Sky color
                                            //foregroundColor: Colors.black,
                                            // Black text color
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius
                                                      .zero, // Square corners
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              vertical: 10.0,
                                              horizontal: 12,
                                            ), // Add some vertical padding
                                          ),

                                          child: Obx(() {
                                            if (widget
                                                .categoryController
                                                .adInquiryLoading
                                                .value) {
                                              return SizedBox(
                                                width: 20,
                                                height: 20,
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  color: Colors.white,
                                                ),
                                              );
                                            }
                                            return Text(
                                              "Notify Me",
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              ), // Adjust size
                                            );
                                          }),
                                        ),
                                      ),
                                    ],
                                  ),

                                // 4. Dropdown of variant and Counter (Horizontal)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    if (!widget.isOutOfStock)
                                      productDetailDropDown(
                                        productDetailResponse!
                                            .productPackingList,
                                        _selectedVariant,
                                        _onChangedDropDownValue,
                                      ),

                                    if (!widget.isOutOfStock)
                                      productDetailItemCounter(
                                        widget,
                                        _decrementQuantity,
                                        _incrementQuantity,
                                        selectedItemQuantity,
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // 5. Horizontal List of Square Images of Product Ingredients
                          if (productDetailResponse!
                              .productIngredientsList
                              .isNotEmpty)
                            productDetailIngredients(
                              productDetailResponse!.productIngredientsList,
                            ),

                          // //description
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(
                          //     horizontal: 16.0,
                          //   ),
                          //   child: Text(
                          //     productDetailResponse.productDetail.elementAt(0).detail,
                          //     style: TextStyle(
                          //       fontSize: 14,
                          //       color: Colors.white,
                          //       fontFamily: "Montserrat",
                          //     ),
                          //   ),
                          // ),

                          //Product Terms
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Terms :',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  productDetailResponse!.productDetail
                                      .elementAt(0)
                                      .productTerms,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontFamily: "Montserrat",
                                  ),
                                ),
                                SizedBox(height: 24),
                              ],
                            ),
                          ),

                          // 7. Tab Layout with Two Tabs
                          productDetailTabs(_tabController, activeTabIndex),

                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: AutoScaleTabBarView(
                              controller: _tabController,
                              children: [
                                // Description Tab (tab 1)
                                Html(
                                  data:
                                      productDetailResponse!.productDetail
                                          .elementAt(0)
                                          .productDescription,
                                  style: {
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
                                ), // Text(
                                //   productDetailResponse.productDetail
                                //       .elementAt(0)
                                //       .productDescription,
                                //   textAlign: TextAlign.justify,
                                //   style: TextStyle(
                                //     fontSize: 14,
                                //     color: Colors.white,
                                //     fontFamily: "Montserrat",
                                //   ),
                                // ),
                                // Nutrition Info Tab
                                GestureDetector(
                                  onTap: () {
                                    showImageViewer(
                                      context,
                                      productDetailItem!.productNutritionImage,
                                    );
                                  },
                                  child: SizedBox(
                                    height: 200,
                                    child: ImageWithProgress(
                                      imageURL:
                                          productDetailResponse!.productDetail
                                              .elementAt(0)
                                              .productNutritionImage,
                                    ),
                                  ),
                                ),

                                // Text(
                                //   widget.nutritionInfo,
                                //   textAlign: TextAlign.justify,
                                //   style: TextStyle(
                                //     fontSize: 14,
                                //     color: Colors.white,
                                //     fontFamily: "Montserrat",
                                //   ),
                                // ),
                              ],
                            ),
                          ),

                          SizedBox(height: 18),

                          // 8. You May Also Like Product Listing Horizontally
                          if (productDetailResponse!.productMoreList.isNotEmpty)
                            productDetailYouMayLike(
                              productDetailResponse!.productMoreList,
                            ),

                          SizedBox(height: 100),
                        ],
                      ),

                      //product center image
                      productDetailCenterImageRound(
                        productDetailResponse!.productDetail
                            .elementAt(0)
                            .productImage,
                      ),
                    ],
                  ),
                ),
                backButton(_onBackPressed),

                //cart icon with badge
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => //ProductDetail(item: item),
                                CartPage(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 8.0,
                    ),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Badge(
                        largeSize: 16,
                        backgroundColor: Colors.red,
                        label: Text(
                          "1",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Montserrat",
                          ),
                        ),
                        textStyle: TextStyle(fontSize: 16),
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: Image.asset(
                            "icons/my_bag_icon.png",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        //add to cart button
        floatingActionButton:
            _showBottomNavBar
                ? addToCartFullWidthButton(floatingButtonPrice, _onPressed)
                : null,
      );
    });
  }
}
