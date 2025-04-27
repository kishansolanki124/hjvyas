import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/models/ShippingStatusResponse.dart';
import '../api/services/HJVyasApiService.dart'; // Or your state management solution

class CheckoutController extends GetxController {
  final HJVyasApiService _service;
  final PageController pageController = PageController();

  CheckoutController(this._service);

  //var cartItems = <ProductCartListItem>[].obs;
  Rx<ShippingStatusResponse?> shippingStatusResponse =
      Rx<ShippingStatusResponse?>(null);

  //var productTesterList = <ProductTesterListItem>[].obs;
  //var items = <ProductListItem>[].obs;
  var isLoading = false.obs;

  //var cartItemsLoading = false.obs;
  var testerItemsLoading = false.obs;

  //final int itemsPerPage = 10; // Adjust based on API

  Future<void> getShippingStatus() async {
    isLoading(true);
    try {
      shippingStatusResponse.value = await _service.getShippingStatus();
      //cartItems.assignAll(newItems.productCartList);
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
