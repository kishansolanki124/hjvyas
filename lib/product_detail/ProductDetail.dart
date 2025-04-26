import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hjvyas/product_detail/ImageWithProgress.dart';
import 'package:hjvyas/product_detail/ProductDetailController.dart';

import '../api/models/ProductDetailResponse.dart';
import '../api/services/HJVyasApiService.dart';
import '../injection_container.dart';
import '../product/ProductListWidgets.dart';
import 'FullWidthButton.dart';
import 'ProductDetailWidget.dart';

class ProductDetail extends StatefulWidget {
  final String parentPrice;

  ProductDetail({required this.parentPrice});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    String price = widget.parentPrice;
    return Scaffold(
      body: FoodProductDetailsPage(
        productName: "Luscious Bite",
        imageUrls: [
          "https://images.pexels.com/photos/1496373/pexels-photo-1496373.jpeg?cs=srgb&dl=pexels-arts-1496373.jpg&fm=jpg",
          "https://images.pexels.com/photos/7276946/pexels-photo-7276946.jpeg?cs=srgb&dl=pexels-rachel-claire-7276946.jpg&fm=jpg&w=3648&h=5472",
          "https://cdn.pixabay.com/photo/2016/11/29/05/45/astronomy-1867616_1280.jpg",
          "https://picsum.photos/id/6/400/800",
          "https://images.pexels.com/photos/1526713/pexels-photo-1526713.jpeg?cs=srgb&dl=pexels-francesco-ungaro-1526713.jpg&fm=jpg&w=4000&h=6000",
        ],
        productPrice: price,
        productDescription:
            "Prices are Inclusive of Taxes & Exclusive of Shipping Charges. Make Sure it Takes 3 to 4 Days to Reach the Delivery Address after Dispatch 1  from Your Order. Depends on the State, City & Location of Your Delivery Address. Maybe it's Take More Days to Delivered in India & 7-8 Business Days in Abroad",
        availableColors: [
          "300 GM (900.00) - 12 Pieces",
          "150 GM (450.00) - 6 Pieces",
          "100 GM (400.00) - 4 Pieces",
        ],
        ingredientImageUrls: [
          "https://www.mithaiwalahjvyas.com/uploads/ingredients_img/7-Asafoetida.jpg",
          "https://img.lovepik.com/png/20231110/mayo-clipart-cartoon-illustration-of-various-food-items-and-dressings_553233_wh300.png",
          "https://via.placeholder.com/50/FFFF00/000?Text=Sugar",
          "https://via.placeholder.com/50/FFFFFF/000?Text=Eggs",
          "https://via.placeholder.com/50/FFD700/000?Text=Butter",
        ],
        reviews:
            "A guaranteed taste, aroma & freshness for 300 days. 7 different kinds of dry fruits give it a very unique sweet & sour taste. Deep fried in pure peanut oil with a thin layer of fine wheat flour. An irresistible zero-cholesterol kachori",
        nutritionInfo:
            "nutritionInfo: A guaranteed taste, aroma & freshness for 300 days. 7 different kinds of dry fruits give it a very unique sweet & sour taste. Deep fried in pure peanut oil with a thin layer of fine wheat flour. An irresistible zero-cholesterol kachori",
        youMayLikeProducts: [
          {
            "name": "Standard Kachori",
            "imageUrl": "https://picsum.photos/id/2/400/800",
          },
          {
            "name": "Jamnagari Chevda",
            "imageUrl": "https://picsum.photos/id/3/400/800",
          },
          {
            "name": "Ahmedabad special Masala Gathiya",
            "imageUrl": "https://picsum.photos/id/4/400/800",
          },
          {
            "name": "Kutchi Pakwan",
            "imageUrl": "https://picsum.photos/id/5/400/800",
          },
        ],
      ),
    );
  }
}

class FoodProductDetailsPage extends StatefulWidget {
  final ProductDetailController categoryController = ProductDetailController(
    getIt<HJVyasApiService>(),
  );

  final String productName;
  final List<String> imageUrls;
  final String productPrice;
  final String productDescription;
  final List<String> availableColors;
  final List<String> ingredientImageUrls;
  final String reviews;
  final String nutritionInfo;
  final List<Map<String, String>> youMayLikeProducts;

  FoodProductDetailsPage({
    required this.productName,
    required this.imageUrls,
    required this.productPrice,
    required this.productDescription,
    this.availableColors = const [],
    this.ingredientImageUrls = const [],
    this.reviews = "",
    this.nutritionInfo = "",
    this.youMayLikeProducts = const [],
  });

  @override
  _FoodProductDetailsPageState createState() => _FoodProductDetailsPageState();
}

class _FoodProductDetailsPageState extends State<FoodProductDetailsPage>
    with TickerProviderStateMixin {
  bool _showBottomNavBar = true; //BottomNavigationBar visibility

  int _currentImageIndex = 0;

  //String? _selectedVariant;
  ProductPackingListItem? _selectedVariant;
  int _quantity = 1;
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
    // if (widget.availableColors.isNotEmpty) {
    //   _selectedVariant = widget.availableColors.first;
    // }

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
      _quantity++;
    });
  }

  void _onChangedDropDownValue(ProductPackingListItem newValue) {
    setState(() {
      _selectedVariant = newValue;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
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
      print('Add to Cart button pressed!');
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
      //_selectedVariantInquiry ??= cateogories.inquiryType.split(', ').first;
      return Scaffold(
        //appBar: AppBar(title: Text(widget.productName)),
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
                                productDetailResponse.productGalleryList,
                                _currentImageIndex,
                              ),
                              Padding(
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
                            ],
                          ),
                        ],
                      ),

                      //square border app color
                      IgnorePointer(
                        child: Container(
                          height: 480,
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
                          SizedBox(height: 400),

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
                                if (widget.productPrice.isNotEmpty)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      if (widget.availableColors.isNotEmpty)
                                        productDetailDropDown(
                                          productDetailResponse
                                              .productPackingList,
                                          _selectedVariant,
                                          _onChangedDropDownValue,
                                        ),

                                      productDetailItemCounter(
                                        widget,
                                        _decrementQuantity,
                                        _incrementQuantity,
                                        _quantity,
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),

                          // 5. Horizontal List of Square Images of Product Ingredients
                          if (widget.ingredientImageUrls.isNotEmpty)
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
                          if (widget.youMayLikeProducts.isNotEmpty)
                            productDetailYouMayLike(
                              productDetailResponse.productMoreList,
                            ),

                          SizedBox(height: 100),
                        ],
                      ),

                      productDetailCenterImageRound(
                        productDetailResponse.productDetail
                            .elementAt(0)
                            .productImage,
                      ),
                    ],
                  ),
                ),
                backButton(_onBackPressed),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:
            _showBottomNavBar
                ? addToCartFullWidthButton("1800.00", _onPressed)
                : null,
      );
    });
  }
}
