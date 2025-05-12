import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hjvyas/notification/EmptyNotification.dart';

import '../api/services/HJVyasApiService.dart';
import '../injection_container.dart';
import '../product_detail/ProductDetailWidget.dart';
import '../splash/NoIntternetScreen.dart';
import '../utils/CommonAppProgress.dart';
import 'NotificationListItemWdiget.dart';
import 'NotificationPaginationController.dart';

class NotificationList extends StatefulWidget {
  final NotificationPaginationController paginationController =
      NotificationPaginationController(getIt<HJVyasApiService>());

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  @override
  void initState() {
    super.initState();
    widget.paginationController.loadInitialData(); // Explicit call
  }

  void _refreshData() {
    fetchData();
  }

  Future<void> fetchData() async {
    widget.paginationController.loadInitialData(); // Explicit call
  }

  void _onBackPressed(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
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
                    height: 80,
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

                backButton(() => _onBackPressed(context)),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 40.0),

                      // Title
                      Center(
                        child: Container(
                          color: Color.fromARGB(255, 31, 47, 80),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Notification',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 8.0), // Description
                      // 3. Expanded List
                      if (widget.paginationController.items.isEmpty &&
                          widget.paginationController.isLoading.value) ...[
                        //progress bar
                        getCommonProgressBar(),
                      ],

                      if (widget.paginationController.isError.value) ...[
                        Expanded(
                          child: NoInternetScreen(
                            showBackgroundImage: false,
                            onRetry: () {
                              _refreshData();
                            },
                          ),
                        ),
                      ],

                      if (!widget.paginationController.isLoading.value &&
                          widget.paginationController.items.isEmpty)
                        EmptyNotification(showBackButton: false),

                      if (widget.paginationController.items.isNotEmpty)
                        Expanded(
                          child: ListView.builder(
                            itemCount: widget.paginationController.totalItems,
                            itemBuilder: (context, index) {
                              final item =
                                  widget.paginationController.items[index];
                              return NotificationListItemWdiget(
                                title: item.name,
                                description: item.description,
                                date: item.pdate,
                                index: index,
                              );
                            }, // Use your custom list widget here
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
