import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hjvyas/home/VideoViewForHome.dart';

import '../api/models/HomeMediaResponse.dart';
import '../api/services/HJVyasApiService.dart';
import '../injection_container.dart';
import '../utils/NetworkImageWithProgress.dart';
import 'PaginationController.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  final PaginationController paginationController = PaginationController(
    getIt<HJVyasApiService>(),
  );

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    widget.paginationController.loadInitialData(); // Explicit call
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (widget.paginationController.items.isEmpty &&
            widget.paginationController.isLoading.value) {
          //todo change this
          return Center(child: CircularProgressIndicator());
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollEndNotification &&
                widget.paginationController.pageController.position.pixels ==
                    widget
                        .paginationController
                        .pageController
                        .position
                        .maxScrollExtent) {
              widget.paginationController.loadMore();
            }
            return false;
          },
          child: PageView.builder(
            padEnds: false,
            scrollDirection: Axis.vertical,
            controller: widget.paginationController.pageController,
            itemCount: widget.paginationController.items.length + 1,
            // +1 for last item
            itemBuilder: (context, index) {
              if (index < widget.paginationController.items.length) {
                return homePageItem(
                  widget.paginationController.items[index],
                );
              } else {
                //todo change this last item
                return ColoredBox(
                  color: Colors.black,
                  child: SizedBox(height: double.maxFinite),
                );
              }
            },
          ),
        );
      }),
    );
  }
}

Widget homePageItem(SliderListItem item) {
  if (item.type.toString() == "image") {
    return NetworkImageWithProgress(imageUrl: item.image);
  } else if (item.type.toString() == "video") {
    return VideoViewForHome(videoUrl: item.image);
  } else {
    return SizedBox();
  }
}
