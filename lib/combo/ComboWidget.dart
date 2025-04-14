import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../product_detail/ProductDetail.dart';
import 'ComboFirstItem.dart';
import 'ComboFourthItem.dart';
import 'ComboSecondItem.dart';
import 'ComboThirdItem.dart';

class Combowidget extends StatefulWidget {
  final void Function(bool) updateBottomNavBarVisibility; // Callback function

  final List<Map<String, String>> gridItems;

  Combowidget({
    required this.gridItems,
    required this.updateBottomNavBarVisibility,
  });

  @override
  State<Combowidget> createState() => _CombowidgetState();
}

class _CombowidgetState extends State<Combowidget> {
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          controller: _scrollController, // Attach the scroll controller
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // App Logo
                    // App Name
                    Expanded(
                      child: Text(
                        textAlign: TextAlign.center,
                        "Combo",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: "Archistico",
                        ),
                      ),
                    ),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset(
                          "images/logo.png",
                          height: 80, // Adjust logo height as needed
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // GridView
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                // Disable GridView scrolling
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: (1 / 1.9),
                ),
                itemCount: widget.gridItems.length,
                itemBuilder: (context, index) {
                  Widget lloadWidget;
                  if (index % 4 == 0) {
                    lloadWidget = ComboFirstItem(
                      imageUrl: widget.gridItems[index]['imageUrl']!,
                      title: widget.gridItems[index]['title']!,
                      price: widget.gridItems[index]['price']!,
                      productLife: widget.gridItems[index]['productLife']!,
                      calories: widget.gridItems[index]['calories']!,
                    );
                  } else if (index % 4 == 1) {
                    lloadWidget = ComboSecondItem(
                      imageUrl: widget.gridItems[index]['imageUrl']!,
                      title: widget.gridItems[index]['title']!,
                      price: widget.gridItems[index]['price']!,
                      productLife: widget.gridItems[index]['productLife']!,
                      calories: widget.gridItems[index]['calories']!,
                    );
                  } else if (index % 4 == 2) {
                    lloadWidget = ComboThirdItem(
                      imageUrl: widget.gridItems[index]['imageUrl']!,
                      title: widget.gridItems[index]['title']!,
                      price: widget.gridItems[index]['price']!,
                      productLife: widget.gridItems[index]['productLife']!,
                      calories: widget.gridItems[index]['calories']!,
                    );
                  } else {
                    lloadWidget = ComboFourthItem(
                      imageUrl: widget.gridItems[index]['imageUrl']!,
                      title: widget.gridItems[index]['title']!,
                      price: widget.gridItems[index]['price']!,
                      productLife: widget.gridItems[index]['productLife']!,
                      calories: widget.gridItems[index]['calories']!,
                    );
                  }

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => //ProductDetail(item: item),
                          ProductDetail(
                            parentPrice:
                            widget.gridItems[index]['price'] != null
                                ? widget.gridItems[index]['price']!
                                : "",
                          ),
                        ),
                      );
                    },
                    child: lloadWidget,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
