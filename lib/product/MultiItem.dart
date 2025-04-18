import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hjvyas/api/models/ProductListResponse.dart';
import 'package:hjvyas/product/ProductPaginationController.dart';

import '../api/services/HJVyasApiService.dart';
import '../injection_container.dart';
import '../product_detail/ProductDetail.dart';
import 'GridFourthItem.dart';
import 'GridItem.dart';
import 'GridOddItem.dart';
import 'GridThirdItem.dart';

class AppLogoNameGridView extends StatefulWidget {
  final ProductPaginationController paginationController =
      ProductPaginationController(getIt<HJVyasApiService>());

  // final List<Map<String, String>> gridItems;

  //AppLogoNameGridView({required this.gridItems});
  AppLogoNameGridView();

  @override
  State<AppLogoNameGridView> createState() => _AppLogoNameGridViewState();
}

class _AppLogoNameGridViewState extends State<AppLogoNameGridView> {
  @override
  void initState() {
    super.initState();
    widget.paginationController.loadInitialData(); // Explicit call
  }

  void _navigateToDetails(int index, ProductListItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => //ProductDetail(item: item),
                ProductDetail(
              parentPrice:
                  item.productPrice.isNotEmpty ? item.productPrice : "",
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Products')),
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
          child: Scaffold(
            body: Container(
          decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/bg.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: CustomScrollView(
                slivers: [
                  SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 columns
                      childAspectRatio: (1 / 1.9), // Adjust item aspect ratio
                      // mainAxisSpacing: 10,
                      // crossAxisSpacing: 10,
                    ),
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return ProductItem(
                        widget.paginationController.items[index],
                        index,
                        _navigateToDetails,
                      );
                    }, childCount: widget.paginationController.items.length),
                  ),
                  SliverToBoxAdapter(
                    child:
                    widget.paginationController.isLoading.value
                        ? Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    )
                        : SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          )
        );
      }),
    );

    // return Scaffold(
    //   body: Container(
    //     decoration: BoxDecoration(
    //       image: DecorationImage(
    //         image: AssetImage("images/bg.jpg"),
    //         fit: BoxFit.cover,
    //       ),
    //     ),
    //     child: SingleChildScrollView(
    //       child: Column(
    //         children: <Widget>[
    //           Padding(
    //             padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceAround,
    //               children: [
    //                 // App Logo
    //                 // App Name
    //                 Expanded(
    //                   child: Text(
    //                     textAlign: TextAlign.center,
    //                     "DryFruit Kachori",
    //                     style: TextStyle(
    //                       color: Colors.white,
    //                       fontSize: 30,
    //                       fontFamily: "Archistico",
    //                     ),
    //                   ),
    //                 ),
    //
    //                 Expanded(
    //                   child: Padding(
    //                     padding: const EdgeInsets.all(16.0),
    //                     child: Image.asset(
    //                       "images/logo.png",
    //                       height: 80, // Adjust logo height as needed
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //
    //           // GridView
    //           GridView.builder(
    //             shrinkWrap: true,
    //             physics: NeverScrollableScrollPhysics(),
    //             // Disable GridView scrolling
    //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //               crossAxisCount: 2,
    //               childAspectRatio: (1 / 1.9),
    //             ),
    //             itemCount: widget.gridItems.length,
    //             itemBuilder: (context, index) {
    //               Widget lloadWidget;
    //
    //               if (index % 4 == 0) {
    //                 lloadWidget = GridOddItem(
    //                   imageUrl: widget.gridItems[index]['imageUrl']!,
    //                   title: widget.gridItems[index]['title']!,
    //                   price: widget.gridItems[index]['price']!,
    //                   productLife: widget.gridItems[index]['calories']!,
    //                   calories: widget.gridItems[index]['productLife']!,
    //                 );
    //               } else if (index % 4 == 1) {
    //                 lloadWidget = GridItem(
    //                   imageUrl: widget.gridItems[index]['imageUrl']!,
    //                   title: widget.gridItems[index]['title']!,
    //                   price: widget.gridItems[index]['price']!,
    //                   productLife: widget.gridItems[index]['calories']!,
    //                   calories: widget.gridItems[index]['productLife']!,
    //                 );
    //               } else if (index % 4 == 2) {
    //                 lloadWidget = Gridthirditem(
    //                   imageUrl: widget.gridItems[index]['imageUrl']!,
    //                   title: widget.gridItems[index]['title']!,
    //                   price: widget.gridItems[index]['price']!,
    //                   productLife: widget.gridItems[index]['calories']!,
    //                   calories: widget.gridItems[index]['productLife']!,
    //                 );
    //               } else {
    //                 lloadWidget = Gridfourthitem(
    //                   imageUrl: widget.gridItems[index]['imageUrl']!,
    //                   title: widget.gridItems[index]['title']!,
    //                   price: widget.gridItems[index]['price']!,
    //                   productLife: widget.gridItems[index]['calories']!,
    //                   calories: widget.gridItems[index]['productLife']!,
    //                 );
    //               }
    //
    //               return GestureDetector(
    //                 onTap: () {
    //                   Navigator.push(
    //                     context,
    //                     MaterialPageRoute(
    //                       builder:
    //                           (context) => //ProductDetail(item: item),
    //                               ProductDetail(
    //                             parentPrice:
    //                                 widget.gridItems[index]['price'] != null
    //                                     ? widget.gridItems[index]['price']!
    //                                     : "",
    //                           ),
    //                     ),
    //                   );
    //                 },
    //                 child: lloadWidget,
    //               );
    //             },
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}

Widget ProductItem(ProductListItem item, int index, _navigateToDetails) {
  Widget lloadWidget;

  if (index % 4 == 0) {
    lloadWidget = GridOddItem(
      imageUrl: item.productImage,
      title: item.productName,
      price: item.productPrice,
      productLife: item.productLife,
      calories: item.productCalories,
    );
  } else if (index % 4 == 1) {
    lloadWidget = GridItem(
      imageUrl: item.productImage,
      title: item.productName,
      price: item.productPrice,
      productLife: item.productLife,
      calories: item.productCalories,
    );
  } else if (index % 4 == 2) {
    lloadWidget = Gridthirditem(
      imageUrl: item.productImage,
      title: item.productName,
      price: item.productPrice,
      productLife: item.productLife,
      calories: item.productCalories,
    );
  } else {
    lloadWidget = Gridfourthitem(
      imageUrl: item.productImage,
      title: item.productName,
      price: item.productPrice,
      productLife: item.productLife,
      calories: item.productCalories,
    );
  }

  return GestureDetector(
    onTap: () {
      _navigateToDetails(index, item);
    },
    child: lloadWidget,
  );
}
