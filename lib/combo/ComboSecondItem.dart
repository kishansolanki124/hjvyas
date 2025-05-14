import 'package:flutter/material.dart';

import '../product/ProductListWidgets.dart';
import '../utils/AppColors.dart';

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
            productListImage(imageUrl, AppColors.secondary),

            SizedBox(height: 10),

            productListTitleWidget(title),

            SizedBox(height: 5),

            //"₹ 900.00 - 300 grams"
            if (comboSoldout.isEmpty)
              productListVariationWidget(
                price,
                comboWeight,
              ),

            //"Calories: 470"
            if (comboSoldout.isEmpty)
              productComboSpecification(
                comboSpecification,
              ),

            if (comboSoldout.isNotEmpty) soldOutText(),
          ],
        ),
      ],
    );
  }
}
