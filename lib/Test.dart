import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Categories App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Inter',
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Categories'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Welcome to our Shopping App!\nTap the button below to see categories.',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
      floatingActionButton: const CategoryMenuButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class CategoryMenuButton extends StatelessWidget {
  const CategoryMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _showCategoryMenu(context);
      },
      tooltip: 'View Categories',
      backgroundColor: Colors.blue,
      child: const Icon(Icons.category),
    );
  }

  void _showCategoryMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          // Added padding for better visual appearance
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'Categories',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10), // Added spacing
              ListTile(
                leading: const Icon(Icons.male),
                title: const Text("Men's Shopping"),
                onTap: () {
                  _navigateToCategory(context, "Men's Shopping");
                },
              ),
              ListTile(
                leading: const Icon(Icons.female),
                title: const Text("Women's Shopping"),
                onTap: () {
                  _navigateToCategory(context, "Women's Shopping");
                },
              ),
              ListTile(
                leading: const Icon(Icons.child_care),
                title: const Text("Kids' Shopping"),
                onTap: () {
                  _navigateToCategory(context, "Kids' Shopping");
                },
              ),
              ListTile(
                leading: const Icon(Icons.shopping_bag),
                title: const Text("Other Items"),
                onTap: () {
                  _navigateToCategory(context, "Other Items");
                },
              ),
              const SizedBox(height: 10), // Added spacing
              ElevatedButton(
                //Added an elevated button
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              )
            ],
          ),
        );
      },
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), //Added rounded corners
    );
  }

  void _navigateToCategory(BuildContext context, String category) {
    Navigator.pop(context); // Close the bottom sheet
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryPage(category: category),
      ),
    );
  }
}

class CategoryPage extends StatelessWidget {
  final String category;

  const CategoryPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'This is the page for $category',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
