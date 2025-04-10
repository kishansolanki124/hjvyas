import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for NumberFormat

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
      imageUrl: 'https://images.pexels.com/photos/1526713/pexels-photo-1526713.jpeg?cs=srgb&dl=pexels-francesco-ungaro-1526713.jpg&fm=jpg&w=4000&h=6000', // Replace with your image paths
      title: 'Fresh Apples',
      pricePerKg: 2.5,
    ),
    CartItem(
      imageUrl: 'https://images.pexels.com/photos/7276946/pexels-photo-7276946.jpeg?cs=srgb&dl=pexels-rachel-claire-7276946.jpg&fm=jpg&w=3648&h=5472',
      title: 'Organic Bananas',
      pricePerKg: 1.8,
    ),
    CartItem(
      imageUrl: 'https://images.pexels.com/photos/1496373/pexels-photo-1496373.jpeg?cs=srgb&dl=pexels-arts-1496373.jpg&fm=jpg',
      title: 'Juicy Oranges',
      pricePerKg: 3.0,
    ),
    CartItem(
      imageUrl: 'https://cdn.pixabay.com/photo/2016/11/29/05/45/astronomy-1867616_1280.jpg',
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _cartItems.length,
          itemBuilder: (context, index) {
            final cartItem = _cartItems[index];
            return Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: <Widget>[
                  // 1. Fixed Width and Height Image
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Image.network(
                      cartItem.imageUrl, // Use NetworkImage
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        // Handle errors, e.g., show a placeholder
                        return Container(
                          color: Colors.grey[300], // Or any error indicator
                          child: Center(child: Text('Error')),
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 16.0),
                  // Expanded for the right side content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // 2. Product Title
                        Text(
                          cartItem.title,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        // 3. Price per Weight
                        Text(
                          '${_formatPrice(cartItem.pricePerKg)} / KG',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        // 4. "+" and "-" Buttons with Count
                        Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () => _decrementCount(index),
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              cartItem.count.toString(),
                              style: TextStyle(fontSize: 16.0),
                            ),
                            SizedBox(width: 8.0),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () => _incrementCount(index),
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        // 5. Total Price and Delete Icon
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Total: ${_formatPrice(cartItem.totalPrice)}',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete_outline),
                              onPressed: () => _removeItem(index),
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
