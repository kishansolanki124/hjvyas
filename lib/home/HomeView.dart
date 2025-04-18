import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hjvyas/home/VideoViewForHome.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/models/HomeMediaResponse.dart';
import '../api/services/HJVyasApiService.dart';
import '../injection_container.dart';
import '../notification/Notification.dart';
import '../product_detail/ImageWithProgress.dart';
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
  String logoURL = "";
  @override
  void initState() {
    super.initState();
    _initPrefs(); // Initialize shared preferences in initState
    widget.paginationController.loadInitialData(); // Explicit call
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
          child: Stack(
            children: <Widget>[
              //PageView (list of media)
              Center(
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
              ),

              // Top right Notification Button with badge
              Positioned(
                top: 16.0, // Adjust top padding as needed
                right: 16.0, // Adjust right padding as needed

                child: IconButton(
                  onPressed: () {},
                  icon: Badge(
                    offset: Offset.fromDirection(6, -4),
                    largeSize: 18,
                    backgroundColor: Colors.red,
                    label: Text("2"),
                    textStyle: TextStyle(fontSize: 12),
                    child: IconButton(
                      icon: Image.asset(
                        'icons/notification_icon.png',
                        height: 24,
                        width: 24,
                      ),
                      //iconSize: 10,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => NotificationList(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              if (logoURL.isNotEmpty)
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: ImageWithProgress(imageURL: logoURL),
                  ),
                ),
            ],
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
