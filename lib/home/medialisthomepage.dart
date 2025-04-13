import 'package:flutter/material.dart';
import 'package:hjvyas/home/videodemo.dart';

import '../notification/Notification.dart';
import 'HomeImgeItem.dart';

class PageViewCustom extends StatefulWidget {
  const PageViewCustom({Key? key}) : super(key: key);

  @override
  State<PageViewCustom> createState() => _PageViewCustomState();
}

class _PageViewCustomState extends State<PageViewCustom> {
  final _pageController = PageController(initialPage: 0, viewportFraction: 0.8);

  var selectedPage = 0;

  Widget pageViewBuilder() {
    return PageView.builder(
      itemBuilder: (context, index) {
        return Scaffold(
          //child: Text('$index'),
          body: mediaItemList.elementAt(index),
        );
      },
      itemCount: mediaItemList.length,
      padEnds: false,
      scrollDirection: Axis.vertical,
      controller: _pageController,
    );
  }

  List<Widget> mediaItemList = <Widget>[
    NetworkImageWithProgress(
      imageUrl:
          'https://images.pexels.com/photos/1496373/pexels-photo-1496373.jpeg?cs=srgb&dl=pexels-arts-1496373.jpg&fm=jpg',
    ),
    NetworkImageWithProgress(
      imageUrl:
          'https://images.pexels.com/photos/7276946/pexels-photo-7276946.jpeg?cs=srgb&dl=pexels-rachel-claire-7276946.jpg&fm=jpg&w=3648&h=5472',
    ),
    NetworkImageWithProgress(
      imageUrl:
          'https://images.pexels.com/photos/1526713/pexels-photo-1526713.jpeg?cs=srgb&dl=pexels-francesco-ungaro-1526713.jpg&fm=jpg&w=4000&h=6000',
    ),
    NetworkImageWithProgress(
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/11/29/05/45/astronomy-1867616_1280.jpg',
    ),
    VideoApp(
      videoUrl:
          "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
    ),
    VideoApp(videoUrl: "https://www.rmp-streaming.com/media/bbb-360p.mp4"),
    VideoApp(
      videoUrl:
          "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4",
    ),
    NetworkImageWithProgress(imageUrl: 'https://picsum.photos/id/5/400/800'),
    NetworkImageWithProgress(imageUrl: 'https://picsum.photos/id/6/400/800'),
    VideoApp(videoUrl: "https://www.w3schools.com/tags/mov_bbb.mp4"),
    NetworkImageWithProgress(imageUrl: 'https://picsum.photos/id/1/400/800'),
    NetworkImageWithProgress(imageUrl: 'https://picsum.photos/id/2/400/800'),
    VideoApp(
      videoUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
    ),
    NetworkImageWithProgress(imageUrl: 'https://picsum.photos/id/3/400/800'),
    NetworkImageWithProgress(imageUrl: 'https://picsum.photos/id/4/400/800'),
    VideoApp(
      videoUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
    ),
    NetworkImageWithProgress(imageUrl: 'https://picsum.photos/id/7/400/800'),
    NetworkImageWithProgress(imageUrl: 'https://picsum.photos/id/8/400/800'),
    VideoApp(
      videoUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Main content of your body
          Center(child: pageViewBuilder()),

          // Top right button
          Positioned(
            top: 16.0, // Adjust top padding as needed
            right: 16.0, // Adjust right padding as needed

            child: IconButton(
              onPressed: () {},
              icon: Badge(
                offset: Offset.fromDirection(5, -3),
                largeSize: 20,
                backgroundColor: Colors.red,
                label: Text("2"),
                textStyle: TextStyle(fontSize: 16),
                child: IconButton(
                  icon: Image.asset(
                    'icons/notification_icon.png',
                    height: 30,
                    width: 30,
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
        ],
      ),
    );
  }
}
