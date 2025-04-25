import 'package:get/get.dart';
import 'package:hjvyas/api/models/ProductDetailResponse.dart';

import '../api/services/HJVyasApiService.dart';

class ProductDetailController extends GetxController {
  final HJVyasApiService _service;
  var loading = false.obs;
  final Rx<ProductDetailResponse?> productDetailResponse =
      Rx<ProductDetailResponse?>(null);
  var error = ''.obs;

  ProductDetailController(this._service);

  Future<void> getProductDetail(String productId) async {
    try {
      loading(true);
      final response = await _service.getProductDetail(productId);
      productDetailResponse.value = response;
      // // Force update if needed for complex widgets
      // update();
    } catch (e) {
      error(e.toString());
    } finally {
      loading(false);
    }
  }
}
