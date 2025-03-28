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

  //https://picsum.photos/id/237/200/300
  Widget pageViewBuilder() {
    return PageView.builder(
      itemBuilder: (context, index) {
        return Scaffold(
          //child: Text('$index'),
          body: mediaItemList.elementAt(index),
          //child: Image.network('https://picsum.photos/250?image=9'),
        );
      },
      itemCount: 5,
      padEnds: false,
      scrollDirection: Axis.vertical,
      controller: _pageController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: pageViewBuilder());
  }

  List<Widget> mediaItemList = <Widget>[
    VideoApp(videoUrl: "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"),
    Image.network(
      'https://picsum.photos/id/1/200/300',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    ),
    Image.network(
      'https://picsum.photos/id/2/200/300',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    ),
    VideoApp(videoUrl:
    "https://www.w3schools.com/tags/mov_bbb.mp4"),
    Image.network(
      'https://picsum.photos/id/1/200/300',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    ),
    Image.network(
      'https://picsum.photos/id/2/200/300',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    )
  ];
}