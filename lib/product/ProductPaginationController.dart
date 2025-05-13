import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/models/ProductCartResponse.dart';
import '../api/models/ProductListResponse.dart';
import '../api/models/ProductTesterResponse.dart';
import '../api/services/HJVyasApiService.dart'; // Or your state management solution

class ProductPaginationController extends GetxController {
  final HJVyasApiService _service;
  final PageController pageController = PageController();

  ProductPaginationController(this._service);

  var cartItems = <ProductCartListItem>[].obs;
  Rx<ProductTesterResponse?> productTesterResponse = Rx<ProductTesterResponse?>(
    null,
  );
  var productTesterList = <ProductTesterListItem>[].obs;
  var items = <ProductListItem>[].obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var cartItemsLoading = false.obs;
  var testerItemsLoading = false.obs;
  var cartMaxQty = 0;
  var currentPage = 0;
  var totalItems = 0;
  final int itemsPerPage = 10; // Adjust based on API

  Future<void> getProductCart(
    String cartPackingId,
    String cartProductType,
  ) async {
    isError(false);
    cartItemsLoading(true);
    try {
      final newItems = await _service.getProductCart(
        cartPackingId,
        cartProductType,
      );
      cartMaxQty = int.parse(newItems.productMaxQty);
      cartItems.assignAll(newItems.productCartList);
    } catch (exception) {
      isError(true);
      exception.printError();
    } finally {
      cartItemsLoading(false);
    }
  }

  Future<void> getProductTester(String cartProductId, String cartTotal) async {
    testerItemsLoading(true);
    try {
      productTesterResponse.value = await _service.getProductTester(
        cartProductId,
        cartTotal,
      );
      productTesterList.assignAll(
        productTesterResponse.value!.productTesterList,
      );
    } finally {
      testerItemsLoading(false);
    }
  }

  Future<void> loadInitialData(int categoryId) async {
    if(items.value.isNotEmpty) {
      items.value.clear();
    }

    currentPage = 0;
    isError(false);
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
      isError(false);
    } catch (exception) {
      isError(true);
      exception.printError();
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
