import 'package:flutter/material.dart';

import 'NotificationWidget.dart';

class NotificationListItem extends StatelessWidget {
  final String description;
  final String date;
  final String time;

  NotificationListItem({
    required this.description,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      // Add vertical padding inside item
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // Align items to the start (left)
        children: <Widget>[
          // Description Text
          notificationDesc(description),
          SizedBox(height: 8.0),
          // Add space between description and date/time

          // Date and Time Row
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space them out
            children: <Widget>[
              dateOrTime(date),
              SizedBox(width: 4),
              dateOrTime("|"),
              SizedBox(width: 4),
              dateOrTime(time),
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

class NotificationList extends StatelessWidget {
  final List<Map<String, String>> data = [
    {
      'description':
          'This is a longer description for the first item.  It should wrap to multiple lines and the text should be justified.  This demonstrates how the text will look in a real scenario.  We are adding more text to see how it wraps and justifies.',
      'date': '25-04-2025',
      'time': '04:55 PM',
    },
    {
      'description': 'Short description for item 2.',
      'date': '26-04-2025',
      'time': '09:12 AM',
    },
    {
      'description':
          'This is a longer description for the first item.  It should wrap to multiple lines and the text should be justified.  This demonstrates how the text will look in a real scenario.  We are adding more text to see how it wraps and justifies.',
      'date': '27-04-2025',
      'time': '12:30 PM',
    },
    {
      'description':
          'This is a longer description for the first item.  It should wrap to multiple lines and the text should be justified.  This demonstrates how the text will look in a real scenario.  We are adding more text to see how it wraps and justifies.',
      'date': '28-04-2025',
      'time': '07:00 PM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // 1. Background Image
          Image.asset(
            'images/bg.jpg', // Replace with your image path
            fit: BoxFit.cover, // Cover the entire screen
            width: double.infinity,
            height: double.infinity,
          ),

          //square border app color
          IgnorePointer(
            child: Container(
              height: 100,
              margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 0),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: Color.fromARGB(255, 123, 138, 195),
                    width: 2.0,
                  ),
                  bottom: BorderSide(
                    color: Color.fromARGB(255, 123, 138, 195),
                    width: 2.0,
                  ),
                  right: BorderSide(
                    color: Color.fromARGB(255, 123, 138, 195),
                    width: 2.0,
                  ),
                ),
                borderRadius: BorderRadius.all(Radius.circular(0)),
              ),
            ),
          ),

          SafeArea(
            // Use SafeArea to avoid overlapping with system UI
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 60.0),

                  // Title
                  Center(child: Container(
                    color: Color.fromARGB(255, 31, 47, 80),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Text(
                        'Notification',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color:
                              Colors
                                  .white, // Ensure text is visible on the background
                        ),
                      ),
                    ),
                    ),
                  ),

                  SizedBox(height: 8.0), // Description
                  // 3. Expanded List
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final item = data[index];
                        return NotificationListItem(
                          description: item['description']!,
                          date: item['date']!,
                          time: item['time']!,
                        );
                      }, // Use your custom list widget here
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
