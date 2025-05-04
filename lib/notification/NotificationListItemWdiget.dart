import 'package:flutter/material.dart';

import 'NotificationWidget.dart';

class NotificationListItemWdiget extends StatefulWidget {
  final String title;
  final String description;
  final String date;
  final int index;

  NotificationListItemWdiget({
    required this.title,
    required this.description,
    required this.date,
    required this.index,
  });

  @override
  State<NotificationListItemWdiget> createState() =>
      _NotificationListItemWdigetState();
}

class _NotificationListItemWdigetState extends State<NotificationListItemWdiget>
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
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _animationController,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          // Add vertical padding inside item
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // Align items to the start (left)
            children: <Widget>[
              // Title Text
              notificationTitle(widget.title),

              // Description Text
              notificationDesc(widget.description),
              // Add space between description and date/time

              // Date and Time Row
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space them out
                children: <Widget>[
                  dateOrTime(widget.date),
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
                height: 1.0,
                // Thickness of the divider
                color: Color.fromARGB(255, 123, 138, 195),
                // Color of the divider
                width: double.infinity, // Make it span the entire width
              ),
            ],
          ),
        ),
      ),
    );
  }
}
