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

        Container(
          margin: const EdgeInsets.only(
            top: 100,
            left: 20.0,
            right: 20.0,
            bottom: 20,
          ),
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
