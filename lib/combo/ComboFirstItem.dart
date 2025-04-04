import 'package:flutter/material.dart';

import '../product/ProductListWidgets.dart';

class ComboFirstItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  ComboFirstItem({
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        productListWhiteBg(Alignment.bottomCenter),

        productListColoredBorderBox(0, 110.0),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            productListTitleWidget(title),

            productListVariationWidget("₹ 900.00 - 300 grams"),

            productListLife("Product life: 300 days"),

            productListCalories("Calories: 470"),

            productListImage("", Color.fromARGB(255, 123, 138, 195)),
          ],
        ),
      ],
    );
  }
}
