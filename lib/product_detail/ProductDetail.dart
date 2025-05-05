import 'dart:async';
import 'dart:convert';

import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hjvyas/cart/CartHome.dart';
import 'package:hjvyas/product_detail/ImageWithProgress.dart';
import 'package:hjvyas/product_detail/ProductDetailController.dart';
import 'package:hjvyas/splash/NoIntternetScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/models/CartItemModel.dart';
import '../api/models/ProductDetailResponse.dart';
import '../api/services/HJVyasApiService.dart';
import '../injection_container.dart';
import '../product/ProductListWidgets.dart';
import '../utils/CommonAppProgress.dart';
import '../utils/FloatingImageViewer.dart';
import '../utils/NetworkImageWithProgress.dart';
import 'AudioFilesDialog.dart';
import 'FullWidthButton.dart';
import 'ProductDetailWidget.dart';

class ProductDetail extends StatefulWidget {
  final String productId;

  final ProductDetailController categoryController = ProductDetailController(
    getIt<HJVyasApiService>(),
  );

  ProductDetail({super.key, required this.productId});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail>
    with TickerProviderStateMixin {
  // Instance of SharedPreferences
  late SharedPreferences _prefs;

  List<CartItemModel> _cartItemList = [];

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
      _cartItemList.clear(); // Clear the existing list before loading
      _cartItemList.addAll(
        stringList
            .map((item) => CartItemModel.fromJson(jsonDecode(item)))
            .toList(),
      );
      if (kDebugMode) {
        print('initial size of _cartItemList is ${_cartItemList.length}');
      }
      //_setMessage('List loaded successfully!');
    } catch (e) {
      //_setMessage('Error loading list: $e'); // Important: show errors to the user
      _cartItemList.clear(); // Clear corrupted data.
      if (kDebugMode) {
        print('initial size of _cartItemList catch is ${_cartItemList.length}');
      }
    }
    setState(() {}); //update
  }

  int getQuantity() {
    int initialQuantity = 0;
    if (kDebugMode) {
      print('_cartItemList size is $_cartItemList');
    }
    if (_cartItemList.isNotEmpty) {
      for (var i = 0; i < _cartItemList.length; i++) {
        //check if item exist in cart, then update quantity only
        if (_cartItemList.elementAt(i).productPackingId ==
            _selectedVariant!.packingId) {
          initialQuantity = int.parse(_cartItemList.elementAt(i).quantity);
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
    int initialQuantity = 0;
    if (kDebugMode) {
      print('_cartItemList size is $_cartItemList');
    }
    if (_cartItemList.isNotEmpty) {
      for (var i = 0; i < _cartItemList.length; i++) {
        //check if item exist in cart, then update quantity only
        if (_cartItemList.elementAt(i).productPackingId ==
            _selectedVariant!.packingId) {
          initialQuantity = int.parse(_cartItemList.elementAt(i).quantity);
          if (kDebugMode) {
            print('initialQuantity is $initialQuantity');
          }
          break;
        }
      }
    }

    selectedItemQuantity = initialQuantity;
    if (null != _selectedVariant) {
      floatingButtonPrice =
          double.parse(_selectedVariant!.productPackingPrice) *
          selectedItemQuantity;
    }
    //});
  }

  Future<void> _addToCart() async {
    if (selectedItemQuantity == 0) {
      bool itemExist = false;
      int itemExistPosition = -1;

      if (_cartItemList.isNotEmpty) {
        for (var i = 0; i < _cartItemList.length; i++) {
          //check if item exist in cart, then update quantity only
          if (_cartItemList.elementAt(i).productPackingId ==
              _selectedVariant!.packingId) {
            //item exist
            itemExist = true;
            itemExistPosition = i;
            if (kDebugMode) {
              print('itemExistPosition addtoCart is $itemExistPosition');
            }
            break;
          }
        }
      }

      if (itemExist && _cartItemList.length > itemExistPosition) {
        _cartItemList.removeAt(itemExistPosition);

        if (kDebugMode) {
          print('_cartItemList is inside addTocart is $_cartItemList');
        }

        final List<String> stringList =
            _cartItemList.map((item) => jsonEncode(item.toJson())).toList();
        await _prefs.setStringList("cart_list", stringList);
        addToCartText = "Add to Cart";
        showSnackbar(context, "Item removed from the cart.");
      } else {
        showSnackbar(context, "Please update quantity to Add to Cart.");
      }
    } else {
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
        print('_cartItemList size addtoCart is ${_cartItemList.length}');
      }

      if (_cartItemList.isNotEmpty) {
        for (var i = 0; i < _cartItemList.length; i++) {
          //check if item exist in cart, then update quantity only
          if (_cartItemList.elementAt(i).productPackingId ==
              _selectedVariant!.packingId) {
            //item exist
            itemExist = true;
            itemExistPosition = i;
            if (kDebugMode) {
              print('itemExistPosition addtoCart is $itemExistPosition');
            }
            break;
          }
        }
      }

      if (itemExist) {
        _cartItemList[itemExistPosition] = cartItemModel;
      } else {
        _cartItemList.add(cartItemModel);
      }

      if (kDebugMode) {
        print('_cartItemList is inside addTocart is $_cartItemList');
      }

      final List<String> stringList =
          _cartItemList.map((item) => jsonEncode(item.toJson())).toList();
      await _prefs.setStringList("cart_list", stringList);
      showSnackbar(context, "Product added to the basket.");
    }
  }

  int _currentImageIndex = 0;

  double floatingButtonPrice = 0;
  int selectedItemQuantity = 0;

  String addToCartText = "Add to Cart";

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

    initCorosoulViewAnimation();

    _cartIconAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _cartIconAnimationController.reverse();
      }
    });

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(
        parent: _cartIconAnimationController,
        curve: Curves.easeOut,
      ),
    );

    _bounceAnimation = Tween<double>(begin: 0.0, end: -8.0).animate(
      CurvedAnimation(
        parent: _cartIconAnimationController,
        curve: Curves.easeOut,
      ),
    );

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
  }

  void initCorosoulViewAnimation() {
    // Initialize animation controller
    _corosoulAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    // Animation starts completely off-screen (offset much larger than -1.0)
    _fromTopSlideAnimation = Tween<Offset>(
      begin: const Offset(0.0, -3.0), // Much higher above the screen
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _corosoulAnimationController,
        curve: Curves.easeOutCubic,
      ),
    );

    // Animation starts completely off-screen (offset much larger than -1.0)
    _fromBottomSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Much higher above the screen
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _corosoulAnimationController,
        curve: Curves.easeOutQuart,
      ),
    );

    // Animation starts completely off-screen (offset much larger than -1.0)
    _fromLeftSlideAnimation = Tween<Offset>(
      begin: const Offset(-3.0, 0.0), // Start from far left, outside
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _corosoulAnimationController,
        curve: Curves.easeOutQuart,
      ),
    );

    // Animation starts completely off-screen (offset much larger than -1.0)
    _fromRightSlideAnimation = Tween<Offset>(
      begin: const Offset(3.0, 0.0), // Start from far right, outside
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _corosoulAnimationController,
        curve: Curves.easeOutQuart,
      ),
    );

    // Ensure the animation starts after the widget is properly built and screen is displayed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(milliseconds: 600), () {
        if (mounted) {
          _corosoulAnimationController.forward();
        }
      });
    });
  }

  @override
  void dispose() {
    _cartIconAnimationController.dispose();
    _corosoulAnimationController.dispose();

    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile No. is required';
    }
    if (value.length < 10) {
      return 'Mobile No. should be at least 10 digits';
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
      showSnackbar(context, _validatePhone(_phoneController.text).toString());
    } else if (_validateEmail(_emailController.text) != null) {
      showSnackbar(context, _validateEmail(_emailController.text).toString());
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

  void _incrementQuantity() {
    if (int.parse(productDetailItem!.productMaxQty) == selectedItemQuantity) {
      showSnackbar(context, "You have added max quantity into cart.");
      return;
    }
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
    if (selectedItemQuantity > 0) {
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
      if (_cartIconAnimationController.status == AnimationStatus.forward) {
        _cartIconAnimationController.reset();
      }
      _cartIconAnimationController.forward();
    });

    setState(() {
      addToCartText = "Add to Cart";
      _addToCart();
      if (kDebugMode) {
        print('Add to Cart button pressed!');
      }
    });
  }

  String getCartText() {
    return addToCartText;
  }

  void _onBackPressed() {
    setState(() {
      Navigator.of(context).pop();
    });
  }

  void navigateToCartPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CartPage()),
    );

    // When returning from Widget2, this code will execute
    if (result != null) {
      _loadList();
    }
  }

  late AnimationController _corosoulAnimationController;
  late Animation<Offset> _fromTopSlideAnimation;
  late Animation<Offset> _fromBottomSlideAnimation;
  late Animation<Offset> _fromLeftSlideAnimation;
  late Animation<Offset> _fromRightSlideAnimation;

  late AnimationController _cartIconAnimationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _bounceAnimation;

  Future<void> fetchData() async {
    widget.categoryController.getProductDetail(widget.productId);
  }

  void _refreshData() {
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (widget.categoryController.error.value.isNotEmpty) {
        return NoInternetScreen(
          onRetry: () {
            _refreshData();
          },
        );
      }

      productDetailResponse ??=
          widget.categoryController.productDetailResponse.value;

      productDetailItem ??= productDetailResponse?.productDetail.elementAt(0);

      if (_selectedVariant == null) {
        _selectedVariant = productDetailResponse?.productPackingList.elementAt(
          0,
        );
        if (_selectedVariant != null) {
          initPriceAndQuantity();
          if (kDebugMode) {
            print('selectedItemQuantity is $selectedItemQuantity');
          }
        }
      }

      // if (floatingButtonPrice == 0) {
      //   floatingButtonPrice = double.parse(
      //     productDetailResponse!.productPackingList
      //         .elementAt(0)
      //         .productPackingPrice,
      //   );
      // }
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
                  child: Stack(
                    children: [
                      if (widget.categoryController.loading.value) ...[
                        getCommonProgressBar(),
                      ],

                      if (!widget.categoryController.loading.value &&
                          productDetailResponse != null) ...[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // 1. Image Carousel with Dots
                            SlideTransition(
                              position: _fromTopSlideAnimation,
                              child: productDetailViewpager(
                                productDetailResponse!.productGalleryList,
                                _onPageChange,
                              ),
                            ),

                            // 2. Image Carousel Dots and volume
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SlideTransition(
                                  position: _fromLeftSlideAnimation,
                                  child: productDetailCorosoulDots(
                                    productDetailResponse!.productGalleryList,
                                    _currentImageIndex,
                                  ),
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
                                        .isNotEmpty) ...[
                                  SlideTransition(
                                    position: _fromRightSlideAnimation,
                                    child: GestureDetector(
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
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),

                        //square border app color
                        IgnorePointer(
                          child: SlideTransition(
                            position: _fromTopSlideAnimation,
                            child: Container(
                              height: 672,
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
                                borderRadius: BorderRadius.all(
                                  Radius.circular(0),
                                ),
                              ),
                            ),
                          ),
                        ),

                        Column(
                          children: [
                            SizedBox(height: 600),

                            //3. name and price
                            // 4. Dropdown of variant and Counter (Horizontal)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 16,
                              ),
                              child: SlideTransition(
                                position: _fromBottomSlideAnimation,
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
                                      productDetailResponse!.productDetail
                                              .elementAt(0)
                                              .productSoldout ==
                                          "yes",
                                    ),

                                    //out of stock
                                    //notify me content
                                    if (productDetailResponse!.productDetail
                                            .elementAt(0)
                                            .productSoldout ==
                                        "yes")
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
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: _phoneController,
                                            keyboardType: TextInputType.number,
                                            maxLength: 14,
                                            inputFormatters:
                                                <TextInputFormatter>[
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

                                              contentPadding: EdgeInsets.all(8),
                                              isDense:
                                                  true, //make textfield compact
                                            ),
                                          ),

                                          // 6. Input text or Edit text with hint "Enter your email id"
                                          // with input type email
                                          TextField(
                                            textInputAction:
                                                TextInputAction.done,
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
                                                    child:
                                                        CircularProgressIndicator(
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
                                        if (productDetailResponse!.productDetail
                                                .elementAt(0)
                                                .productSoldout !=
                                            "yes")
                                          productDetailDropDown(
                                            productDetailResponse!
                                                .productPackingList,
                                            _selectedVariant,
                                            _onChangedDropDownValue,
                                          ),

                                        if (productDetailResponse!.productDetail
                                                .elementAt(0)
                                                .productSoldout !=
                                            "yes")
                                          productDetailItemCounter(
                                            _decrementQuantity,
                                            _incrementQuantity,
                                            selectedItemQuantity,
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // 5. Horizontal List of Square Images of Product Ingredients
                            if (productDetailResponse!
                                .productIngredientsList
                                .isNotEmpty)
                              productDetailIngredients(
                                productDetailResponse!.productIngredientsList,
                              ),

                            //Product Terms
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
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

                            //tabs content
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
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
                                  // Nutrition Info Tab (tab 2)
                                  GestureDetector(
                                    onTap: () {
                                      showImageViewer(
                                        context,
                                        productDetailItem!
                                            .productNutritionImage,
                                      );
                                    },
                                    child: SizedBox(
                                      height: 200,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 8.0,
                                        ),
                                        child: ImageWithProgress(
                                          imageURL:
                                              productDetailResponse!
                                                  .productDetail
                                                  .elementAt(0)
                                                  .productNutritionImage,
                                        ),
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

                            // 8. You May Also Like Product Listing Horizontally
                            if (productDetailResponse!
                                .productMoreList
                                .isNotEmpty)
                              productDetailYouMayLike(
                                productDetailResponse!.productMoreList,
                              ),

                            SizedBox(height: 50),
                          ],
                        ),
                        SlideTransition(
                          position: _fromBottomSlideAnimation,
                          child: productDetailCenterImageRound(
                            productDetailResponse!.productDetail
                                .elementAt(0)
                                .productImage,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                SlideTransition(
                  position: _fromLeftSlideAnimation,
                  child: backButton(_onBackPressed),
                ),

                // //cart icon with badge
                // GestureDetector(
                //   onTap: () {
                //     navigateToCartPage();
                //   },
                //   child: Padding(
                //     padding: EdgeInsets.symmetric(
                //       horizontal: 20.0,
                //       vertical: 8.0,
                //     ),
                //     child: Align(
                //       alignment: Alignment.topRight,
                //       child: Badge(
                //         largeSize: 16,
                //         backgroundColor:
                //             _cartItemList.isEmpty
                //                 ? Colors.transparent
                //                 : Colors.red,
                //         label: Text(
                //           _cartItemList.isEmpty
                //               ? ""
                //               : _cartItemList.length.toString(),
                //           style: TextStyle(
                //             fontSize: 10,
                //             fontWeight: FontWeight.w700,
                //             fontFamily: "Montserrat",
                //           ),
                //         ),
                //         textStyle: TextStyle(fontSize: 16),
                //         child: SizedBox(
                //           width: 30,
                //           height: 30,
                //           child: Image.asset(
                //             "icons/my_bag_icon.png",
                //             color: Colors.white,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                SlideTransition(
                  position: _fromRightSlideAnimation,
                  child: GestureDetector(
                    onTap: () {
                      navigateToCartPage();
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: AnimatedBuilder(
                          animation: _cartIconAnimationController,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(0, _bounceAnimation.value),
                              child: Transform.scale(
                                scale: _scaleAnimation.value,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Icon(
                                      Icons.shopping_cart,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                    if (_cartItemList.isNotEmpty)
                                      Positioned(
                                        right: -5,
                                        top: -5,
                                        child: Container(
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                          ),
                                          constraints: BoxConstraints(
                                            minWidth: 18,
                                            minHeight: 18,
                                          ),
                                          child: Center(
                                            child: Text(
                                              '${_cartItemList.length}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
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
            productDetailResponse?.productDetail.elementAt(0).productSoldout !=
                    "yes"
                ? SlideTransition(
                  position: _fromBottomSlideAnimation,
                  child: addToCartFullWidthButton(
                    floatingButtonPrice,
                    _onPressed,
                    getCartText(),
                  ),
                )
                : null,
      );
    });
  }
}
