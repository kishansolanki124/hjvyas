import 'package:flutter/material.dart';

import '../product/ProductListWidgets.dart';

class ComboSecondItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String comboWeight;
  final String comboSoldout;
  final String comboSpecification;

  ComboSecondItem({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.comboWeight,
    required this.comboSoldout,
    required this.comboSpecification,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        productListWhiteBg(Alignment.bottomCenter, 100),

        productListColoredBorderBox(110, 20),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            productListImage(imageUrl, Color.fromARGB(255, 123, 138, 195)),

            SizedBox(height: 10),

            productListTitleWidget(title),

            SizedBox(height: 5),

            //"₹ 900.00 - 300 grams"
            if (price.isNotEmpty)
              productListVariationWidget(
                price,
                comboWeight,
                Color.fromARGB(255, 1, 1, 1),
              ),

            //"Calories: 470"
            if (price.isNotEmpty)
              productComboSpecification(
                comboSpecification,
                Color.fromARGB(255, 139, 139, 139),
              ),

            if (price.isEmpty) soldOutText(),
          ],
        ),
      ],
    );
  }
}
