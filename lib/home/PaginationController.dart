import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/models/HomeMediaResponse.dart';
import '../api/services/HJVyasApiService.dart'; // Or your state management solution

class PaginationController extends GetxController {
  final HJVyasApiService _service;
  final PageController pageController = PageController(
    initialPage: 0,
    viewportFraction: 0.8,
  );

  PaginationController(this._service);

  var items = <SliderListItem>[].obs;
  var popupListItem = <PopupListItem>[].obs;
  var appVersionList = <AppVersionListItem>[].obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var currentPage = 0;
  var totalItems = 0;
  final int itemsPerPage = 10; // Adjust based on API
  //
  // @override
  // void onInit() {
  //   loadInitialData(); // Called automatically when controller initializes
  //   super.onInit();
  // }

  Future<void> loadInitialData() async {
    isLoading(true);
    try {
      isError.value = false;
      final newItems = await _service.homeMediaApi(
        currentPage.toString(),
        itemsPerPage.toString(),
      );

      if(newItems.popupList.isNotEmpty) {
        popupListItem.clear();
        popupListItem.assignAll(newItems.popupList);
      }

      if(newItems.appVersionList.isNotEmpty) {
        appVersionList.clear();
        appVersionList.assignAll(newItems.appVersionList);
      }

      items.assignAll(newItems.sliderList);
      totalItems = newItems.totalRecords;
      currentPage += 10;
    } catch(exception) {
      isError.value = true;
      exception.printError();
    } finally{
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
      final newItems = await _service.homeMediaApi(
        (currentPage).toString(),
        (currentPage + itemsPerPage).toString(),
      );

      if (newItems.sliderList.isNotEmpty) {
        items.addAll(newItems.sliderList);
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
