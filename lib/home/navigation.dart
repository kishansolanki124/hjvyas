import 'package:flutter/material.dart';
import 'package:hjvyas/home/videodemo.dart';
import 'package:flutter/services.dart';

import 'medialisthomepage.dart';

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(255, 32, 47, 80),
      statusBarIconBrightness: Brightness.light, // For dark icons, use Brightness.dark
    ));

    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const NavigationExample(),
    );
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  List<Widget> screenList = <Widget>[
    PageViewCustom(),
//    VideoApp(),
    Text("Third"),
    Text("Third"),
    Text("Forth"),
    Text("Fifth"),
  ];

  void _onItemTapped(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //final ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: SafeArea(
          child: Center(child: screenList.elementAt(currentPageIndex))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 0, 10.0, 0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Color.fromARGB(157, 255, 255, 255),
            borderRadius: BorderRadius.circular(20),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            iconSize: 12.0,
            selectedFontSize: 12.0,
            unselectedFontSize: 9.0,
            elevation: 0,
            backgroundColor: Colors.transparent,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset("icons/home_icon.png"),
                ),
                activeIcon: SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset("icons/home_icon_a.png"),
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset("icons/product_icon.png"),
                ),
                activeIcon: SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset("icons/product_icon_a.png"),
                ),
                label: "Products",
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset("icons/combo_icon.png"),
                ),
                activeIcon: SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset("icons/combo_icon_a.png"),
                ),
                label: "Combo",
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset("icons/my_bag_icon.png"),
                ),
                activeIcon: SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset("icons/my_bag_icon_a.png"),
                ),
                label: "My Bags",
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset("icons/about_icon.png"),
                ),
                activeIcon: SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset("icons/about_icon_a.png"),
                ),
                label: "About",
              ),
            ],
            currentIndex: currentPageIndex,
            selectedItemColor: Color.fromARGB(255, 101, 115, 169),
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
