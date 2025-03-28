import 'package:flutter/material.dart';
import 'dart:io';

class PageViewCustom extends StatefulWidget {
  const PageViewCustom({Key? key}) : super(key: key);

  @override
  State<PageViewCustom> createState() => _PageViewCustomState();
}

class _PageViewCustomState extends State<PageViewCustom> {
  final _pageController = PageController(initialPage: 0, viewportFraction: 0.8);

  //https://picsum.photos/id/237/200/300
  Widget pageViewBuilder() {
    return PageView.builder(
      itemBuilder: (context, index) {
        return Scaffold(
          //child: Text('$index'),
          body: Image.network('https://picsum.photos/id/${index + 2}/200/300',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
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
    return Scaffold(
      body:
      // PageView(
      //   controller: _pageController,
      //   scrollDirection: Axis.vertical, // or Axis.vertical
      //   children: [
      //     Container(
      //       color: Colors.red,
      //       child: const Center(
      //         child: Text(
      //           'RED PAGE',
      //           style: TextStyle(fontSize: 45, color: Colors.white),
      //         ),
      //       ),
      //     ),
      //     Container(
      //       color: Colors.blue,
      //       child: const Center(
      //         child: Text(
      //           'BLUE PAGE',
      //           style: TextStyle(fontSize: 45, color: Colors.white),
      //         ),
      //       ),
      //     ),
      //     Container(
      //       color: Colors.black,
      //       child: const Center(
      //         child: Text(
      //           'BLACK PAGE',
      //           style: TextStyle(fontSize: 45, color: Colors.white),
      //         ),
      //       ),
      //     ),
      //     Container(
      //       color: Colors.yellow,
      //       child: const Center(
      //         child: Text(
      //           'YELLOW PAGE',
      //           style: TextStyle(fontSize: 45, color: Colors.white),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      pageViewBuilder(),
    );
  }
}
