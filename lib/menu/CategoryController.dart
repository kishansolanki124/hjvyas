import 'package:get/get.dart';
import 'package:hjvyas/api/models/AddInquiryResponse.dart';
import 'package:hjvyas/api/models/ContactusResponse.dart';

import '../api/models/CategoryListResponse.dart';
import '../api/services/HJVyasApiService.dart';

class CategoryController extends GetxController {
  final HJVyasApiService _service;
  var isLoading = true.obs;
  var adInquiryLoading = false.obs;
  var categories = <CategoryListItem>[].obs;
  var contactItem = <ContactListItem>[].obs;
  final Rx<AddInquiryResponse?> addInquiryResponse = Rx<AddInquiryResponse?>(
    null,
  );
  var error = ''.obs;
  var adInquiryError = ''.obs;

  CategoryController(this._service);

  Future<void> loadCategories() async {
    try {
      isLoading(true);
      final response = await _service.getCategory();
      categories.assignAll(
        response.categoryList,
      ); // Assuming response has .categories
      error("");
    } catch (e) {
      error(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> getContactus() async {
    try {
      error("");
      isLoading(true);
      final response = await _service.getContactus();
      contactItem.assignAll(
        response.contactList,
      ); // Assuming response has .categories

      // Force update if needed for complex widgets
      update();
    } catch (e) {
      error(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> addInquiry(
    String inquiry_type,
    String name,
    String contact_no,
    String email,
    String city,
    String message,
  ) async {
    try {
      adInquiryLoading(true);
      final response = await _service.addInquiry(
        inquiry_type,
        name,
        contact_no,
        email,
        city,
        message,
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
