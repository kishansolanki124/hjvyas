import 'package:flutter/material.dart';

import 'ProductListWidgets.dart';

class GridItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  GridItem({
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          // White color box at the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(height: 85, child: Container(color: Colors.white)),
          ),

          Container(
            margin: const EdgeInsets.only(
              top: 100,
              left: 20.0,
              right: 20.0,
              bottom: 20,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromARGB(255, 123, 138, 195),
                width: 2,
              ),
              borderRadius: BorderRadius.all(Radius.circular(0)),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              productListImage(""),

              productListTitleWidget(title),

              productListVariationWidget(
                "₹ 900.00 - 300 grams",
                Color.fromARGB(255, 1, 1, 1),
              ),

              productListLife(
                "Product life: 300 days",
                Color.fromARGB(255, 139, 139, 139),
              ),

              productListCalories(
                "Calories: 470",
                Color.fromARGB(255, 139, 139, 139),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
