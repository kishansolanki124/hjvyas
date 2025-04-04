import 'package:flutter/material.dart';

import '../product/ProductListWidgets.dart';


class ComboSecondItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  ComboSecondItem({
    required this.imageUrl,
    required this.title,
    required this.description,
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
            productListImage("",Color.fromARGB(255, 123, 138, 195)),

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
    );
  }
}
