import 'package:flutter/material.dart';
import 'package:hjvyas/product/ProductListWidgets.dart';

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
            productListTitleWidget(title, Color.fromARGB(255, 1, 1, 1)),

            //"₹ 900.00 - 300 grams"
            if (price.isNotEmpty)
              productListVariationWidget(price, comboWeight,Color.fromARGB(255, 1, 1, 1)),


            //"Calories: 470"
            if (price.isNotEmpty) productComboSpecification(comboSpecification),

            if (price.isEmpty) soldOutText(),

            productListImage(imageUrl, Color.fromARGB(255, 123, 138, 195)),
          ],
        ),
      ],
    );
  }
}
