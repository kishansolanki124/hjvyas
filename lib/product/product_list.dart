import 'package:flutter/material.dart';

import 'GridItem.dart';
import 'GridOddItem.dart';

class TwoItemGridView extends StatelessWidget {
  final List<Map<String, String>> items;

  TwoItemGridView({required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: (1 / 2),
      children:
          items.indexed.map((item) {
            final (index, value) = item;

            if (index % 2 == 0) {
              return GridItem(
                imageUrl: value['imageUrl']!,
                title: value['title']!,
                description: value['description']!,
              );
            } else {
              return GridOddItem(
                imageUrl: value['imageUrl']!,
                title: value['title']!,
                description: value['description']!,
              );
            }
          }).toList(),
    );
  }
}

class GridStateless extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: TwoItemGridView(
            items: [
              {
                'imageUrl':
                    'https://images.unsplash.com/photo-1518791841217-8f162f1e1131?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
                'title': 'Mawa Kachori and Mawa Malai',
                'description': 'A sweet and savory Indian snack.',
              },
              {
                'imageUrl':
                    'https://images.pexels.com/photos/7276946/pexels-photo-7276946.jpeg?cs=srgb&dl=pexels-rachel-claire-7276946.jpg&fm=jpg&w=3648&h=5472',
                'title': 'Sweet Chilly Kachori',
                'description': 'Description for another item.',
              },
              {
                'imageUrl':
                    'https://images.pexels.com/photos/1526713/pexels-photo-1526713.jpeg?cs=srgb&dl=pexels-francesco-ungaro-1526713.jpg&fm=jpg&w=4000&h=6000',
                'title': 'Standard Kachori',
                'description': 'A short description.',
              },
              {
                'imageUrl': 'https://picsum.photos/id/5/400/800',
                'title': 'Hot & Spicy kachori',
                'description': '₹ 900.00 - 300 gram',
              },
              {
                'imageUrl':
                    'https://images.unsplash.com/photo-1518791841217-8f162f1e1131?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
                'title': 'Mawa Kachori',
                'description': 'A sweet and savory Indian snack.',
              },
              {
                'imageUrl':
                    'https://images.pexels.com/photos/7276946/pexels-photo-7276946.jpeg?cs=srgb&dl=pexels-rachel-claire-7276946.jpg&fm=jpg&w=3648&h=5472',
                'title': 'Sweet Chilly Kachori',
                'description': 'Description for another item.',
              },
              {
                'imageUrl':
                    'https://images.pexels.com/photos/1526713/pexels-photo-1526713.jpeg?cs=srgb&dl=pexels-francesco-ungaro-1526713.jpg&fm=jpg&w=4000&h=6000',
                'title': 'Standard Kachori',
                'description': 'A short description.',
              },
              {
                'imageUrl': 'https://picsum.photos/id/5/400/800',
                'title': 'Hot & Spicy kachori',
                'description': '₹ 900.00 - 300 gram',
              },
              {
                'imageUrl':
                    'https://images.unsplash.com/photo-1518791841217-8f162f1e1131?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
                'title': 'Mawa Kachori',
                'description': 'A sweet and savory Indian snack.',
              },
              {
                'imageUrl':
                    'https://images.pexels.com/photos/7276946/pexels-photo-7276946.jpeg?cs=srgb&dl=pexels-rachel-claire-7276946.jpg&fm=jpg&w=3648&h=5472',
                'title': 'Sweet Chilly Kachori',
                'description': 'Description for another item.',
              },
              {
                'imageUrl':
                    'https://images.pexels.com/photos/1526713/pexels-photo-1526713.jpeg?cs=srgb&dl=pexels-francesco-ungaro-1526713.jpg&fm=jpg&w=4000&h=6000',
                'title': 'Standard Kachori',
                'description': 'A short description.',
              },
              {
                'imageUrl': 'https://picsum.photos/id/5/400/800',
                'title': 'Hot & Spicy kachori',
                'description': '₹ 900.00 - 300 gram',
              },
              {
                'imageUrl':
                    'https://images.unsplash.com/photo-1518791841217-8f162f1e1131?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
                'title': 'Mawa Kachori',
                'description': 'A sweet and savory Indian snack.',
              },
              {
                'imageUrl':
                    'https://images.pexels.com/photos/7276946/pexels-photo-7276946.jpeg?cs=srgb&dl=pexels-rachel-claire-7276946.jpg&fm=jpg&w=3648&h=5472',
                'title': 'Sweet Chilly Kachori',
                'description': 'Description for another item.',
              },
              {
                'imageUrl':
                    'https://images.pexels.com/photos/1526713/pexels-photo-1526713.jpeg?cs=srgb&dl=pexels-francesco-ungaro-1526713.jpg&fm=jpg&w=4000&h=6000',
                'title': 'Standard Kachori',
                'description': 'A short description.',
              },
              {
                'imageUrl': 'https://picsum.photos/id/5/400/800',
                'title': 'Hot & Spicy kachori',
                'description': '₹ 900.00 - 300 gram',
              },
              {
                'imageUrl':
                    'https://images.unsplash.com/photo-1518791841217-8f162f1e1131?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
                'title': 'Mawa Kachori',
                'description': 'A sweet and savory Indian snack.',
              },
              {
                'imageUrl':
                    'https://images.pexels.com/photos/7276946/pexels-photo-7276946.jpeg?cs=srgb&dl=pexels-rachel-claire-7276946.jpg&fm=jpg&w=3648&h=5472',
                'title': 'Sweet Chilly Kachori',
                'description': 'Description for another item.',
              },
              {
                'imageUrl':
                    'https://images.pexels.com/photos/1526713/pexels-photo-1526713.jpeg?cs=srgb&dl=pexels-francesco-ungaro-1526713.jpg&fm=jpg&w=4000&h=6000',
                'title': 'Standard Kachori',
                'description': 'A short description.',
              },
              {
                'imageUrl':
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSIJv5xbq6JT-xyfOvuv4trgBBO_0XixESGS1kfvUXRlCdST216NyM1mIZcCLGF-D-C-0k&usqp=CAU',
                'title': 'Hot & Spicy kachori',
                'description': '₹ 900.00 - 300 gram',
              },
            ],
          ),
        ),
      ),
    );
  }
}
