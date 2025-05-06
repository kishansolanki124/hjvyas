import 'package:flutter/material.dart';

import '../api/models/ProductTesterResponse.dart';
import '../product_detail/NetworkImageWithLoading.dart';

class TesterItemWidget extends StatefulWidget {
  ProductTesterListItem productTesterListItem;
  int index;
  int freeSelectedIndex;

  TesterItemWidget({
    required this.index,
    required this.productTesterListItem,
    required this.freeSelectedIndex,
  });

  @override
  _TesterItemWidgetState createState() => _TesterItemWidgetState();
}

class _TesterItemWidgetState extends State<TesterItemWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(3.0, 0.0), // Start from far right, outside
      end: Offset.zero,
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
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  //product image
                  Padding(
                    padding: EdgeInsets.all(4),
                    child: SizedBox(
                      width: 150,
                      height: 150,
                      child: NetworkImageWithLoading(
                        imageUrl: widget.productTesterListItem.testerImage,
                      ),
                    ),
                  ),

                  //product text
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: Center(
                      child: Text(
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        widget.productTesterListItem.testerName,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Montserrat",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              //background border
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromARGB(255, 123, 138, 195),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  width: 166,
                  height: 210,
                ),
              ),

              //bottom selector default
              if (widget.freeSelectedIndex != widget.index)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 31, 47, 80),
                    ),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                          width: 5,
                          color: Color.fromARGB(255, 31, 47, 80),
                        ),
                      ),
                    ),
                  ),
                ),

              //bottom selector selected
              if (widget.freeSelectedIndex == widget.index)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 33,
                    height: 33,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 31, 47, 80),
                        border: Border.all(width: 2, color: Colors.white),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
