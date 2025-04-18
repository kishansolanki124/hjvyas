import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hjvyas/menu/wheel_tile.dart';

import '../api/models/CategoryListResponse.dart';
import '../api/services/HJVyasApiService.dart';
import '../injection_container.dart';
import 'CategoryController.dart';
import 'ImageLoaderWidget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  final CategoryController categoryController = CategoryController(
    getIt<HJVyasApiService>(),
  );

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    widget.categoryController.loadCategories(); // Explicit call
  }

  void _updateSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (widget.categoryController.isLoading.value) {
        //todo change this
        return Center(child: CircularProgressIndicator());
      }

      if (widget.categoryController.error.isNotEmpty) {
        //todo change this
        return Center(child: Text('Error: ${widget.categoryController.error}'));
      }

      return MenuScreen(
        widget.categoryController.categories,
        _selectedIndex,
        _updateSelectedIndex,
      );
    });
  }

  Widget MenuScreen(
    List<CategoryListItem> categoryList,
    _selectedIndex,
    _updateSelectedIndex,
  ) {
    return Scaffold(
      body: Container(
        color: Colors.blueGrey,
        child: Stack(
          children: [
            loadImageWithProgress(
              categoryList.elementAt(_selectedIndex).categoryImage,
            ),

            ListWheelScrollView.useDelegate(
              itemExtent: 40,
              perspective: 0.001,
              diameterRatio: 1.6,
              physics: FixedExtentScrollPhysics(),
              squeeze: 1.0,
              useMagnifier: true,
              magnification: 1.3,
              onSelectedItemChanged: (index) {
                _updateSelectedIndex(index);
              },
              childDelegate: ListWheelChildBuilderDelegate(
                childCount: categoryList.length,
                builder: (context, index) {
                  return WheelTile(
                    _selectedIndex == index
                        //currentState == states[index].names
                        ? Colors.white
                        : Colors.white60,
                    categoryList.elementAt(index).categoryName,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
