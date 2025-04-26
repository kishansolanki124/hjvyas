import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: MyPage()));
}

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  double _myDoubleValue = 0.0; // Changed to double

  void _updateDoubleValue() {
    setState(() {
      _myDoubleValue += 1.1; // Increment by a double value
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FloatingActionButton Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Current Value: ${_myDoubleValue.toStringAsFixed(2)}', // Use toStringAsFixed
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateDoubleValue,
              child: const Text('Update Value'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _updateDoubleValue,
        label: Text(
          'Value: ${_myDoubleValue.toStringAsFixed(2)}', // Use toStringAsFixed here too!
          style: const TextStyle(fontSize: 16),
        ),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
