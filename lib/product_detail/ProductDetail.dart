import 'package:flutter/material.dart';

import 'ProductDetailWidget.dart';

class ProductDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FoodProductDetailsPage(
        productName: "Delicious Chocolate Cake",
        imageUrls: [
          "https://images.pexels.com/photos/1496373/pexels-photo-1496373.jpeg?cs=srgb&dl=pexels-arts-1496373.jpg&fm=jpg",
          "https://images.pexels.com/photos/7276946/pexels-photo-7276946.jpeg?cs=srgb&dl=pexels-rachel-claire-7276946.jpg&fm=jpg&w=3648&h=5472",
          "https://cdn.pixabay.com/photo/2016/11/29/05/45/astronomy-1867616_1280.jpg",
          "https://picsum.photos/id/6/400/800",
          "https://images.pexels.com/photos/1526713/pexels-photo-1526713.jpeg?cs=srgb&dl=pexels-francesco-ungaro-1526713.jpg&fm=jpg&w=4000&h=6000",
        ],
        productPrice: 25.99,
        productDescription:
            "Indulge in our rich and decadent chocolate cake, made with the finest cocoa and topped with a luscious ganache. Perfect for any celebration or a sweet treat.",
        availableColors: ["Chocolate", "Vanilla", "Red Velvet"],
        ingredientImageUrls: [
          "https://via.placeholder.com/50/A0522D/FFFFFF?Text=Cocoa",
          "https://via.placeholder.com/50/F0F8FF/000?Text=Flour",
          "https://via.placeholder.com/50/FFFF00/000?Text=Sugar",
          "https://via.placeholder.com/50/FFFFFF/000?Text=Eggs",
          "https://via.placeholder.com/50/FFD700/000?Text=Butter",
        ],
        reviews: [
          {"user": "Alice", "comment": "Absolutely loved this cake!"},
          {"user": "Bob", "comment": "So moist and flavorful."},
        ],
        nutritionInfo: [
          {"name": "Calories", "value": "350 kcal"},
          {"name": "Fat", "value": "15g"},
          {"name": "Sugar", "value": "30g"},
        ],
        youMayLikeProducts: [
          {
            "name": "Strawberry Tart",
            "imageUrl":
                "https://via.placeholder.com/100/FF69B4/FFFFFF?Text=Tart",
          },
          {
            "name": "Blueberry Muffin",
            "imageUrl":
                "https://via.placeholder.com/100/4169E1/FFFFFF?Text=Muffin",
          },
          {
            "name": "Chocolate Brownie",
            "imageUrl":
                "https://via.placeholder.com/100/8B4513/FFFFFF?Text=Brownie",
          },
        ],
      ),
    );
  }
}

class FoodProductDetailsPage extends StatefulWidget {
  final String productName;
  final List<String> imageUrls;
  final double productPrice;
  final String productDescription;
  final List<String> availableColors;
  final List<String> ingredientImageUrls;
  final List<Map<String, String>> reviews;
  final List<Map<String, String>> nutritionInfo;
  final List<Map<String, String>> youMayLikeProducts;

  FoodProductDetailsPage({
    required this.productName,
    required this.imageUrls,
    required this.productPrice,
    required this.productDescription,
    this.availableColors = const [],
    this.ingredientImageUrls = const [],
    this.reviews = const [],
    this.nutritionInfo = const [],
    this.youMayLikeProducts = const [],
  });

  @override
  _FoodProductDetailsPageState createState() => _FoodProductDetailsPageState();
}

class _FoodProductDetailsPageState extends State<FoodProductDetailsPage>
    with TickerProviderStateMixin {
  int _currentImageIndex = 0;
  String? _selectedColor;
  int _quantity = 1;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    if (widget.availableColors.isNotEmpty) {
      _selectedColor = widget.availableColors.first;
    }
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // 1. Image Carousel with Dots
              productDetailViewpager(widget, _onPageChange),

              Padding(padding: EdgeInsetsDirectional.fromSTEB(20, 20, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:
                widget.imageUrls.asMap().entries.map((entry) {
                  return Container(
                    width: _currentImageIndex == entry.key ? 12.0 : 8.0,
                    height: _currentImageIndex == entry.key ? 12.0 : 8.0,
                    margin: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 2.0,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                      _currentImageIndex == entry.key
                          ? Color.fromARGB(255, 230, 12, 11)
                          : Color.fromARGB(255, 179, 179, 179),
                    ),
                  );
                }).toList(),
              ),),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // 2. Product Title in the Center
                    Text(
                      widget.productName,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),

                    // 3. Product Price
                    Text(
                      '\$${widget.productPrice.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 22, color: Colors.green[700]),
                    ),
                    SizedBox(height: 16),

                    // 4. Dropdown of Color and Counter (Horizontal)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        if (widget.availableColors.isNotEmpty)
                          DropdownButton<String>(
                            value: _selectedColor,
                            hint: Text('Select Color'),
                            items:
                                widget.availableColors.map((String color) {
                                  return DropdownMenuItem<String>(
                                    value: color,
                                    child: Text(color),
                                  );
                                }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedColor = newValue;
                              });
                            },
                          ),
                        Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: _decrementQuantity,
                            ),
                            Text('$_quantity', style: TextStyle(fontSize: 18)),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: _incrementQuantity,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),

              // 5. Horizontal List of Square Images of Product Ingredients
              if (widget.ingredientImageUrls.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Ingredients',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    SizedBox(
                      height: 80, // Adjust height as needed
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        itemCount: widget.ingredientImageUrls.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: Image.network(
                                widget.ingredientImageUrls[index],
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Center(child: Text('Err'));
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),

              // 6. Product Description
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      widget.productDescription,
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ),

              // 7. Tab Layout with Two Tabs
              TabBar(
                controller: _tabController,
                tabs: [
                  Tab(text: 'Reviews (${widget.reviews.length})'),
                  Tab(text: 'Nutrition Info'),
                ],
              ),
              Container(
                height: 200, // Adjust height as needed for tab content
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Reviews Tab
                    ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: widget.reviews.length,
                      itemBuilder: (context, index) {
                        final review = widget.reviews[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                review['user'] ?? 'Anonymous',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 4),
                              Text(review['comment'] ?? 'No comment'),
                            ],
                          ),
                        );
                      },
                    ), // Nutrition Info Tab
                    ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: widget.nutritionInfo.length,
                      itemBuilder: (context, index) {
                        final nutrient = widget.nutritionInfo[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(nutrient['name'] ?? ''),
                              Text(nutrient['value'] ?? ''),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),

              // 8. You May Also Like Product Listing Horizontally
              if (widget.youMayLikeProducts.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'You May Also Like',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    SizedBox(
                      height: 120, // Adjust height as needed
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        itemCount: widget.youMayLikeProducts.length,
                        itemBuilder: (context, index) {
                          final product = widget.youMayLikeProducts[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Container(
                              width: 100,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (product['imageUrl'] != null)
                                    Image.network(
                                      product['imageUrl']!,
                                      height: 60,
                                      fit: BoxFit.cover,
                                      errorBuilder: (
                                        context,
                                        error,
                                        stackTrace,
                                      ) {
                                        return SizedBox(
                                          height: 60,
                                          child: Center(child: Text('Err')),
                                        );
                                      },
                                    ),
                                  SizedBox(height: 8),
                                  Text(
                                    product['name'] ?? 'Product',
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 32),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
