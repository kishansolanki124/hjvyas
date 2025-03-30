import 'package:flutter/material.dart';
import 'package:hjvyas/menu/StateModel.dart';
import 'package:hjvyas/menu/wheel_tile.dart';

import '../home/HomeImgeItem.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //* List of states
  List<States> states = [];
  List<String> images = [
    'https://images.pexels.com/photos/1496373/pexels-photo-1496373.jpeg?cs=srgb&dl=pexels-arts-1496373.jpg&fm=jpg',
    'https://images.pexels.com/photos/7276946/pexels-photo-7276946.jpeg?cs=srgb&dl=pexels-rachel-claire-7276946.jpg&fm=jpg&w=3648&h=5472',
    'https://images.pexels.com/photos/1526713/pexels-photo-1526713.jpeg?cs=srgb&dl=pexels-francesco-ungaro-1526713.jpg&fm=jpg&w=4000&h=6000',
    'https://cdn.pixabay.com/photo/2016/11/29/05/45/astronomy-1867616_1280.jpg',
    'https://picsum.photos/id/5/400/800',
    'https://picsum.photos/id/8/400/800',
    'https://picsum.photos/id/19/400/800',
  ];
  int _selectedIndex = 0;

  //String currentState = "Andhra Pradesh";

  @override
  void initState() {
    super.initState();
    states = allStates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blueGrey,
        // decoration: BoxDecoration(
        //   image: DecorationImage(image:
        // NetworkImageWithProgress(imageUrl: images.elementAt(_selectedIndex))),
        // ),
        child: Stack(
          children: [
            NetworkImageWithProgress(
              imageUrl: images.elementAt(_selectedIndex),
              isImageTint: true
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
                setState(() {
                  _selectedIndex = index;
                  //currentState = states[index].names!;
                });
              },
              childDelegate: ListWheelChildBuilderDelegate(
                childCount: states.length,
                builder: (context, index) {
                  return WheelTile(
                    _selectedIndex == index
                        //currentState == states[index].names
                        ? Colors.white
                        : Colors.white60,
                    states[index].names!,
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
