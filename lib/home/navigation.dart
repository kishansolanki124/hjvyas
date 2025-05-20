import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hjvyas/api/models/CategoryListResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../about/AboutHome.dart';
import '../cart/CartHome.dart';
import '../combo/Combo.dart';
import '../menu/MenuScreen.dart';
import '../product/ProductListGridView.dart';
import '../utils/AppColors.dart';
import 'CustomFixedBottomNavigationBar.dart';
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
        statusBarColor: AppColors.background,
        statusBarIconBrightness:
            Brightness.light, // For dark icons, use Brightness.dark
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove the debug banner
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.secondary),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColors.secondary, //cursor color
        ),
      ),
      home: const NavigationExample(),
    );
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  // Static method to access the state
  static _NavigationExampleState? of(BuildContext context) {
    return context.findAncestorStateOfType<_NavigationExampleState>();
  }

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample>
    with TickerProviderStateMixin {
  int cartItemTotal = 0;

  // Instance of SharedPreferences
  SharedPreferences? _prefs;

  // Initialize SharedPreferences
  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void updateCartTotal(int total) {
    setState(() {
      cartItemTotal = total;
      if (kDebugMode) {
        print('cartItemTotal is updated to $cartItemTotal');
      }
    });
  }

  // Helper function to load the list from SharedPreferences
  Future<void> loadSharedPrefItemsList() async {
    if (_prefs == null) {
      await _initPrefs();
    }

    final List<String>? stringList = _prefs?.getStringList("cart_list");
    if (stringList == null || stringList.isEmpty) {
      updateCartTotal(0);
      return;
    }
    updateCartTotal(stringList.length);
  }

  int currentPageIndex = 0;
  bool _showBottomNavBar = true; //BottomNavigationBar visibility
  late AnimationController _controller;
  late Animation<Offset> _animation;

  // This method will be called by ScrollWidget when the user scrolls
  void _updateBottomNavBarVisibility(bool show) {
    if (mounted) {
      setState(() {
        if (_showBottomNavBar) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
        _showBottomNavBar = !_showBottomNavBar;
      });
    }
  }

  void showBottomNav() {
    if (!_showBottomNavBar) {
      setState(() {
        _showBottomNavBar = true;
        _controller.reverse();
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

  Widget homeNavigationWidget = HomeView();

  void navigateToCartPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CartPage(showBackButton: true)),
    );

    // When returning from Widget2, this code will execute
    if (result != null) {
      loadSharedPrefItemsList();
    }
  }

  void _onItemTapped(int index) {
    loadSharedPrefItemsList();

    if (index == 3) {
      navigateToCartPage();
      return;
    }

    if (index == currentPageIndex) {
      return;
    }

    setState(() {
      currentPageIndex = index;
      homeNavigationWidget = returnWhateverScreen(
        currentPageIndex,
        _updateBottomNavBarVisibility,
      );
    });
  }

  void navigateToProductList(
    List<CategoryListItem> categoryList,
    CategoryListItem categoryListItem,
    String logoURL,
  ) {
    setState(() {
      homeNavigationWidget = ProductListGridView(
        categoryList: categoryList,
        categoryListItem: categoryListItem,
        logoURL: logoURL,
        updateBottomNavBarVisibility: _updateBottomNavBarVisibility,
      );
    });
  }

  void navigateToMenuPage() {
    setState(() {
      currentPageIndex = 1;
      homeNavigationWidget = MenuScreen();
    });
  }

  @override
  void initState() {
    super.initState();
    _initPrefs();
    loadSharedPrefItemsList();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 2), // Move down by 2x its height
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    showBottomNav();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: homeNavigationWidget,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SlideTransition(
        position: _animation,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.semiTransWhite,
              borderRadius: BorderRadius.circular(20),
            ),
            child: CustomFixedBottomNavigationBar(
              unselectedLabelStyle: TextStyle(
                fontSize: 10.0,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              selectedLabelStyle: TextStyle(
                fontSize: 10.0,
                fontFamily: "Montserrat",
                color: AppColors.secondary,
                fontWeight: FontWeight.w700,
              ),
              //type: BottomNavigationBarType.fixed,
              //selectedFontSize: 10.0,
              //unselectedFontSize: 10.0,
              //elevation: 0,
              //backgroundColor: Colors.transparent,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: bottomNavIcon("icons/home_icon.png"),
                  activeIcon: bottomNavIcon("icons/home_icon_b.png"),
                  label: "HOME",
                ),
                BottomNavigationBarItem(
                  icon: bottomNavIcon("icons/product_icon.png"),
                  activeIcon: bottomNavIcon("icons/product_icon_a.png"),
                  label: "PRODUCTS",
                ),
                BottomNavigationBarItem(
                  icon: bottomNavIcon("icons/combo_icon.png"),
                  activeIcon: bottomNavIcon("icons/combo_icon_b.png"),
                  label: "COMBO",
                ),
                BottomNavigationBarItem(
                  icon: Badge(
                    largeSize: 16,
                    backgroundColor:
                        cartItemTotal > 0 ? Colors.red : Colors.transparent,
                    label: Text(
                      cartItemTotal > 0 ? cartItemTotal.toString() : "",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Montserrat",
                      ),
                    ),
                    textStyle: TextStyle(fontSize: 16),
                    child: bottomNavIcon("icons/my_bag_icon.png"),
                  ),
                  activeIcon: Badge(
                    largeSize: 16,
                    backgroundColor:
                        cartItemTotal > 0 ? Colors.red : Colors.transparent,
                    label: Text(
                      cartItemTotal > 0 ? cartItemTotal.toString() : "",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Montserrat",
                      ),
                    ),
                    textStyle: TextStyle(fontSize: 16),
                    child: bottomNavIcon("icons/my_bag_icon_b.png"),
                  ),
                  label: "MY BAG",
                ),
                BottomNavigationBarItem(
                  icon: bottomNavIcon("icons/about_icon.png"),
                  activeIcon: bottomNavIcon("icons/about_icon_b.png"),
                  label: "ABOUT",
                ),
              ],
              currentIndex: currentPageIndex,
              selectedItemColor: AppColors.secondary,
              onTap: _onItemTapped,
            ),
          ),
        ),
      ),
    );
  }
}

Widget bottomNavIcon(String iconPath) {
  return SizedBox(width: 24, height: 24, child: Image.asset(iconPath));
}
