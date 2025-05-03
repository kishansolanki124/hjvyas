import 'package:flutter/material.dart';

import 'NotificationWidget.dart';

class NotificationListItemWdiget extends StatelessWidget {
  final String title;
  final String description;
  final String date;

  NotificationListItemWdiget({
    required this.title,
    required this.description,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      // Add vertical padding inside item
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // Align items to the start (left)
        children: <Widget>[
          // Title Text
          notificationTitle(title),

          // Description Text
          notificationDesc(description),
          // Add space between description and date/time

          // Date and Time Row
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space them out
            children: <Widget>[
              dateOrTime(date),
              SizedBox(width: 4),
              // dateOrTime("|"),
              // SizedBox(width: 4),
              // dateOrTime(time),
            ],
          ),
          SizedBox(height: 12.0),
          // Add space before the divider

          // Divider Line
          Container(
            height: 1.0, // Thickness of the divider
            color: Color.fromARGB(255, 123, 138, 195), // Color of the divider
            width: double.infinity, // Make it span the entire width
          ),
        ],
      ),
    );
  }
}
