import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/models/ShippingChargesResponse.dart';
import '../api/models/ShippingStatusResponse.dart';
import '../api/services/HJVyasApiService.dart'; // Or your state management solution

class CheckoutController extends GetxController {
  final HJVyasApiService _service;
  final PageController pageController = PageController();

  CheckoutController(this._service);

  //var cartItems = <ProductCartListItem>[].obs;
  Rx<ShippingStatusResponse?> shippingStatusResponse =
      Rx<ShippingStatusResponse?>(null);

  Rx<ShippingChargesResponse?> shippingChargesResponse =
      Rx<ShippingChargesResponse?>(null);

  //var productTesterList = <ProductTesterListItem>[].obs;
  //var items = <ProductListItem>[].obs;
  var isLoading = false.obs;
  var shippingChargesLoading = false.obs;

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

  Future<void> getShippingCharge(
    String cityJamnagar,
    String cityOther,
    String stateOutofGujarat,
    String countryOutside,
    String cartWeight,
    String cartAmount,
  ) async {
    shippingChargesLoading(true);
    try {
      shippingChargesResponse.value = await _service.getShippingCharge(
        cityJamnagar,
        cityOther,
        stateOutofGujarat,
        countryOutside,
        cartWeight,
        cartAmount,
      );
      //cartItems.assignAll(newItems.productCartList);
    } finally {
      shippingChargesLoading(false);
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
