import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/models/ProductCartResponse.dart';
import '../api/models/ProductListResponse.dart';
import '../api/services/HJVyasApiService.dart'; // Or your state management solution

class ProductPaginationController extends GetxController {
  final HJVyasApiService _service;
  final PageController pageController = PageController();

  ProductPaginationController(this._service);

  var cartItems = <ProductCartListItem>[].obs;
  var items = <ProductListItem>[].obs;
  var isLoading = false.obs;
  var cartItemsLoading = false.obs;
  var cartMaxQty = 0;
  var currentPage = 0;
  var totalItems = 0;
  final int itemsPerPage = 10; // Adjust based on API

  Future<void> getProductCart(
    String cartPackingId,
    String cartProductType,
  ) async {
    cartItemsLoading(true);
    try {
      final newItems = await _service.getProductCart(
        cartPackingId,
        cartProductType,
      );
      cartMaxQty = int.parse(newItems.productMaxQty);
      cartItems.assignAll(newItems.productCartList);
    } finally {
      cartItemsLoading(false);
    }
  }

  Future<void> loadInitialData(int categoryId) async {
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

  Future<void> loadMore(int categoryId) async {
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
