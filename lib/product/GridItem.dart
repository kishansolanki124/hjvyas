import 'package:flutter/material.dart';

import 'ProductListWidgets.dart';

class GridItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String productLife;
  final String calories;

  GridItem({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.productLife,
    required this.calories,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        productListWhiteBg(Alignment.bottomCenter),

        productListColoredBorderBox(110, 0),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            productListImage(""),

            productListTitleWidget(title),

            //"₹ 900.00 - 300 grams"
            if (price.isNotEmpty) productListVariationWidget(price,
              Color.fromARGB(255, 1, 1, 1),
            ),

            //"Product life: 300 days"
            if (price.isNotEmpty) productListLife(productLife,
              Color.fromARGB(255, 139, 139, 139),
            ),

            //"Calories: 470"
            if (price.isNotEmpty) productListCalories(calories,
              Color.fromARGB(255, 139, 139, 139),
            ),

            if (price.isEmpty) soldOutText(),
          ],
        ),
      ],
    );
  }
}
