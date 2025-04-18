import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hjvyas/home/videodemo.dart';

import '../api/models/HomeMediaResponse.dart';
import '../api/services/hjvyas_api_service.dart';
import '../injection_container.dart';
import 'HomeImgeItem.dart';
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
            // +1 for loading indicator
            itemBuilder: (context, index) {
              if (index < widget.paginationController.items.length) {
                return HomePageViewWidget(
                  widget.paginationController.items[index],
                );
              } else {
                //todo change this
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

Widget HomePageViewWidget(SliderListItem item) {
  if (item.type.toString() == "image") {
    return Scaffold(
      //child: Text('$index'),
      body: NetworkImageWithProgress(imageUrl: item.image),
    );
  } else if (item.type.toString() == "video") {
    return Scaffold(
      //child: Text('$index'),
      body: VideoApp(videoUrl: item.image),
    );
  } else {
    return Text("height: 30,");
  }
}
