import 'package:flutter/material.dart';

import 'ProductListWidgets.dart';

class GridOddItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  GridOddItem({
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        productListWhiteBg(Alignment.bottomCenter),

        Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 110.0),
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
            productListTitleWidget(title),

            productListVariationWidget("₹ 900.00 - 300 grams"),

            productListLife("Product life: 300 days"),

            productListCalories("Calories: 470"),

            productListImage(""),
          ],
        ),
      ],
    );
  }
}
