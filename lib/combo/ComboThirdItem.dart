import 'package:flutter/material.dart';
import 'package:hjvyas/product/ProductListWidgets.dart';

import '../utils/AppColors.dart';

class ComboThirdItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String comboWeight;
  final String comboSoldout;
  final String comboSpecification;

  ComboThirdItem({
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
        productListWhiteBg(Alignment.topCenter),

        productListColoredBorderBox(0, 110.0),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            productListTitleWidget(title,
                ),

            //"₹ 900.00 - 300 grams"
            if (comboSoldout.isEmpty)
              productListVariationWidget(price, comboWeight,
                  ),


            //"Calories: 470"
            if (comboSoldout.isEmpty) productComboSpecification(comboSpecification),

            if (comboSoldout.isNotEmpty) soldOutText(),

            productListImage(imageUrl,
                AppColors.secondary),
          ],
        ),
      ],
    );
  }
}
