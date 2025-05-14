import 'package:flutter/material.dart';

import 'ProductListWidgets.dart';

class ProductGridThirdItem extends StatefulWidget {

  final String imageUrl;
  final String title;
  final String price;
  final String productWeight;
  final String productLife;
  final String calories;
  final String productSoldout;

  ProductGridThirdItem({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.productWeight,
    required this.productLife,
    required this.calories,
    required this.productSoldout,
  });

  @override
  State<ProductGridThirdItem> createState() => _ProductGridThirdItemState();
}

class _ProductGridThirdItemState extends State<ProductGridThirdItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          productListWhiteBg(Alignment.topCenter),

          productListColoredBorderBox(0, 120.0),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              productListTitleWidget(
                widget.title,
              ),

              //"₹ 900.00 - 300 grams"
              if (widget.productSoldout.isEmpty)
                productListVariationWidget(
                  widget.price,
                  widget.productWeight,
                ), //,

              //"Product life: 300 days"
              if (widget.productSoldout.isEmpty)
                productListLife(widget.productLife),

              //"Calories: 470"
              if (widget.productSoldout.isEmpty)
                productListCalories(widget.calories),

              if (widget.productSoldout.isNotEmpty) soldOutText(),

              productListImage(widget.imageUrl),
            ],
          ),
        ],
      ),
    );
  }
}
