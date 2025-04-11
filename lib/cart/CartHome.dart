import 'package:flutter/material.dart';

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
  // Sample cart data
  final List<CartItem> _cartItems = [
    CartItem(
      imageUrl:
          'https://images.pexels.com/photos/1526713/pexels-photo-1526713.jpeg?cs=srgb&dl=pexels-francesco-ungaro-1526713.jpg&fm=jpg&w=4000&h=6000',
      // Replace with your image paths
      title: 'Fresh Apples',
      pricePerKg: 2.5,
    ),
    CartItem(
      imageUrl:
          'https://images.pexels.com/photos/7276946/pexels-photo-7276946.jpeg?cs=srgb&dl=pexels-rachel-claire-7276946.jpg&fm=jpg&w=3648&h=5472',
      title: 'Organic Bananas',
      pricePerKg: 1.8,
    ),
    CartItem(
      imageUrl:
          'https://images.pexels.com/photos/1496373/pexels-photo-1496373.jpeg?cs=srgb&dl=pexels-arts-1496373.jpg&fm=jpg',
      title: 'Juicy Oranges',
      pricePerKg: 3.0,
    ),
    CartItem(
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/11/29/05/45/astronomy-1867616_1280.jpg',
      title: 'Sweet Grapes',
      pricePerKg: 4.2,
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
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            //Background Image
            Image.asset(
              'images/bg.jpg', // Replace with your image path
              fit: BoxFit.cover, // Cover the entire screen
              width: double.infinity,
              height: double.infinity,
            ),

            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //title My Bag
                  Text(
                    "My Bag",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontFamily: "Montserrat",
                    ),
                  ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: ListView.builder(
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
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
