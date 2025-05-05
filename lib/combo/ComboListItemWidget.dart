import 'package:flutter/material.dart';
import 'package:hjvyas/combo/ComboDetail.dart';

import '../api/models/ComboListResponse.dart';
import 'ComboFirstItem.dart';
import 'ComboFourthItem.dart';
import 'ComboSecondItem.dart';
import 'ComboThirdItem.dart';

class ComboListItemWidget extends StatefulWidget {
  final int index;
  final ComboListItem item;

  ComboListItemWidget({required this.index, required this.item});

  @override
  State<ComboListItemWidget> createState() => _ComboListItemWidgetState();
}

class _ComboListItemWidgetState extends State<ComboListItemWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Offset> _slideAnimation;

  void navigateToDetails(int index, ComboListItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) =>
                ComboDetail(comboId: widget.item.comboId),
      ),
    );
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
      lloadWidget = ComboFirstItem(
        imageUrl: widget.item.comboImage,
        title: widget.item.comboName,
        price: widget.item.comboPrice,
        comboWeight: widget.item.comboWeight,
        comboSoldout: widget.item.comboSoldout,
        comboSpecification: widget.item.comboSpecification,
      );
    } else if (widget.index % 4 == 1) {
      lloadWidget = ComboSecondItem(
        imageUrl: widget.item.comboImage,
        title: widget.item.comboName,
        price: widget.item.comboPrice,
        comboWeight: widget.item.comboWeight,
        comboSoldout: widget.item.comboSoldout,
        comboSpecification: widget.item.comboSpecification,
      );
    } else if (widget.index % 4 == 2) {
      lloadWidget = ComboThirdItem(
        imageUrl: widget.item.comboImage,
        title: widget.item.comboName,
        price: widget.item.comboPrice,
        comboWeight: widget.item.comboWeight,
        comboSoldout: widget.item.comboSoldout,
        comboSpecification: widget.item.comboSpecification,
      );
    } else {
      lloadWidget = ComboFourthItem(
        imageUrl: widget.item.comboImage,
        title: widget.item.comboName,
        price: widget.item.comboPrice,
        comboWeight: widget.item.comboWeight,
        comboSoldout: widget.item.comboSoldout,
        comboSpecification: widget.item.comboSpecification,
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
