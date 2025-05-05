import 'package:flutter/material.dart';

import 'ProductListWidgets.dart';

class ProductGridSecondItem extends StatefulWidget {

  final String imageUrl;
  final String title;
  final String price;
  final String productWeight;
  final String productLife;
  final String calories;
  final String productSoldout;

  ProductGridSecondItem({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.productWeight,
    required this.productLife,
    required this.calories,
    required this.productSoldout,
  });

  @override
  State<ProductGridSecondItem> createState() => _ProductGridSecondItemState();
}

class _ProductGridSecondItemState extends State<ProductGridSecondItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          productListWhiteBg(Alignment.bottomCenter, 120),

          productListColoredBorderBox(110, 20),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              productListImage(widget.imageUrl),

              productListTitleWidget(widget.title, Colors.white, 0.0),

              SizedBox(height: 10),

              //"₹ 900.00 - 300 grams"
              if (widget.productSoldout.isEmpty)
                productListVariationWidget(
                  widget.price,
                  widget.productWeight,
                  //Color.fromARGB(255, 1, 1, 1),
                ),

              //"Product life: 300 days"
              if (widget.productSoldout.isEmpty)
                productListLife(widget.productLife,
                    //Color.fromARGB(255, 139, 139, 139)
                ),

              //"Calories: 470"
              if (widget.productSoldout.isEmpty)
                productListCalories(widget.calories,
                    //Color.fromARGB(255, 139, 139, 139)
                    ),

              if (widget.productSoldout.isNotEmpty) soldOutText(),
            ],
          ),
        ],
      ),
    );
  }
}
