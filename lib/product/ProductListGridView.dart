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

class ProductListGridView extends StatefulWidget {
  final ProductPaginationController paginationController =
      ProductPaginationController(getIt<HJVyasApiService>());

  ProductListGridView({super.key});

  @override
  State<ProductListGridView> createState() => _ProductListGridViewState();
}

class _ProductListGridViewState extends State<ProductListGridView> {
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
                              return productListItem(
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
        // App Logo
        // App Name
        Expanded(
          child: Text(
            textAlign: TextAlign.center,
            "DryFruit Kachori",
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
  );
}

Widget productListItem(ProductListItem item, int index, navigateToDetails) {
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
      navigateToDetails(index, item);
    },
    child: lloadWidget,
  );
}
