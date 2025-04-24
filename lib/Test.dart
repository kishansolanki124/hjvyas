import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: HomeScreen()));
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _currentIndex = 0;
  final List<Widget> _pages = [
    ListingPageWrapper(), // Important wrapper
    Text("fd2"), Text("fd3"),
  ];

  // Add this
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(), // For Listing
    GlobalKey<NavigatorState>(), // For other tabs
    GlobalKey<NavigatorState>(),
  ];

  final _navigatorKey = GlobalKey<NavigatorState>();

  // @override
  // Widget build(BuildContext context) {
  //   return WillPopScope(
  //     onWillPop: _onWillPop,
  //     child: Scaffold(
  //       body: IndexedStack(
  //         index: _currentIndex,
  //         children: [
  //           _buildNavigator(0, _pages.elementAt(0)),
  //           _buildNavigator(1, _pages.elementAt(1)),
  //           _buildNavigator(2, _pages.elementAt(2)),
  //         ],
  //       ),
  //     bottomNavigationBar: BottomNavigationBar(
  //       currentIndex: _currentIndex,
  //       onTap: (index) {
  //         if (index == _currentIndex) {
  //           _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
  //         }
  //         setState(() => _currentIndex = index);
  //       },
  //       items: [
  //         BottomNavigationBarItem(icon: Icon(Icons.list), label: "HOME"),
  //         BottomNavigationBarItem(icon: Icon(Icons.settings), label: "ABOUt"),
  //       ],
  //     ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_navigatorKey.currentState?.canPop() ?? false) {
          _navigatorKey.currentState?.pop();
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: Navigator(
          key: _navigatorKey,
          onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => ListingPage(),
          ),
        ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                if (index == _currentIndex) {
                  _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
                }
                setState(() => _currentIndex = index);
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.list), label: "HOME"),
                BottomNavigationBarItem(icon: Icon(Icons.settings), label: "ABOUt"),
              ],
            ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    final currentNavigator = _navigatorKeys[_currentIndex].currentState;
    if (currentNavigator?.canPop() ?? false) {
      currentNavigator?.pop();
      return false;
    }
    return _currentIndex != 0; // If not on first tab, go to first tab
  }

  Widget _buildNavigator(int index, Widget page) {
    return Navigator(
      key: _navigatorKeys[index],
      onGenerateRoute: (settings) => MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

}

// class _HomeScreenState extends State<HomeScreen> {
//   int _currentIndex = 0;
//   final List<Widget> _pages = [
//     ListingPageWrapper(), // Important wrapper
//     Text("fd2"), Text("fd3"),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) => setState(() => _currentIndex = index),
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.list), label: "HOME"),
//           BottomNavigationBarItem(icon: Icon(Icons.settings), label: "ABOUt"),
//         ],
//       ),
//     );
//   }
// }

// class ListingPageWrapper extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Navigator(
//       key: GlobalKey(),
//       onGenerateRoute: (settings) {
//         return MaterialPageRoute(builder: (context) => ListingPage());
//       },
//     );
//   }
// }

class ListingPageWrapper extends StatefulWidget {
  @override
  _ListingPageWrapperState createState() => _ListingPageWrapperState();
}

class _ListingPageWrapperState extends State<ListingPageWrapper> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle system back button
        if (navigatorKey.currentState!.canPop()) {
          navigatorKey.currentState!.pop();
          return false; // Prevent default back behavior
        }
        return true; // Allow exit if no routes to pop
      },
      child: Navigator(
        key: navigatorKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) => ListingPage(),
        ),
      ),
    );
  }
}

class ListingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Items')),
      body: ListView.builder(
        itemBuilder: (context, index) => ListTile(
          title: Text('Item $index'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsPage(itemId: index),
              ),
            );
          },
        ),
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  final int itemId;

  const DetailsPage({required this.itemId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(child: Text('Details for item $itemId')),
    );
  }
}