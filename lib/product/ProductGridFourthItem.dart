import 'package:flutter/material.dart';

import 'ProductListWidgets.dart';

class ProductGridFourthItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String productLife;
  final String calories;

  ProductGridFourthItem({
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
        productListWhiteBg(Alignment.topCenter),

        productListColoredBorderBox(110, 0),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            productListImage(imageUrl),

            productListTitleWidget(title),

            if (price.isEmpty) soldOutText(),

            //"₹ 900.00 - 300 grams"
            if (price.isNotEmpty) productListVariationWidget(price),

            //"Product life: 300 days"
            if (price.isNotEmpty) productListLife(productLife),

            //"Calories: 470"
            if (price.isNotEmpty) productListCalories(calories),
          ],
        ),
      ],
    );
  }
}
