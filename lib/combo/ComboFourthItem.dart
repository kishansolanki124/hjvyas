import 'package:flutter/material.dart';
import 'package:hjvyas/product/ProductListWidgets.dart';

class ComboFourthItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String comboWeight;
  final String comboSoldout;
  final String comboSpecification;

  ComboFourthItem({
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

        productListColoredBorderBox(110, 10),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            productListImage(imageUrl, Color.fromARGB(255, 123, 138, 195)),

            productListTitleWidget(title),

            if (comboSoldout.isNotEmpty) soldOutText(),

            //"₹ 900.00 - 300 grams"
            if (comboSoldout.isEmpty) productListVariationWidget(price, comboWeight),


            //"Calories: 470"
            if (comboSoldout.isEmpty) productComboSpecification(comboSpecification),
          ],
        ),
      ],
    );
  }
}
