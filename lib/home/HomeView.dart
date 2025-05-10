import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hjvyas/home/VideoViewForHome.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/models/HomeMediaResponse.dart';
import '../api/services/HJVyasApiService.dart';
import '../injection_container.dart';
import '../notification/NotificationList.dart';
import '../product_detail/ImageWithProgress.dart';
import '../splash/NoIntternetScreen.dart';
import '../utils/CommonAppProgress.dart';
import '../utils/NetworkImageWithProgress.dart';
import 'HomePopup.dart';
import 'PaginationController.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  final PaginationController paginationController = PaginationController(
    getIt<HJVyasApiService>(),
  );

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  String logoURL = "";
  @override
  void initState() {
    super.initState();
    _initPrefs(); // Initialize shared preferences in initState

    // Set up animation controller for initial entrance animation
    _animationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    // Create a slide transition from bottom (1.0) to position (0.0)
    _slideAnimation = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutQuart),
    );

    // Start the entrance animation after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });

    fetchData();
    //widget.paginationController.loadInitialData(); // Explicit call
  }

  Future<void> fetchData() async {
    await widget.paginationController.loadInitialData(); // Explicit call

    print('initdata ${widget.paginationController.popupListItem}');
    if (widget.paginationController.popupListItem.isNotEmpty) {
      openPopup(
        widget.paginationController.popupListItem.elementAt(0).image,
        widget.paginationController.popupListItem.elementAt(0).title,
        widget.paginationController.popupListItem.elementAt(0).description,
      );
    }
  }

  void _refreshData() {
    fetchData();
  }

  // Instance of SharedPreferences
  late SharedPreferences _prefs;

  void openPopup(String imageUrl, String title, String text) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Image Viewer",
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) {
        return HomePopup(imageUrl: imageUrl, title: title, text: text, onClose: () => {});
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
          return getCommonProgressBarFullScreen();
        }

        //internet or API issue
        if (widget.paginationController.isError.value) {
          return NoInternetScreen(
            onRetry: () {
              _refreshData();
            },
          );
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
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/bg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: <Widget>[
                //PageView (list of media)
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return SlideTransition(
                      position: _slideAnimation,
                      child: PageView.builder(
                        padEnds: false,
                        scrollDirection: Axis.vertical,
                        controller: widget.paginationController.pageController,
                        itemCount: widget.paginationController.items.length,
                        itemBuilder: (context, index) {
                          return homePageItem(
                            widget.paginationController.items[index],
                          );
                        },
                      ),
                    );
                  },
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
                      backgroundColor: Colors.transparent,
                      //if need to show badge then make it red
                      label: Text(""),
                      //set badge count over here
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
