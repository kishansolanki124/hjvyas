import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../api/services/HJVyasApiService.dart';
import '../injection_container.dart';
import 'ComboListItemWidget.dart';
import 'ComboPaginationController.dart';

class ComboWidget extends StatefulWidget {
  final ComboPaginationController paginationController =
      ComboPaginationController(getIt<HJVyasApiService>());

  final void Function(bool) updateBottomNavBarVisibility; // Callback function

  ComboWidget({super.key, required this.updateBottomNavBarVisibility});

  @override
  State<ComboWidget> createState() => _ComboWidgetState();
}

class _ComboWidgetState extends State<ComboWidget> {
  bool scrollBarShowing = true;

  // void _navigateToDetails(int index, ComboListItem item) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder:
  //           (context) => //ProductDetail(item: item),
  //               ComboDetail(
  //             comboId: item.comboId,
  //             isOutOfStock: item.comboSoldout.isEmpty ? false : true,
  //           ),
  //     ),
  //   );
  // }

  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    widget.paginationController.loadInitialData(); // Explicit call
    //_scrollController.addListener(_onScroll); // Listen to scroll events
  }

  // void _onScroll() {
  //   // Check the scroll direction
  //   if (_scrollController.position.userScrollDirection ==
  //       ScrollDirection.reverse) {
  //     // If scrolling down, hide the BottomNavigationBar
  //     widget.updateBottomNavBarVisibility(false);
  //     print('On scroll update bottom nav visibility status to ${widget.updateBottomNavBarVisibility}');
  //   } else if (_scrollController.position.userScrollDirection ==
  //       ScrollDirection.forward) {
  //     // If scrolling up, show the BottomNavigationBar
  //     widget.updateBottomNavBarVisibility(true);
  //     print('On scroll update bottom nav visibility status to ${widget.updateBottomNavBarVisibility}');
  //   }
  //   // You might also want to hide it if the user scrolls to the very bottom or top.
  //   if (_scrollController.offset <=
  //       _scrollController.position.minScrollExtent) {
  //     widget.updateBottomNavBarVisibility(true);
  //     print('On scroll update bottom nav visibility status to ${widget.updateBottomNavBarVisibility}');
  //   }
  // }

  @override
  void dispose() {
    //_scrollController.removeListener(_onScroll); // Remove the listener
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          if (widget.paginationController.items.isEmpty &&
              widget.paginationController.isLoading.value) {
            //todo: change this
            return Center(child: CircularProgressIndicator());
          }

          //todo: add error handler with retry

          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollUpdateNotification) {
                // Check if user is scrolling up or down
                if (notification.scrollDelta! > 0 && scrollBarShowing) {
                  // Scrolling down, hide the bottom bar
                  setState(() {
                    scrollBarShowing = false;
                    widget.updateBottomNavBarVisibility(false);
                  });
                } else if (notification.scrollDelta! < 0 && !scrollBarShowing) {
                  // Scrolling up, show the bottom bar
                  setState(() {
                    scrollBarShowing = true;
                    widget.updateBottomNavBarVisibility(true);
                  });
                }
              }

              if (notification is ScrollEndNotification &&
                  notification.metrics.pixels ==
                      notification.metrics.maxScrollExtent) {
                widget.paginationController.loadMore();
              }
              return false;
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/bg.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: <Widget>[
                  // Use Expanded or Flexible to give the CustomScrollView a portion of the space
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(child: productListTopView()),

                        SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // 2 columns
                                childAspectRatio:
                                    (1 / 1.8), // Adjust item aspect ratio
                              ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return ComboListItemWidget(
                                item: widget.paginationController.items[index],
                                index: index,
                              );
                            },
                            childCount:
                                widget.paginationController.items.length,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child:
                              widget.paginationController.isLoading.value
                                  ? Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                  //: SizedBox.shrink(),
                                  : SizedBox(height: 100),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

Widget productListTopView() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        //combo top text
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

        // App Logo
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
  );
}

// Widget comboListItem(ComboListItem item, int index, navigateToDetails) {
//   Widget lloadWidget;
//
//   if (index % 4 == 0) {
//     lloadWidget = ComboFirstItem(
//       imageUrl: item.comboImage,
//       title: item.comboName,
//       price: item.comboPrice,
//       comboWeight: item.comboWeight,
//       comboSoldout: item.comboSoldout,
//       comboSpecification: item.comboSpecification,
//     );
//   } else if (index % 4 == 1) {
//     lloadWidget = ComboSecondItem(
//       imageUrl: item.comboImage,
//       title: item.comboName,
//       price: item.comboPrice,
//       comboWeight: item.comboWeight,
//       comboSoldout: item.comboSoldout,
//       comboSpecification: item.comboSpecification,
//     );
//   } else if (index % 4 == 2) {
//     lloadWidget = ComboThirdItem(
//       imageUrl: item.comboImage,
//       title: item.comboName,
//       price: item.comboPrice,
//       comboWeight: item.comboWeight,
//       comboSoldout: item.comboSoldout,
//       comboSpecification: item.comboSpecification,
//     );
//   } else {
//     lloadWidget = ComboFourthItem(
//       imageUrl: item.comboImage,
//       title: item.comboName,
//       price: item.comboPrice,
//       comboWeight: item.comboWeight,
//       comboSoldout: item.comboSoldout,
//       comboSpecification: item.comboSpecification,
//     );
//   }
//
//   return SlideTransition(
//       position: _slideAnimation,
//       child: FadeTransition(
//       opacity: _animationController,
//       child: GestureDetector(
//     onTap: () {
//       navigateToDetails(index, item);
//     },
//     child: lloadWidget,
//   ),
//   ),
//   );
// }
