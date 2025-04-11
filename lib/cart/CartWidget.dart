import 'package:flutter/material.dart';

Widget CartItemWidget(
  index,
  cartItem,
  _formatPrice,
  _decrementCount,
  _incrementCount,
  _removeItem,
) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: <Widget>[
        // 1. Fixed Width and Height Image
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
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
        SizedBox(width: 16.0), // Expanded for the right side content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // 2. Product Title
              Text(
                cartItem.title,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4.0),
              // 3. Price per Weight
              Text(
                '${_formatPrice(cartItem.pricePerKg)} / KG',
                style: TextStyle(fontSize: 14.0, color: Colors.grey),
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
}
