import 'package:flutter/material.dart';
import 'package:hjvyas/product/GridFourthItem.dart';
import 'package:hjvyas/product/GridItem.dart';
import 'package:hjvyas/product/GridOddItem.dart';
import 'package:hjvyas/product/GridThirdItem.dart';
import 'package:hjvyas/product/MultiItem.dart';

import 'ComboWidget.dart';

class Combo extends StatelessWidget {
  final List<Map<String, String>> items;

  Combo({required this.items});

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
                description: value['description']!,
              );
            } else if (index % 4 == 1) {
              print("GridItem $index");
              return GridItem(
                imageUrl: value['imageUrl']!,
                title: value['title']!,
                description: value['description']!,
              );
            } else if (index % 4 == 2) {
              print("Gridthirditem $index");
              return Gridthirditem(
                imageUrl: value['imageUrl']!,
                title: value['title']!,
                description: value['description']!,
              );
            } else {
              print("Gridfourthitem $index");
              return Gridfourthitem(
                imageUrl: value['imageUrl']!,
                title: value['title']!,
                description: value['description']!,
              );
            }
          }).toList(),
    );
  }
}

class ComboStateless extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Combowidget(
        gridItems: [
          {
            'imageUrl': 'https://picsum.photos/id/6/400/800',
            'title': 'Standard kachori',
          },
          {
            'imageUrl':
                'https://images.unsplash.com/photo-1516035069371-29a1b2bd89dd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
            'title': 'Sweet Chilly Kachori',
          },
          {
            'imageUrl':
                'https://images.unsplash.com/photo-1506794775205-1e26e7f63ebc?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
            'title': 'Hot & Spicy Kachori',
          },
          {
            'imageUrl':
                'https://images.unsplash.com/photo-1522205469752-16363bc3b0c2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
            'title': 'Luscious Bite Kachori',
          },
          {'imageUrl': 'https://picsum.photos/id/4/400/800', 'title': 'Item 5'},
          {'imageUrl': 'https://picsum.photos/id/3/400/800', 'title': 'Item 6'},
          {'imageUrl': 'https://picsum.photos/id/6/400/800', 'title': 'Item 1'},
          {
            'imageUrl':
                'https://images.unsplash.com/photo-1516035069371-29a1b2bd89dd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
            'title': 'Item 2',
          },
          {
            'imageUrl':
                'https://images.unsplash.com/photo-1506794775205-1e26e7f63ebc?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
            'title': 'Item 3',
          },
          {
            'imageUrl':
                'https://images.unsplash.com/photo-1522205469752-16363bc3b0c2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
            'title': 'Item 4',
          },
          {'imageUrl': 'https://picsum.photos/id/4/400/800', 'title': 'Item 5'},
          {'imageUrl': 'https://picsum.photos/id/3/400/800', 'title': 'Item 6'},
        ],
      ),
    );
  }
}
