import 'package:get/get.dart';

import '../api/models/CategoryListResponse.dart';
import '../api/services/HJVyasApiService.dart';

class CategoryController extends GetxController {
  final HJVyasApiService _service;
  var isLoading = true.obs;
  var categories = <CategoryListItem>[].obs;
  var error = ''.obs;

  CategoryController(this._service);

  Future<void> loadCategories() async {
    try {
      isLoading(true);
      final response = await _service.getCategory();
      categories.assignAll(
        response.categoryList,
      ); // Assuming response has .categories
    } catch (e) {
      error(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
