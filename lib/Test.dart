import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Razorpay Example',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const RazorpayPaymentScreen(),
    );
  }
}

class RazorpayPaymentScreen extends StatefulWidget {
  const RazorpayPaymentScreen({Key? key}) : super(key: key);

  @override
  State<RazorpayPaymentScreen> createState() => _RazorpayPaymentScreenState();
}

class _RazorpayPaymentScreenState extends State<RazorpayPaymentScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Razorpay Payment Example"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [



            const SizedBox(height: 16),

            // Secured by Razorpay
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.lock, size: 16, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(
                    "Secured by Razorpay",
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
