import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hjvyas/api/models/ComboListResponse.dart';

import '../api/services/HJVyasApiService.dart'; // Or your state management solution

class ComboPaginationController extends GetxController {
  final HJVyasApiService _service;
  final PageController pageController = PageController();

  ComboPaginationController(this._service);

  var items = <ComboListItem>[].obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var currentPage = 0;
  var totalItems = 0;
  final int itemsPerPage = 10; // Adjust based on API

  Future<void> loadInitialData() async {
    isLoading(true);
    isError(false);
    try {
      final newItems = await _service.getCombo(
        currentPage.toString(),
        itemsPerPage.toString(),
      );
      items.assignAll(newItems.comboList);
      totalItems = newItems.totalRecords;
      currentPage += 10;
    } catch (exception) {
      exception.printError();
      isError(true);
    } finally {
      isLoading(false);
    }
  }

  Future<void> loadMore() async {
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
      final newItems = await _service.getCombo(
        (currentPage).toString(),
        (currentPage + itemsPerPage).toString(),
      );

      if (newItems.comboList.isNotEmpty) {
        items.addAll(newItems.comboList);
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
