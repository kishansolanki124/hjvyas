import 'package:get/get.dart';
import 'package:hjvyas/api/models/ProductDetailResponse.dart';

import '../api/models/AddInquiryResponse.dart';
import '../api/services/HJVyasApiService.dart';

class ProductDetailController extends GetxController {
  final HJVyasApiService _service;
  var loading = false.obs;
  final Rx<ProductDetailResponse?> productDetailResponse =
      Rx<ProductDetailResponse?>(null);
  var error = ''.obs;


  var adInquiryLoading = false.obs;
  final Rx<AddInquiryResponse?> addInquiryResponse = Rx<AddInquiryResponse?>(
    null,
  );
  var adInquiryError = ''.obs;


  ProductDetailController(this._service);

  Future<void> getProductDetail(String productId) async {
    try {
      error("");
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

  Future<void> addInquiry(
      String product_id,
      String product_type,
      String user_mobile,
      String user_email,
      ) async {
    try {
      adInquiryLoading(true);
      final response = await _service.addNotifyMe(
        product_id,
        product_type,
        user_mobile,
        user_email,
      );
      addInquiryResponse.value = response;

      // Force update if needed for complex widgets
      update();
    } catch (e) {
      adInquiryError(e.toString());
    } finally {
      adInquiryLoading(false);
    }
  }
}
