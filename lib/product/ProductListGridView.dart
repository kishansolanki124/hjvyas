import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hjvyas/product/ProductPaginationController.dart';

import '../api/models/CategoryListResponse.dart';
import '../api/services/HJVyasApiService.dart';
import '../home/navigation.dart';
import '../injection_container.dart';
import '../product_detail/ImageWithProgress.dart';
import '../splash/NoIntternetScreen.dart';
import '../utils/CommonAppProgress.dart';
import 'ProductListItemWidget.dart';

class ProductListGridView extends StatefulWidget {
  final ProductPaginationController paginationController =
      ProductPaginationController(getIt<HJVyasApiService>());

  CategoryListItem categoryListItem;
  String logoURL;

  final void Function(bool) updateBottomNavBarVisibility; // Callback function

  ProductListGridView({
    super.key,
    required this.categoryListItem,
    required this.logoURL,
    required this.updateBottomNavBarVisibility,
  });

  @override
  State<ProductListGridView> createState() => _ProductListGridViewState();
}

class _ProductListGridViewState extends State<ProductListGridView> {
  String logoURL = "";

  bool scrollBarShowing = true;

  @override
  void initState() {
    super.initState();
    widget.paginationController.loadInitialData(
      int.parse(widget.categoryListItem.categoryId),
    ); // Explicit call
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _refreshData() {
    fetchData();
  }

  Future<void> fetchData() async {
    await widget.paginationController.loadInitialData(
      int.parse(widget.categoryListItem.categoryId),
    ); // Explicit call
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // Handle the back button press using the current recommended API
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        //show bottom nav if hidden on screen close
        NavigationExample.of(context)?.showBottomNav();
        if (didPop) return;

        NavigationExample.of(context)?.navigateToMenuPage();

        // final homeState = context.findAncestorStateOfType<_HomeWidgetState>();
        // homeState?._navigateToWidget(0);
        //return true;
      },
      child: Scaffold(
        body: Obx(() {
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
                widget.paginationController.loadMore(
                  int.parse(widget.categoryListItem.categoryId),
                );
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
                        SliverToBoxAdapter(
                          child: productListTopView(
                            widget.logoURL,
                            widget.categoryListItem.categoryName,
                          ),
                        ),

                        if (widget.paginationController.items.isEmpty &&
                            widget.paginationController.isLoading.value) ...[
                          SliverToBoxAdapter(child: getCommonProgressBar()),
                        ],

                        if (widget.paginationController.items.isEmpty &&
                            widget.paginationController.isError.value) ...[
                          //error handling
                          SliverToBoxAdapter(
                            child: NoInternetScreen(
                              showBackgroundImage: false,
                              onRetry: () {
                                _refreshData();
                              },
                            ),
                          ),
                        ],

                        SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // 2 columns
                                childAspectRatio:
                                    (1 / 1.9), // Adjust item aspect ratio
                              ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final isOddCount =
                                  widget.paginationController.items.length %
                                      2 !=
                                  0;
                              if (isOddCount &&
                                  index ==
                                      widget
                                          .paginationController
                                          .items
                                          .length &&
                                  widget.paginationController.items.length ==
                                      widget.paginationController.totalItems) {
                                if (kDebugMode) {
                                  print(
                                    'isOddCount $isOddCount and length is'
                                    ' ${widget.paginationController.items.length}',
                                  );
                                }

                                if ((widget.paginationController.items.length +
                                            1) %
                                        4 ==
                                    0) {
                                  // return Stack(
                                  //   children: [
                                  //     SizedBox(
                                  //       height: 110,
                                  //       child: Container(color: Colors.white),
                                  //     ),
                                  //   ],
                                  // );
                                } else {
                                  // return SizedBox(
                                  //   height: 200,
                                  //   child: Align(
                                  //     alignment: Alignment.bottomCenter,
                                  //     child: Stack(
                                  //       children: [
                                  //         SizedBox(
                                  //           height: 120,
                                  //           child: Container(color: Colors.white),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // );
                                }
                              }

                              // Return normal items
                              if (index <
                                  widget.paginationController.items.length) {
                                return ProductListItemWidget(
                                  index: index,
                                  item:
                                      widget.paginationController.items[index],
                                );
                              }

                              return null;
                            },
                            childCount:
                                widget.paginationController.items.length +
                                (widget.paginationController.items.length % 2) +
                                (widget.paginationController.items.length ==
                                        widget.paginationController.totalItems
                                    ? 1
                                    : 0),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child:
                              (widget.paginationController.isLoading.value &&
                                      widget
                                          .paginationController
                                          .items
                                          .isNotEmpty)
                                  ? Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Center(
                                      child: getCommonProgressBar(),
                                    ),
                                  )
                                  //: SizedBox.shrink(),
                                  : SizedBox(height: 20),
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

Widget productListTopView(String logoURL, String title) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // App Logo
        // App Name
        Expanded(
          child: Text(
            textAlign: TextAlign.center,
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontFamily: "Archistico",
            ),
          ),
        ),

        if (logoURL.isNotEmpty)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Hero(
                tag: "app_logo",
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: ImageWithProgress(imageURL: logoURL),
                ),
              ),
            ),
          ),
      ],
    ),
  );
}

// Widget productListItem(ProductListItem item, int index, navigateToDetails) {
//   Widget lloadWidget;
//
//   if (index % 4 == 0) {
//     lloadWidget = ProductGridFirstItem(
//       imageUrl: item.productImage,
//       title: item.productName,
//       price: item.productPrice,
//       productWeight: item.productWeight,
//       productLife: item.productLife,
//       calories: item.productCalories,
//       productSoldout: item.productSoldout,
//     );
//   } else if (index % 4 == 1) {
//     lloadWidget = ProductGridSecondItem(
//       imageUrl: item.productImage,
//       title: item.productName,
//       price: item.productPrice,
//       productWeight: item.productWeight,
//       productLife: item.productLife,
//       calories: item.productCalories,
//       productSoldout: item.productSoldout,
//     );
//   } else if (index % 4 == 2) {
//     lloadWidget = ProductGridThirdItem(
//       imageUrl: item.productImage,
//       title: item.productName,
//       price: item.productPrice,
//       productWeight: item.productWeight,
//       productLife: item.productLife,
//       calories: item.productCalories,
//       productSoldout: item.productSoldout,
//     );
//   } else {
//     lloadWidget = ProductGridFourthItem(
//       imageUrl: item.productImage,
//       title: item.productName,
//       price: item.productPrice,
//       productWeight: item.productWeight,
//       productLife: item.productLife,
//       calories: item.productCalories,
//       productSoldout: item.productSoldout,
//     );
//   }
//
//   return GestureDetector(
//     onTap: () {
//       navigateToDetails(index, item);
//     },
//     child: lloadWidget,
//   );
// }
