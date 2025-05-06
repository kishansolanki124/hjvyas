import 'package:flutter/material.dart';
import 'package:hjvyas/api/models/ProductListResponse.dart';

import '../home/navigation.dart';
import '../product_detail/ProductDetail.dart';
import 'ProductGridFirstItem.dart';
import 'ProductGridFourthItem.dart';
import 'ProductGridSecondItem.dart';
import 'ProductGridThirdItem.dart';

class ProductListItemWidget extends StatefulWidget {
  final int index;
  final ProductListItem item;

  ProductListItemWidget({required this.index, required this.item});

  @override
  State<ProductListItemWidget> createState() => _ProductListItemState();
}

class _ProductListItemState extends State<ProductListItemWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Offset> _slideAnimation;

  void navigateToDetails(int index, ProductListItem item) async {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder:
    //         (context) => ProductDetail(
    //           productId: item.productId,),
    //   ),
    // );

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetail(productId: item.productId),
      ),
    );

    // When returning from Widget2, this code will execute
    if (result != null) {
      //updating cart total
      NavigationExample.of(context)?.loadSharedPrefItemsList();
    }
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Start from bottom
      end: Offset.zero, // End at normal position
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutQuad),
    );

    // Stagger the animations based on index
    Future.delayed(Duration(milliseconds: 100 * widget.index), () {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _animationController,
        child: GestureDetector(
          onTap: () {
            navigateToDetails(widget.index, widget.item);
          },
          child: lloadWidget,
        ),
      ),
    );
  }
}
