import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hjvyas/cart/CartHome.dart';
import 'package:hjvyas/product_detail/ImageWithProgress.dart';
import 'package:hjvyas/product_detail/ProductDetailController.dart';

import '../api/models/ProductDetailResponse.dart';
import '../api/services/HJVyasApiService.dart';
import '../injection_container.dart';
import '../product/ProductListWidgets.dart';
import 'AudioFilesDialog.dart';
import 'FullWidthButton.dart';
import 'ProductDetailWidget.dart';

class ProductDetail extends StatefulWidget {
  final String parentPrice;

  const ProductDetail({required this.parentPrice});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    String price = widget.parentPrice;
    return Scaffold(body: FoodProductDetailsPage());
  }
}

class FoodProductDetailsPage extends StatefulWidget {
  final ProductDetailController categoryController = ProductDetailController(
    getIt<HJVyasApiService>(),
  );

  FoodProductDetailsPage();

  @override
  _FoodProductDetailsPageState createState() => _FoodProductDetailsPageState();
}

class _FoodProductDetailsPageState extends State<FoodProductDetailsPage>
    with TickerProviderStateMixin {
  bool _showBottomNavBar = true; //BottomNavigationBar visibility

  int _currentImageIndex = 0;

  double floatingButtonPrice = 0;
  int selectedItemQuantity = 1;

  ProductPackingListItem? _selectedVariant;

  late TabController _tabController;
  int activeTabIndex = 0;

  @override
  void initState() {
    super.initState();
    //todo change this product id
    widget.categoryController.getProductDetail("2"); // Explicit call

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
    super.dispose();
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

  // Example usage:
  void showAudioFilesDialog(
    BuildContext context,
    ProductDetailResponse productDetailResponse,
  ) {
    List<String> audioTitles = [];
    List<String> audioFiles = [];

    if (productDetailResponse.productDetail
        .elementAt(0)
        .productAudioEnglish
        .isNotEmpty) {
      audioFiles.add(
        productDetailResponse.productDetail.elementAt(0).productAudioEnglish,
      );
      audioTitles.add("English");
    }

    if (productDetailResponse.productDetail
        .elementAt(0)
        .productAudioHindi
        .isNotEmpty) {
      audioFiles.add(
        productDetailResponse.productDetail.elementAt(0).productAudioHindi,
      );
      audioTitles.add("Hindi");
    }

    if (productDetailResponse.productDetail
        .elementAt(0)
        .productAudioGujarati
        .isNotEmpty) {
      audioFiles.add(
        productDetailResponse.productDetail.elementAt(0).productAudioGujarati,
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

      final productDetailResponse =
          widget.categoryController.productDetailResponse.value;

      _selectedVariant ??= productDetailResponse!.productPackingList.elementAt(
        0,
      );

      if (floatingButtonPrice == 0) {
        floatingButtonPrice = double.parse(
          productDetailResponse!.productPackingList!
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
                          //todo: volume button click audio play option
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              productDetailCorosoulDots(
                                productDetailResponse.productGalleryList,
                                _currentImageIndex,
                              ),
                              //volume or audio icon
                              //todo: handle visibility of this icon if no audio files available
                              GestureDetector(
                                onTap: () {
                                  showAudioFilesDialog(
                                    context,
                                    productDetailResponse,
                                  );
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
                                  productDetailResponse.productDetail
                                      .elementAt(0)
                                      .productName,
                                  productDetailResponse.productDetail
                                      .elementAt(0)
                                      .productPrice,
                                ),

                                // 4. Dropdown of variant and Counter (Horizontal)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    //todo: update this for out of stock
                                    //if (widget.availableColors.isNotEmpty)
                                    productDetailDropDown(
                                      productDetailResponse.productPackingList,
                                      _selectedVariant,
                                      _onChangedDropDownValue,
                                    ),

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
                          if (productDetailResponse
                              .productIngredientsList
                              .isNotEmpty)
                            productDetailIngredients(
                              productDetailResponse.productIngredientsList,
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
                                  productDetailResponse.productDetail
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
                                      productDetailResponse.productDetail
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
                                ),
                                // Text(
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

                                //todo: change this image size and make it zoomable
                                SizedBox(
                                  height: 200,
                                  child: ImageWithProgress(
                                    imageURL:
                                        productDetailResponse.productDetail
                                            .elementAt(0)
                                            .productNutritionImage,
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
                          if (productDetailResponse.productMoreList.isNotEmpty)
                            productDetailYouMayLike(
                              productDetailResponse.productMoreList,
                            ),

                          SizedBox(height: 100),
                        ],
                      ),

                      //product center image
                      productDetailCenterImageRound(
                        productDetailResponse.productDetail
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
