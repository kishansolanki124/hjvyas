// home_widget.dart (This is where your BottomNavigationBar is)
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  bool _showBottomNavBar =
      true; // State to control BottomNavigationBar visibility

  // This method will be called by ScrollWidget when the user scrolls
  void _updateBottomNavBarVisibility(bool show) {
    if (mounted) {
      //check if the widget is mounted before calling setState
      setState(() {
        _showBottomNavBar = show;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollWidget(
        updateBottomNavBarVisibility: _updateBottomNavBarVisibility,
      ),
      // Use the other widget
      bottomNavigationBar:
          _showBottomNavBar
              ? BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: 'Search',
                  ),
                ],
              )
              : null, // Hide the BottomNavigationBar
    );
  }
}

class ScrollWidget extends StatefulWidget {
  final void Function(bool) updateBottomNavBarVisibility; // Callback function

  ScrollWidget({required this.updateBottomNavBarVisibility});

  @override
  _ScrollWidgetState createState() => _ScrollWidgetState();
}

class _ScrollWidgetState extends State<ScrollWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll); // Listen to scroll events
  }

  void _onScroll() {
    // Check the scroll direction
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      // If scrolling down, hide the BottomNavigationBar
      widget.updateBottomNavBarVisibility(false);
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      // If scrolling up, show the BottomNavigationBar
      widget.updateBottomNavBarVisibility(true);
    }
    // You might also want to hide it if the user scrolls to the very bottom or top.
    if (_scrollController.offset <=
        _scrollController.position.minScrollExtent) {
      widget.updateBottomNavBarVisibility(true);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll); // Remove the listener
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController, // Attach the scroll controller
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Text("Scroll Me", style: TextStyle(fontSize: 24)),
              SizedBox(height: 50),
              // Add a lot of content to make it scrollable
              for (int i = 0; i < 50; i++)
                Text("Item $i", style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: HomeWidget()));
}
