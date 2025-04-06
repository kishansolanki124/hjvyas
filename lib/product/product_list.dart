import 'package:flutter/material.dart';

import 'GridFourthItem.dart';
import 'GridItem.dart';
import 'GridOddItem.dart';
import 'GridThirdItem.dart';
import 'MultiItem.dart';

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

            if (index % 4 == 0) {
              print("GridOddItem $index");
              return GridOddItem(
                imageUrl: value['imageUrl']!,
                title: value['title']!,
                price: value['description']!,
                productLife: value['productLife']!,
                calories: value['calories']!,
              );
            } else if (index % 4 == 1) {
              print("GridItem $index");
              return GridItem(
                imageUrl: value['imageUrl']!,
                title: value['title']!,
                price: value['description']!,
                productLife: value['productLife']!,
                calories: value['calories']!,
              );
            } else if (index % 4 == 2) {
              print("Gridthirditem $index");
              return Gridthirditem(
                imageUrl: value['imageUrl']!,
                title: value['title']!,
                price: value['description']!,
                productLife: value['productLife']!,
                calories: value['calories']!,
              );
            } else {
              print("Gridfourthitem $index");
              return Gridfourthitem(
                imageUrl: value['imageUrl']!,
                title: value['title']!,
                price: value['description']!,
                productLife: value['productLife']!,
                calories: value['calories']!,
              );
            }
          }).toList(),
    );
  }
}

class GridStateless extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppLogoNameGridView(
        gridItems: [
          {
            'imageUrl': 'https://picsum.photos/id/6/400/800',
            'title': 'Standard kachori',
            'price': '₹ 900.00 - 300 grams',
            'calories': 'Calories: 470',
            'productLife': 'Product life: 300 days',
          },
          {
            'imageUrl':
                'https://images.unsplash.com/photo-1516035069371-29a1b2bd89dd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
            'title': 'Sweet Chilly Kachori',
            'price': '₹ 900.00 - 300 grams',
            'calories': 'Calories: 470',
            'productLife': 'Product life: 300 days',
          },
          {
            'imageUrl':
                'https://images.unsplash.com/photo-1506794775205-1e26e7f63ebc?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
            'title': 'Hot & Spicy Kachori',
            'price': '₹ 900.00 - 300 grams',
            'calories': 'Calories: 470',
            'productLife': 'Product life: 300 days',
          },
          {
            'imageUrl':
                'https://images.unsplash.com/photo-1522205469752-16363bc3b0c2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
            'title': 'Luscious Bite Kachori',
            'price': '₹ 900.00 - 300 grams',
            'calories': 'Calories: 470',
            'productLife': 'Product life: 300 days',
          },
          {
            'imageUrl': 'https://picsum.photos/id/4/400/800',
            'title': 'Item 5',
            'price': '',
            'calories': '',
            'productLife': '',
          },
          {
            'imageUrl': 'https://picsum.photos/id/3/400/800',
            'title': 'Item 6',
            'price': '',
            'calories': '',
            'productLife': '',
          },
          {
            'imageUrl': 'https://picsum.photos/id/6/400/800',
            'title': 'Item 1',
            'price': '',
            'calories': 'Calories: 470',
            'productLife': 'Product life: 300 days',
          },
          {
            'imageUrl':
                'https://images.unsplash.com/photo-1516035069371-29a1b2bd89dd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
            'title': 'Item 2',
            'price': '',
            'calories': 'Calories: 470',
            'productLife': 'Product life: 300 days',
          },
          {
            'imageUrl':
                'https://images.unsplash.com/photo-1506794775205-1e26e7f63ebc?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
            'title': 'Item 3',
            'price': '₹ 900.00 - 300 grams',
            'calories': 'Calories: 470',
            'productLife': 'Product life: 300 days',
          },
          {
            'imageUrl':
                'https://images.unsplash.com/photo-1522205469752-16363bc3b0c2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
            'title': 'Item 4',
            'price': '₹ 900.00 - 300 grams',
            'calories': 'Calories: 470',
            'productLife': 'Product life: 300 days',
          },
          {
            'imageUrl': 'https://picsum.photos/id/4/400/800',
            'title': 'Item 5',
            'price': '',
            'calories': 'Calories: 470',
            'productLife': 'Product life: 300 days',
          },
          {
            'imageUrl': 'https://picsum.photos/id/3/400/800',
            'title': 'Item 6',
            'price': '₹ 900.00 - 300 grams',
            'calories': 'Calories: 470',
            'productLife': 'Product life: 300 days',
          },
        ],
      ),
    );
  }
}
