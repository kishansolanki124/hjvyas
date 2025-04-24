import 'package:flutter/material.dart';

import 'ProductListWidgets.dart';

class ProductGridFourthItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String productWeight;
  final String productLife;
  final String calories;

  ProductGridFourthItem({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.productWeight,
    required this.productLife,
    required this.calories,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          productListWhiteBg(Alignment.topCenter),

          productListColoredBorderBox(110, 20),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              productListImage(imageUrl),

              productListTitleWidget(title),

              if (price.isEmpty) soldOutText(),

              //"₹ 900.00 - 300 grams"
              if (price.isNotEmpty) productListVariationWidget(price, productWeight),

              //"Product life: 300 days"
              if (price.isNotEmpty) productListLife(productLife),

              //"Calories: 470"
              if (price.isNotEmpty) productListCalories(calories),
            ],
          ),
        ],
      ),
    );
  }
}
