import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hjvyas/api/models/ComboListResponse.dart';

import '../api/services/HJVyasApiService.dart';
import '../injection_container.dart';
import '../product_detail/ProductDetail.dart';
import 'ComboFirstItem.dart';
import 'ComboFourthItem.dart';
import 'ComboPaginationController.dart';
import 'ComboSecondItem.dart';
import 'ComboThirdItem.dart';

class Combowidget extends StatefulWidget {
  final ComboPaginationController paginationController =
      ComboPaginationController(getIt<HJVyasApiService>());

  final void Function(bool) updateBottomNavBarVisibility; // Callback function

  Combowidget({super.key,
    required this.updateBottomNavBarVisibility,
  });

  @override
  State<Combowidget> createState() => _CombowidgetState();
}

class _CombowidgetState extends State<Combowidget> {
  void _navigateToDetails(int index, ComboListItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => //ProductDetail(item: item),
                ProductDetail(
              parentPrice: item.comboPrice.isNotEmpty ? item.comboPrice : "",
            ),
      ),
    );
  }

  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    widget.paginationController.loadInitialData(); // Explicit call
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
    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          if (widget.paginationController.items.isEmpty &&
              widget.paginationController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
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
                  // A non-scrolling widget at the top
                  productListTopView(),
                  // Use Expanded or Flexible to give the CustomScrollView a portion of the space
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // 2 columns
                                childAspectRatio:
                                    (1 / 1.9), // Adjust item aspect ratio
                              ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return comboListItem(
                                widget.paginationController.items[index],
                                index,
                                _navigateToDetails,
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
                                  : SizedBox.shrink(),
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
    padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
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

Widget comboListItem(ComboListItem item, int index, navigateToDetails) {
  Widget lloadWidget;

  if (index % 4 == 0) {
    lloadWidget = ComboFirstItem(
      imageUrl: item.comboImage,
      title: item.comboName,
      price: item.comboPrice,
      productLife: item.comboWeight,
      calories: item.comboSpecification,
    );
  } else if (index % 4 == 1) {
    lloadWidget = ComboSecondItem(
      imageUrl: item.comboImage,
      title: item.comboName,
      price: item.comboPrice,
      productLife: item.comboWeight,
      calories: item.comboSpecification,
    );
  } else if (index % 4 == 2) {
    lloadWidget = ComboThirdItem(
      imageUrl: item.comboImage,
      title: item.comboName,
      price: item.comboPrice,
      productLife: item.comboWeight,
      calories: item.comboSpecification,
    );
  } else {
    lloadWidget = ComboFourthItem(
      imageUrl: item.comboImage,
      title: item.comboName,
      price: item.comboPrice,
      productLife: item.comboWeight,
      calories: item.comboSpecification,
    );
  }

  return GestureDetector(
    onTap: () {
      navigateToDetails(index, item);
    },
    child: lloadWidget,
  );
}
