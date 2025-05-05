import 'package:flutter/material.dart';

import 'ProductListWidgets.dart';

class ProductGridFourthItem extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String productWeight;
  final String productLife;
  final String calories;
  final String productSoldout;

  ProductGridFourthItem({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.productWeight,
    required this.productLife,
    required this.calories,
    required this.productSoldout,
  });

  @override
  State<ProductGridFourthItem> createState() => _ProductGridFourthItemState();
}

class _ProductGridFourthItemState extends State<ProductGridFourthItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          productListWhiteBg(Alignment.topCenter),

          productListColoredBorderBox(110, 20),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              productListImage(widget.imageUrl),

              productListTitleWidget(widget.title),

              if (widget.productSoldout.isNotEmpty) soldOutText(),

              //"₹ 900.00 - 300 grams"
              if (widget.productSoldout.isEmpty)
                productListVariationWidget(widget.price, widget.productWeight),

              //"Product life: 300 days"
              if (widget.productSoldout.isEmpty)
                productListLife(widget.productLife),

              //"Calories: 470"
              if (widget.productSoldout.isEmpty)
                productListCalories(widget.calories),
            ],
          ),
        ],
      ),
    );
  }
}
