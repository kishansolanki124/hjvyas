import 'package:flutter/material.dart';

import '../utils/AppColors.dart';

class CustomFixedBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final List<BottomNavigationBarItem> items;
  final ValueChanged<int> onTap;
  final TextStyle selectedLabelStyle;
  final TextStyle unselectedLabelStyle;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;

  const CustomFixedBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.items,
    required this.onTap,
    required this.selectedLabelStyle,
    required this.unselectedLabelStyle,
    this.selectedItemColor,
    this.unselectedItemColor,
  });

  @override
  _CustomFixedBottomNavigationBarState createState() =>
      _CustomFixedBottomNavigationBarState();
}

class _CustomFixedBottomNavigationBarState
    extends State<CustomFixedBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    //final theme = Theme.of(context);
    return SizedBox(
      height: kBottomNavigationBarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:
            widget.items.map((item) {
              final int index = widget.items.indexOf(item);
              final bool isSelected = index == widget.currentIndex;
              final TextStyle labelStyle =
                  isSelected
                      ? widget.selectedLabelStyle
                      : widget.unselectedLabelStyle;
              // isSelected
              //     ? (widget.selectedLabelStyle ??
              //         theme.textTheme.labelLarge!)
              //     : (widget.unselectedLabelStyle ??
              //         theme.textTheme.labelSmall!);
              final Color itemColor =
                  isSelected
                      ? (widget.selectedItemColor ?? AppColors.secondary)
                      : (widget.unselectedItemColor ?? Colors.black);

              return GestureDetector(
                onTap: () => widget.onTap(index),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.currentIndex == index) item.activeIcon,

                      if (widget.currentIndex != index) item.icon,

                      if (item.label != null)
                        Text(
                          item.label!,
                          style: labelStyle.copyWith(color: itemColor),
                        ),
                    ],
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
