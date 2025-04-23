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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "HOME"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "ABOUt"),
        ],
      ),
    );
  }
}

class ListingPageWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: GlobalKey(),
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (context) => ListingPage());
      },
    );
  }
}

class ListingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Items')),
      body: ListView.builder(
        itemBuilder:
            (context, index) => ListTile(
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
      appBar: AppBar(title: Text('Details')),
      body: Center(child: Text('Details for item $itemId')),
      // BottomNavigationBar remains visible automatically
    );
  }
}
