import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:flutter/material.dart';

import '../product/ProductListWidgets.dart';
import 'FullWidthButton.dart';
import 'ProductDetailWidget.dart';

class ProductDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        productPrice: "₹ 3000.00 (1 KG)",
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
            "name": "Masala Gathiya",
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
  int _currentImageIndex = 0;
  String? _selectedVariant;
  int _quantity = 1;
  late TabController _tabController;
  int activeTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2, //initialIndex : 0,
      vsync: this,
    );
    if (widget.availableColors.isNotEmpty) {
      _selectedVariant = widget.availableColors.first;
    }

    _tabController.addListener(() {
      setState(() {
        activeTabIndex = _tabController.index;
      });
    });
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _onChangedDropDownValue(String newValue) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text(widget.productName)),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // 1. Image Carousel with Dots
                  productDetailViewpager(widget, _onPageChange),

                  // 2. Image Carousel Dots
                  productDetailCorosoulDots(widget, _currentImageIndex),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        //name and price
                        productDetailNameAndPrice(widget),

                        // 4. Dropdown of variant and Counter (Horizontal)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            if (widget.availableColors.isNotEmpty)
                              productDetailDropDown(
                                widget,
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
                    productDetailIngredients(widget),

                  //description
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Spices & Condiments Sugar, Iodized Salt, Citric Acid, Asafoetida & Bayleaf.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontFamily: "Montserrat",
                      ),
                    ),
                  ),

                  //Product Terms
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Terms :',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          widget.productDescription,
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
                        // Reviews Tab
                        Text(
                          widget.reviews,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontFamily: "Montserrat",
                          ),
                        ), // Nutrition Info Tab
                        Text(
                          widget.nutritionInfo,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontFamily: "Montserrat",
                          ),
                        ),
                      ],
                    ),
                  ), //),

                  SizedBox(height: 24),

                  // 8. You May Also Like Product Listing Horizontally
                  if (widget.youMayLikeProducts.isNotEmpty)
                    productDetailYouMayLike(widget),

                  SizedBox(height: 100),
                ],
              ),

              productDetailCenterImageRound(),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,//todo change this
      floatingActionButton: addToCartFullWidthButton("1800.00", _onPressed),
    );
  }
}
