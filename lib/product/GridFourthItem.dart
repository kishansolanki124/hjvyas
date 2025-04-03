import 'package:flutter/material.dart';

import 'ProductListWidgets.dart';

class Gridfourthitem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  Gridfourthitem({
    required this.imageUrl,
    required this.title,
    required this.description,
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
            productListImage(""),

            productListTitleWidget(title),

            productListVariationWidget("₹ 900.00 - 300 grams"),

            productListLife("Product life: 300 days"),

            productListCalories("Calories: 470"),
          ],
        ),
      ],
    );
  }
}
