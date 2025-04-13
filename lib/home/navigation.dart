import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../about/AboutHome.dart';
import '../cart/CartHome.dart';
import '../combo/Combo.dart';
import '../menu/menu_screen.dart';
import 'medialisthomepage.dart';

class NavigationBarApp extends StatefulWidget {
  const NavigationBarApp({super.key});

  @override
  State<NavigationBarApp> createState() => _NavigationBarAppState();
}

class _NavigationBarAppState extends State<NavigationBarApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 32, 47, 80),
        statusBarIconBrightness:
            Brightness.light, // For dark icons, use Brightness.dark
      ),
    );

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

class _NavigationExampleState extends State<NavigationExample>
    with TickerProviderStateMixin {
  int currentPageIndex = 0;
  bool _showBottomNavBar = true; //BottomNavigationBar visibility

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // This method will be called by ScrollWidget when the user scrolls
  void _updateBottomNavBarVisibility(bool show) {
    if (mounted) {
      // //check if the widget is mounted before calling setState
      setState(() {
        _showBottomNavBar = show;
      });
    }
  }

  Widget returnWhateverScreen(int index, _updateBottomNavBarVisibility) {
    List<Widget> screenList = <Widget>[
      PageViewCustom(),
      HomeScreen(),
      ComboStateless(
        updateBottomNavBarVisibility: _updateBottomNavBarVisibility,
      ),
      CartPage(),
      AboutHome(),
    ];

    return screenList.elementAt(index);
  }

  void _onItemTapped(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //final ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 32, 47, 80),
      body: SafeArea(
        child: Center(
          child: returnWhateverScreen(
            currentPageIndex,
            _updateBottomNavBarVisibility,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 0, 10.0, 0),
        child:
            _showBottomNavBar
                ? DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(200, 255, 255, 255),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:
                      _showBottomNavBar
                          ? BottomNavigationBar(
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
                                  child: Image.asset(
                                    "icons/product_icon_a.png",
                                  ),
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
                            selectedItemColor: Color.fromARGB(
                              255,
                              101,
                              115,
                              169,
                            ),
                            onTap: _onItemTapped,
                          )
                          : null,
                )
                : null,
      ),
    );
  }
}
