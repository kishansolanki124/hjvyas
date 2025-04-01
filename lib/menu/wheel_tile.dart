import 'package:flutter/material.dart';

class WheelTile extends StatelessWidget {
  final String states;
  final Color selectedColor;
  const WheelTile(this.selectedColor, this.states, {Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              states.toUpperCase(),
              style: TextStyle(
                fontSize: 18,
                color: selectedColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (selectedColor == Colors.white)
              GestureDetector(
                onTap: () {
                  // Add what you want to do on tap
                  print("on item tapped");
                },
                child: Icon(Icons.chevron_right, color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }
}
