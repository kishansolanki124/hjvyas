import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart'; // Import for RenderSliver

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Sliver Example',
      home: Scaffold(
        body: CombinedScrollScreen(),
      ),
    );
  }
}
class CombinedScrollScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Header Section (Icon + Text)
          SliverToBoxAdapter(
            child: _buildHeader(),
          ),

          // GridView Section
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.8,
            ),
            delegate: SliverChildBuilderDelegate(
                  (context, index) => _buildGridItem(index),
              childCount: 20, // Your item count
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.blue[50],
      child: Row(
        children: [
          Icon(Icons.star, size: 30, color: Colors.amber),
          SizedBox(width: 12),
          Text(
            'Featured Items',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(int index) {
    return Card(
      elevation: 3,
      child: Column(
        children: [
          Expanded(
            child: Placeholder(), // Replace with your image
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text('Item $index'),
          ),
        ],
      ),
    );
  }
}
