import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hjvyas/utils/CommonAppProgress.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/models/CategoryListResponse.dart';
import '../api/services/HJVyasApiService.dart';
import '../injection_container.dart';
import '../product_detail/ImageWithProgress.dart';
import '../splash/NoIntternetScreen.dart';
import '../utils/MenuImageViewWidget.dart';
import 'CategoryController.dart';
import 'MenuListItem.dart';

class MenuScreen extends StatefulWidget {
  MenuScreen({super.key});

  final CategoryController categoryController = CategoryController(
    getIt<HJVyasApiService>(),
  );

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _selectedIndex = 0;
  String logoURL = "";

  @override
  void initState() {
    super.initState();
    _initPrefs(); // Initialize shared preferences in initState
    widget.categoryController.loadCategories(); // Explicit call
  }

  // Instance of SharedPreferences
  late SharedPreferences _prefs;

  // Initialize SharedPreferences
  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    getLogo();
  }

  Future<void> getLogo() async {
    final myBoolValue = _prefs.getString("logo");
    setState(() {
      logoURL = myBoolValue ?? "";
    });
  }

  void _updateSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> fetchData() async {
    return await widget.categoryController.loadCategories(); // Explicit call
  }

  // Method to refresh data
  void _refreshData() {
    setState(() {
      fetchData(); // Create new Future when needed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (widget.categoryController.isLoading.value) {
        //progress bar
        return getCommonProgressBarFullScreen();
      }

      if (widget.categoryController.error.isNotEmpty) {
        return NoInternetScreen(
          onRetry: () {
            _refreshData();
          },
        );
      }

      return menuScreen(
        widget.categoryController.categories,
        _selectedIndex,
        _updateSelectedIndex,
      );
    });
  }

  Widget menuScreen(
    List<CategoryListItem> categoryList,
    selectedIndex,
    updateSelectedIndex,
  ) {
    return Scaffold(
      body: Container(
        color: Colors.blueGrey,
        child: Stack(
          children: [
            MenuImageViewWidget(
              imageUrl: categoryList.elementAt(selectedIndex).categoryImage,
            ),

            //list of items
            ListWheelScrollView.useDelegate(
              itemExtent: 40,
              perspective: 0.001,
              diameterRatio: 1.6,
              physics: FixedExtentScrollPhysics(),
              squeeze: 1.0,
              useMagnifier: true,
              magnification: 1.3,
              onSelectedItemChanged: (index) {
                updateSelectedIndex(index);
              },
              childDelegate: ListWheelChildBuilderDelegate(
                childCount: categoryList.length,
                builder: (context, index) {
                  return MenuListItem(
                    logoURL,
                    categoryList.elementAt(selectedIndex),
                    _selectedIndex == index
                        //currentState == states[index].names
                        ? Colors.white
                        : Colors.white60,
                    categoryList.elementAt(index).categoryName,
                  );
                },
              ),
            ),

            //top center logo
            if (logoURL.isNotEmpty)
              Align(
                alignment: Alignment.topCenter,
                child: Hero(
                  tag: "app_logo",
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: ImageWithProgress(imageURL: logoURL),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
