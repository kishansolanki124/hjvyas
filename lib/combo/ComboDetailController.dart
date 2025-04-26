import 'package:get/get.dart';
import 'package:hjvyas/api/models/ComboDetailResponse.dart';

import '../api/models/AddInquiryResponse.dart';
import '../api/services/HJVyasApiService.dart';

class ComboDetailController extends GetxController {
  final HJVyasApiService _service;
  var loading = false.obs;
  final Rx<ComboDetailResponse?> comboDetailResponse = Rx<ComboDetailResponse?>(
    null,
  );
  var error = ''.obs;

  var adInquiryLoading = false.obs;
  final Rx<AddInquiryResponse?> addInquiryResponse = Rx<AddInquiryResponse?>(
    null,
  );
  var adInquiryError = ''.obs;

  ComboDetailController(this._service);

  Future<void> getComboDetail(String comboId) async {
    try {
      loading(true);
      final response = await _service.getComboDetail(comboId);
      comboDetailResponse.value = response;
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
