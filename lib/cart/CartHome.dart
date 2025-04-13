import 'package:flutter/material.dart';
import 'package:hjvyas/checkout/Checkout.dart';

import '../product_detail/FullWidthButton.dart';
import '../product_detail/NetworkImageWithLoading.dart';
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
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int freeSelectedIndex = -1;

  // Sample cart data
  final List<CartItem> _cartItems = [
    CartItem(
      imageUrl:
          'https://images.pexels.com/photos/1526713/pexels-photo-1526713.jpeg?cs=srgb&dl=pexels-francesco-ungaro-1526713.jpg&fm=jpg&w=4000&h=6000',
      // Replace with your image paths
      title: 'Sweet Kachori',
      pricePerKg: 11500.00,
    ),
    CartItem(
      imageUrl:
          'https://images.pexels.com/photos/7276946/pexels-photo-7276946.jpeg?cs=srgb&dl=pexels-rachel-claire-7276946.jpg&fm=jpg&w=3648&h=5472',
      title: 'Luscious Bite Kachori and Jalebi',
      pricePerKg: 1800.00,
    ),
    CartItem(
      imageUrl:
          'https://images.pexels.com/photos/1496373/pexels-photo-1496373.jpeg?cs=srgb&dl=pexels-arts-1496373.jpg&fm=jpg',
      title: 'Kaju Katri',
      pricePerKg: 2300.00,
    ),
    CartItem(
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/11/29/05/45/astronomy-1867616_1280.jpg',
      title: 'Mung Mixture',
      pricePerKg: 348.00,
    ),
    CartItem(
      imageUrl: 'https://picsum.photos/id/6/400/800',
      title: 'Samosa Small',
      pricePerKg: 50,
    ),
  ];

  final List<String> _imageList = [
    'https://picsum.photos/id/6/400/800',
    'https://picsum.photos/id/1/400/800',
    'https://picsum.photos/id/2/400/800',
    'https://picsum.photos/id/3/400/800',
    'https://picsum.photos/id/4/400/800',
  ];

  final List<String> _itemNameList = [
    'Jamnagri Standard Kachori style Kachori style',
    'Jamnagari Chewda',
    'Masala Gathiya',
    'Bhavnagari Gathiya',
    'Kutchi Pakwan',
  ];

  // Function to increment item count
  void _incrementCount(int index) {
    setState(() {
      _cartItems[index].count++;
    });
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
    setState(() {
      if (_cartItems[index].count > 1) {
        _cartItems[index].count--;
      }
    });
  }

  // Function to remove item from cart
  void _removeItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
  }

  // Function to format price
  String _formatPrice(double price) {
    return "₹ $price";
  }

  @override
  Widget build(BuildContext context) {
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
                          itemCount: _cartItems.length,
                          itemBuilder: (context, index) {
                            final cartItem = _cartItems[index];
                            return CartItemWidget(
                              index,
                              cartItem,
                              _formatPrice,
                              _decrementCount,
                              _incrementCount,
                              _removeItem,
                            );
                          },
                        ),

                        SizedBox(height: 16.0), // 4. Horizontal List of Images
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

                        SizedBox(height: 10),

                        Text(
                          "Please Select Anyone Free Product Tester & Proceed To Checkout Below",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: "Montserrat",
                          ),
                        ),

                        SizedBox(height: 10),

                        //horizontal list of free products
                        SizedBox(
                          height: 230, // Fixed height for the horizontal list
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _imageList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  _updateFreeSelectedIndex(index);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          //product image
                                          Padding(
                                            padding: EdgeInsets.all(4),
                                            child: SizedBox(
                                              width: 150,
                                              height: 150,
                                              child: NetworkImageWithLoading(
                                                imageUrl: _imageList[index],
                                              ),
                                            ),
                                          ),

                                          //product text
                                          SizedBox(
                                            width: 150,
                                            height: 40,
                                            child: Center(
                                              child: Text(
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                "${_itemNameList[index]}",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Montserrat",
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      //background border
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Color.fromARGB(
                                                255,
                                                123,
                                                138,
                                                195,
                                              ),
                                              width: 1.0,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              0,
                                            ),
                                          ),
                                          width: 166,
                                          height: 210,
                                        ),
                                      ),

                                      //bottom selector default
                                      if (freeSelectedIndex != index)
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            width: 35,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color.fromARGB(
                                                255,
                                                31,
                                                47,
                                                80,
                                              ),
                                            ),
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                                border: Border.all(
                                                  width: 5,
                                                  color: Color.fromARGB(
                                                    255,
                                                    31,
                                                    47,
                                                    80,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                      //bottom selector selected
                                      if (freeSelectedIndex == index)
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            width: 33,
                                            height: 33,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                            ),
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color.fromARGB(
                                                  255,
                                                  31,
                                                  47,
                                                  80,
                                                ),
                                                border: Border.all(
                                                  width: 2,
                                                  color: Colors.white,
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
  }
}
