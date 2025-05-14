import 'package:flutter/material.dart';

import '../api/models/ProductDetailResponse.dart';
import '../utils/AppColors.dart';

class ProductYouMayLikeItem extends StatefulWidget {
  final ProductMoreListItem productMoreListItem;
  final int index;

  const ProductYouMayLikeItem({
    super.key,
    required this.index,
    required this.productMoreListItem,
  });

  @override
  State<ProductYouMayLikeItem> createState() => _ProductYouMayLikeItemState();
}

class _ProductYouMayLikeItemState extends State<ProductYouMayLikeItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(3.0, 0.0), // Start from far right, outside
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
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _animationController,
        child: Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Container(
            width: 120,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.secondary),
            ),
            child: Column(
              children: [
                if (widget.productMoreListItem.productImage.isNotEmpty)
                  SizedBox(
                    height: 110,
                    width: 110,
                    child: Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Image.network(
                        widget.productMoreListItem.productImage,
                        height: 110,
                        width: 110,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return SizedBox(
                            height: 60,
                            child: Center(child: Text('Err')),
                          );
                        },
                      ),
                    ),
                  ),

                SizedBox(height: 4),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  child: Text(
                    widget.productMoreListItem.productName ?? '',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1),
                  child: Text(
                    "₹ ${widget.productMoreListItem.productPrice ?? ''} -  ${widget.productMoreListItem.productWeight}",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Montserrat",
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
