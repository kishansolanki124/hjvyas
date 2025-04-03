import 'package:flutter/material.dart';

import 'ProductListWidgets.dart';

class Gridthirditem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  Gridthirditem({
    required this.imageUrl,
    required this.title,
    required this.description,
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

            productListVariationWidget(
              "₹ 900.00 - 300 grams",
              Color.fromARGB(255, 1, 1, 1),
            ),

            productListLife("Product life: 300 days"),

            productListCalories("Calories: 470"),

            productListImage(""),
          ],
        ),
      ],
    );
  }
}
