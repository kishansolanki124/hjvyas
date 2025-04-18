import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/models/ProductListResponse.dart';
import '../api/services/HJVyasApiService.dart'; // Or your state management solution

class ProductPaginationController extends GetxController {
  final HJVyasApiService _service;
  final PageController pageController = PageController();

  ProductPaginationController(this._service);

  var items = <ProductListItem>[].obs;
  var isLoading = false.obs;
  var categoryId = 1; //todo make this dynamic
  var currentPage = 0;
  var totalItems = 0;
  final int itemsPerPage = 10; // Adjust based on API

  Future<void> loadInitialData() async {
    isLoading(true);
    try {
      final newItems = await _service.getProduct(
        currentPage.toString(),
        itemsPerPage.toString(),
        categoryId,
      );
      items.assignAll(newItems.productList);
      totalItems = newItems.totalRecords;
      currentPage += 10;
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
      final newItems = await _service.getProduct(
        (currentPage).toString(),
        (currentPage + itemsPerPage).toString(),
        categoryId,
      );

      if (newItems.productList.isNotEmpty) {
        items.addAll(newItems.productList);
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
