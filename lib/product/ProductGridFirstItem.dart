import 'package:flutter/material.dart';

import 'ProductListWidgets.dart';

class ProductGridFirstItem extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String productWeight;
  final String productLife;
  final String calories;
  final String productSoldout;

  ProductGridFirstItem({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.productWeight,
    required this.productLife,
    required this.calories,
    required this.productSoldout,
  });

  @override
  State<ProductGridFirstItem> createState() => _ProductGridFirstItemState();
}

class _ProductGridFirstItemState extends State<ProductGridFirstItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          productListWhiteBg(Alignment.bottomCenter, 120),

          productListColoredBorderBox(0, 120.0),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              productListTitleWidget(widget.title),

              //"₹ 900.00 - 300 grams"
              if (widget.productSoldout.isEmpty)
                productListVariationWidget(widget.price, widget.productWeight),

              //"Product life: 300 days"
              if (widget.productSoldout.isEmpty)
                productListLife(widget.productLife),

              //"Calories: 470"
              if (widget.productSoldout.isEmpty)
                productListCalories(widget.calories),

              if (widget.productSoldout.isNotEmpty) soldOutText(),

              Hero(
                  tag: "kishan",
                  child: productListImage(widget.imageUrl)),
            ],
          ),
        ],
      ),
    );
  }
}
