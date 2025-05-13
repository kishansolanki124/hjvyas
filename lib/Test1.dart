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
        scaffoldBackgroundColor:
        const Color.fromARGB(255, 31, 47, 80), // Dark background for Scaffold
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
        backgroundColor:
        const Color.fromARGB(255, 31, 47, 80), // Dark background for AppBar
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          'Welcome to our Shopping App!\nTap the button below to see categories.',
          style: TextStyle(fontSize: 16, color: Colors.white), // White text
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
      elevation: 8, // Add elevation for a shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25), // Make it more rounded
      ),
      child: const Icon(Icons.category, size: 30), // Increased size
    );
  }

  void _showCategoryMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return AnimatedContainer( // Wrap with AnimatedContainer
          duration: const Duration(milliseconds: 300), // Add animation duration
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            color: const Color.fromARGB(
                255, 50, 65, 100), // Darker background for bottom sheet
            borderRadius: BorderRadius.circular(20), // More rounded corners
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'Categories',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white), // White text
              ),
              const SizedBox(height: 15),
              _buildCategoryListItem(context, "Men's Shopping"),
              _buildCategoryListItem(context, "Women's Shopping"),
              _buildCategoryListItem(context, "Kids' Shopping"),
              _buildCategoryListItem(context, "Other Items"),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: const Text('Close', style: TextStyle(fontSize: 18)),
              )
            ],
          ),
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor:
      Colors.transparent, // Make the background transparent to see the AnimatedContainer
      isScrollControlled:
      true, // Make the bottom sheet take up more space if needed.
    );
  }

  static Widget _buildCategoryListItem(BuildContext context, String category) {
    return InkWell(
      onTap: () {
        _navigateToCategory(context, category);
      },
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        child: Row(
          children: [
            Expanded(
              child: Text(
                category,
                style: const TextStyle(fontSize: 18, color: Colors.white), // White text
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void _navigateToCategory(BuildContext context, String category) {
    Navigator.pop(context);
    Navigator.push(
      context,
      PageRouteBuilder(
        // Use PageRouteBuilder for custom transition
        pageBuilder: (context, animation, secondaryAnimation) =>
            CategoryPage(category: category),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween =
          Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        transitionDuration:
        const Duration(milliseconds: 300), // Match bottom sheet duration
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
        title: Text(category, style: const TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor:
        const Color.fromARGB(255, 31, 47, 80), // Dark background for AppBar
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text(
          'This is the page for $category',
          style: const TextStyle(fontSize: 18, color: Colors.white), // White text
        ),
      ),
      backgroundColor:
      const Color.fromARGB(255, 31, 47, 80), // Dark background for CategoryPage
    );
  }
}

