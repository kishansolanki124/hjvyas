import 'package:flutter/material.dart';

import 'CartHome.dart';
import 'CartWidget.dart';

class MixedListWidget extends StatefulWidget {
  @override
  State<MixedListWidget> createState() => _MixedListWidgetState();
}

class _MixedListWidgetState extends State<MixedListWidget> {

  final List<CartItem> _cartItems = [
    CartItem(
      imageUrl:
          'https://images.pexels.com/photos/1526713/pexels-photo-1526713.jpeg?cs=srgb&dl=pexels-francesco-ungaro-1526713.jpg&fm=jpg&w=4000&h=6000',
      // Replace with your image paths
      title: 'Sweet Kachori',
      pricePerKg: 800.00,
    ),
    CartItem(
      imageUrl:
          'https://images.pexels.com/photos/7276946/pexels-photo-7276946.jpeg?cs=srgb&dl=pexels-rachel-claire-7276946.jpg&fm=jpg&w=3648&h=5472',
      title: 'Luscious Bite Kachori',
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
      title: 'Kala Khatta',
      pricePerKg: 6.8,
    ),
  ];

  // Function to increment item count
  void _incrementCount(int index) {
    setState(() {
      _cartItems[index].count++;
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
    return SafeArea(child: Scaffold(
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

              Text(
                "My Bag",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontFamily: "Montserrat",
                ),
              ),
              // 2. Two-Line Description
              SizedBox(height: 10.0),
              Expanded(
                // Wrap the scrollable part in Expanded
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 3. Vertical List of Strings
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
                      SizedBox(
                        height: 150, // Fixed height for the horizontal list
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _imageList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Image.network(
                                _imageList[index],
                                width: 150,
                                // Fixed width for each image
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      ),);
  }
}

void main() {
  runApp(MaterialApp(home: MixedListWidget()));
}
