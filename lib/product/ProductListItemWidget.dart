import 'package:flutter/material.dart';
import 'package:hjvyas/api/models/ProductListResponse.dart';

import '../product_detail/ProductDetail.dart';
import 'ProductGridFirstItem.dart';
import 'ProductGridFourthItem.dart';
import 'ProductGridSecondItem.dart';
import 'ProductGridThirdItem.dart';

class ProductListItemWidget extends StatefulWidget {
  int index;
  ProductListItem item;

  ProductListItemWidget({required this.index, required this.item, super.key});

  @override
  State<ProductListItemWidget> createState() => _ProductListItemState();
}

class _ProductListItemState extends State<ProductListItemWidget> {
  void navigateToDetails(int index, ProductListItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => ProductDetail(
              productId: item.productId,
              isOutOfStock: item.productSoldout.isEmpty ? false : true,
            ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget lloadWidget;

    if (widget.index % 4 == 0) {
      lloadWidget = ProductGridFirstItem(
        imageUrl: widget.item.productImage,
        title: widget.item.productName,
        price: widget.item.productPrice,
        productWeight: widget.item.productWeight,
        productLife: widget.item.productLife,
        calories: widget.item.productCalories,
        productSoldout: widget.item.productSoldout,
      );
    } else if (widget.index % 4 == 1) {
      lloadWidget = ProductGridSecondItem(
        imageUrl: widget.item.productImage,
        title: widget.item.productName,
        price: widget.item.productPrice,
        productWeight: widget.item.productWeight,
        productLife: widget.item.productLife,
        calories: widget.item.productCalories,
        productSoldout: widget.item.productSoldout,
      );
    } else if (widget.index % 4 == 2) {
      lloadWidget = ProductGridThirdItem(
        imageUrl: widget.item.productImage,
        title: widget.item.productName,
        price: widget.item.productPrice,
        productWeight: widget.item.productWeight,
        productLife: widget.item.productLife,
        calories: widget.item.productCalories,
        productSoldout: widget.item.productSoldout,
      );
    } else {
      lloadWidget = ProductGridFourthItem(
        imageUrl: widget.item.productImage,
        title: widget.item.productName,
        price: widget.item.productPrice,
        productWeight: widget.item.productWeight,
        productLife: widget.item.productLife,
        calories: widget.item.productCalories,
        productSoldout: widget.item.productSoldout,
      );
    }

    return GestureDetector(
      onTap: () {
        navigateToDetails(widget.index, widget.item);
      },
      child: lloadWidget,
    );
  }
}
