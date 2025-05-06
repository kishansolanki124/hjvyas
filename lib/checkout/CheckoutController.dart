import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/models/AddOrderResponse.dart';
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

  Rx<ShippingChargesResponse?> addRazorpayStatusResponse =
      Rx<ShippingChargesResponse?>(null);

  Rx<AddOrderResponse?> addOrderResponse = Rx<AddOrderResponse?>(null);

  //var productTesterList = <ProductTesterListItem>[].obs;
  //var items = <ProductListItem>[].obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var shippingChargesLoading = false.obs;
  var addRazorpayStatusLoading = false.obs;
  var addOrderResponseLoading = false.obs;

  //var cartItemsLoading = false.obs;
  var testerItemsLoading = false.obs;

  //final int itemsPerPage = 10; // Adjust based on API

  Future<void> getShippingStatus() async {
    isLoading(true);
    isError(false);
    try {
      shippingStatusResponse.value = await _service.getShippingStatus();
      //cartItems.assignAll(newItems.productCartList);
    } catch (exception) {
      isError(true);
      exception.printError();
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

  Future<void> addRazorpayStatus(
    String order_no,
    String razorpay_orderid,
    String razorpay_paymentid,
  ) async {
    addRazorpayStatusLoading(true);
    try {
      addRazorpayStatusResponse.value = await _service.addRazorpayStatus(
        order_no,
        razorpay_orderid,
        razorpay_paymentid,
      );
      //cartItems.assignAll(newItems.productCartList);
    } finally {
      addRazorpayStatusLoading(false);
    }
  }

  Future<void> addOrder(
    String customerName,
    String customerEmail,
    String contactNo,
    String alternateContactNo,
    String deliveryAddress,
    String postalCode,
    String country,
    String state,
    String city,
    String gift_sender,
    String gift_sender_mobile,
    String gift_receiver,
    String gift_receiver_mobile,
    String product_tester_id,
    String order_amount,
    String shipping_charge,
    String transaction_charge,
    String payment_type,
    String platform,
    String product_id,
    String product_type,
    String product_name,
    String packing_id,
    String packing_weight,
    String packing_weight_type,
    String packing_quantity,
    String packing_price,
    String notes,
  ) async {
    addOrderResponseLoading(true);
    try {
      addOrderResponse.value = await _service.addOrder(
        customerName,
        customerEmail,
        contactNo,
        alternateContactNo,
        deliveryAddress,
        postalCode,
        country,
        state,
        city,
        gift_sender,
        gift_sender_mobile,
        gift_receiver,
        gift_receiver_mobile,
        product_tester_id,
        order_amount,
        shipping_charge,
        transaction_charge,
        payment_type,
        platform,
        product_id,
        product_type,
        product_name,
        packing_id,
        packing_weight,
        packing_weight_type,
        packing_quantity,
        packing_price,
        notes,
      );
    } finally {
      addOrderResponseLoading(false);
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
