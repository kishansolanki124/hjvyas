import 'package:flutter/material.dart';
import 'package:hjvyas/home/videodemo.dart';

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
    VideoApp(
      videoUrl:
          "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
    ),
    Image.network(
      'https://picsum.photos/id/5/400/800',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    ),
    Image.network(
      'https://picsum.photos/id/6/400/800',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    ),
    VideoApp(videoUrl: "https://www.w3schools.com/tags/mov_bbb.mp4"),
    Image.network(
      'https://picsum.photos/id/1/400/800',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    ),
    Image.network(
      'https://picsum.photos/id/2/400/800',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    ),
    VideoApp(
      videoUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
    ),
    Image.network(
      'https://picsum.photos/id/3/400/800',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    ),
    Image.network(
      'https://picsum.photos/id/4/400/800',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    ),
    VideoApp(
      videoUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
    ),
    Image.network(
      'https://picsum.photos/id/7/400/800',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    ),
    Image.network(
      'https://picsum.photos/id/8/400/800',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    ),
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
                padding: EdgeInsetsDirectional.all(1),
                largeSize: 20,
                //largeSize: 20.0,
                //smallSize: 30.0,
                backgroundColor: Colors.red,
                label: Text("1"),
                textStyle: TextStyle(fontSize: 16),
                child: IconButton(
                  icon: Image.asset(
                    'icons/notification_icon.png',
                    height: 30,
                    width: 30,
                  ),
                  //iconSize: 10,
                  onPressed: () {},
                ),
              ),
            ),
            // child: IconButton(
            //   icon: Image.asset(
            //     'icons/notification_icon.png',
            //     height: 32,
            //     width: 30,
            //   ),
            //   //iconSize: 10,
            //   onPressed: () {},
            // ),
          ),
        ],
      ),
    );
  }
}
