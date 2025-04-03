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
    return Container(
      //color: Colors.blueGrey,
      child: Stack(
        children: [
          productListWhiteBg(Alignment.topCenter),

          Container(
            margin: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              bottom: 110.0,
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
      ),
    );
  }
}
