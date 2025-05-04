import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/models/NotificationListResponse.dart';
import '../api/models/ProductCartResponse.dart';
import '../api/models/ProductTesterResponse.dart';
import '../api/services/HJVyasApiService.dart'; // Or your state management solution

class NotificationPaginationController extends GetxController {
  final HJVyasApiService _service;
  final PageController pageController = PageController();

  NotificationPaginationController(this._service);

  var items = <NotificationListItem>[].obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var currentPage = 0;
  var totalItems = 0;
  final int itemsPerPage = 10; // Adjust based on API

  Future<void> loadInitialData() async {
    isLoading(true);
    try {
      final newItems = await _service.getNotification(
        currentPage.toString(),
        itemsPerPage.toString(),
      );
      items.assignAll(newItems.notificationList);
      //totalItems = newItems.totalRecords;//todo work on this its not coming from API
      totalItems = items.length;
      currentPage += 10;
      isError(false);

    } catch (exception) {
      isError(true);
      exception.printError();
    } finally {
      isLoading(false);
    }
  }

  Future<void> loadMore() async {
    if (isLoading.value) return;

    if (totalItems != 0 && items.length >= totalItems) {
      return;
    }

    if (kDebugMode) {
      print(
        'new page loaded with totalItems: $totalItems amd items.length is ${items.length}',
      );
    }

    isLoading(true);
    try {
      final newItems = await _service.getNotification(
        (currentPage).toString(),
        (currentPage + itemsPerPage).toString(),
      );

      if (newItems.notificationList.isNotEmpty) {
        items.addAll(newItems.notificationList);
        currentPage += 10;
      }
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
