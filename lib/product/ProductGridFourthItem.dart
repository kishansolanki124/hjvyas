import 'package:flutter/material.dart';

import 'ProductListWidgets.dart';

class ProductGridFourthItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String productWeight;
  final String productLife;
  final String calories;
  final String productSoldout;

  ProductGridFourthItem({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.productWeight,
    required this.productLife,
    required this.calories,
    required this.productSoldout,
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

              if (productSoldout.isNotEmpty) soldOutText(),

              //"₹ 900.00 - 300 grams"
              if (productSoldout.isEmpty) productListVariationWidget(price, productWeight),

              //"Product life: 300 days"
              if (productSoldout.isEmpty) productListLife(productLife),

              //"Calories: 470"
              if (productSoldout.isEmpty) productListCalories(calories),
            ],
          ),
        ],
      ),
    );
  }
}
