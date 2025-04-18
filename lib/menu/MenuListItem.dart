import 'package:flutter/material.dart';

import '../product/ProductListGridView.dart';

class MenuListItem extends StatelessWidget {
  final String states;
  final Color selectedColor;
  const MenuListItem(this.selectedColor, this.states, {Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.chevron_right, color: Colors.transparent, size: 24),

          GestureDetector(
            onTap: () {
              if (selectedColor == Colors.white) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProductListGridView(),
                  ),
                );
              }
            },
            child: Text(
              states.toUpperCase(),
              style: TextStyle(
                fontSize: 18,
                color: selectedColor,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          if (selectedColor == Colors.white)
            Icon(Icons.chevron_right, color: Colors.white, size: 24),

          if (selectedColor != Colors.white)
            Icon(Icons.chevron_right, color: Colors.transparent, size: 24),
        ],
      ),
    );
  }
}
