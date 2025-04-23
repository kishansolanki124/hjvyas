import 'package:flutter/material.dart';

import 'ProductListWidgets.dart';

class ProductGridThirdItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String productWeight;
  final String productLife;
  final String calories;

  ProductGridThirdItem({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.productWeight,
    required this.productLife,
    required this.calories,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        productListWhiteBg(Alignment.topCenter),

        productListColoredBorderBox(0, 110.0),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            productListTitleWidget(title, Color.fromARGB(255, 1, 1, 1)),

            //"₹ 900.00 - 300 grams"
            if (price.isNotEmpty) productListVariationWidget(price, productWeight,
              Color.fromARGB(255, 1, 1, 1),
            ),

            //"Product life: 300 days"
            if (price.isNotEmpty) productListLife(productLife),

            //"Calories: 470"
            if (price.isNotEmpty) productListCalories(calories),

            if (price.isEmpty) soldOutText(),

            productListImage(imageUrl),
          ],
        ),
      ],
    );
  }
}
