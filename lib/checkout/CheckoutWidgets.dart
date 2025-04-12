import 'package:flutter/material.dart';

Widget CartTotalRow(String title, String value, double bottomPadding) {
  return Padding(
    padding: EdgeInsets.only(bottom: bottomPadding, left: 10, right: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.0,
            fontFamily: "Montserrat",
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.0,
            fontFamily: "Montserrat",
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Widget radioTwoOption(
  String option1,
  String option2,
    _onValueChanged,
    _selectedOption
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    // Center the buttons horizontally
    children: <Widget>[
      Row(
        children: [
          Radio<String>(
            value: option1,
            groupValue: _selectedOption,
            onChanged: (value) {
              _onValueChanged(value);
            }, // Selected color
            fillColor: WidgetStateProperty.resolveWith<Color>((
              Set<WidgetState> states,
            ) {
              if (states.contains(WidgetState.selected)) {
                return Colors.white; // Selected color
              }
              return Colors.white; // Default color
            }),
          ),
          GestureDetector(
            onTap: () {
              _onValueChanged(option1); // Update selected option
            },
            child: Text(
              option1,
              style: TextStyle(
                fontSize: 14.0,
                fontFamily: "Montserrat",
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      Row(
        children: [
          Radio<String>(
            value: option2,
            groupValue: _selectedOption,
            onChanged: (value) {
              _onValueChanged(value);
            }, // Selected color
            fillColor: WidgetStateProperty.resolveWith<Color>((
              Set<WidgetState> states,
            ) {
              if (states.contains(WidgetState.selected)) {
                return Colors.white; // Selected color
              }
              return Colors.white; // Default color
            }),
          ),
          GestureDetector(
            onTap: () {
              _onValueChanged(option2); // Update selected option
            },
            child: Text(
              option2,
              style: TextStyle(
                fontSize: 14.0,
                fontFamily: "Montserrat",
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
