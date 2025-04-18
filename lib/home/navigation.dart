import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../about/AboutHome.dart';
import '../cart/CartHome.dart';
import '../combo/Combo.dart';
import '../menu/MenuScreen.dart';
import 'HomeView.dart';

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
      HomeView(),
      MenuScreen(),
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
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            'Tap back again to exit.',
            style: TextStyle(
              fontSize: 14.0,
              fontFamily: "Montserrat",
              color: Color.fromARGB(255, 32, 47, 80),
            ),
          ),
        ),
        child: SafeArea(
          child: Center(
            child: returnWhateverScreen(
              currentPageIndex,
              _updateBottomNavBarVisibility,
            ),
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
                    color: Color.fromARGB(225, 255, 255, 255),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:
                      _showBottomNavBar
                          ? BottomNavigationBar(
                            unselectedLabelStyle: TextStyle(
                              fontSize: 10.0,
                              fontFamily: "Montserrat",
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                            selectedLabelStyle: TextStyle(
                              fontSize: 10.0,
                              fontFamily: "Montserrat",
                              color: Color.fromARGB(255, 101, 115, 169),
                              fontWeight: FontWeight.w700,
                            ),
                            type: BottomNavigationBarType.fixed,
                            iconSize: 12.0,
                            selectedFontSize: 10.0,
                            unselectedFontSize: 10.0,
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
                                label: "HOME",
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
                                label: "PROUDUCTS",
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
                                label: "COMBO",
                              ),
                              BottomNavigationBarItem(
                                icon: Badge(
                                  largeSize: 20,
                                  backgroundColor: Colors.red,
                                  label: Text(
                                    "1",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Montserrat",
                                    ),
                                  ),
                                  textStyle: TextStyle(fontSize: 16),
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: Image.asset("icons/my_bag_icon.png"),
                                  ),
                                ),
                                activeIcon: Badge(
                                  largeSize: 20,
                                  backgroundColor: Colors.red,
                                  label: Text(
                                    "1",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Montserrat",
                                    ),
                                  ),
                                  textStyle: TextStyle(fontSize: 16),
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: Image.asset(
                                      "icons/my_bag_icon_a.png",
                                    ),
                                  ),
                                ),
                                label: "MY BAG",
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
                                label: "ABOUT",
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
