// import 'package:flutter/material.dart';
// import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter PayPal Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: PayPalDemo(),
//     );
//   }
// }
//
// class PayPalDemo extends StatefulWidget {
//   @override
//   _PayPalDemoState createState() => _PayPalDemoState();
// }
//
// class _PayPalDemoState extends State<PayPalDemo> {
//   // Replace with your PayPal sandbox credentials
//   final String clientId = 'AXYh1f38rSBrHwVZlhNMrybwLoa4xrLUnjW-g-G92ZH-Uu1c13caF-tlc7KNykAuz3YfPD9bD0W0_U0r';
//   final String secretKey = 'EAI55p1vNOqaUkdUEbaaGUnV3x0_W3yTo1Fv4ZWY4W4IwcBa1NXdqtCcIPyM30-aDJR8m6_pldyvDa5u';
//
//   // Set to false for production environment
//   final bool sandbox = true;
//
//   // Set to your currency
//   final String currency = 'USD';
//
//   // Payment details
//   final String amount = '10.00';
//   String paymentStatus = '';
//   bool isLoading = false;
//
//   void _startPayPalPayment() async {
//     setState(() {
//       isLoading = true;
//       paymentStatus = '';
//     });
//
//     try {
//       // Define the items being purchased
//       List<PayPalItem> items = [
//         PayPalItem(
//           name: 'Premium Widget',
//           price: amount,
//           quantity: "1",
//           currency: currency,
//         ),
//       ];
//
//       // Navigation and checkout configuration
//       Navigator.of(context).push(
//         MaterialPageRoute(
//           builder: (context) => PaypalCheckoutView(
//             sandboxMode: sandbox,
//             clientId: clientId,
//             secretKey: secretKey,
//             transactions: [
//               {
//                 "amount": {
//                   "total": amount,
//                   "currency": currency,
//                   "details": {
//                     "subtotal": amount,
//                     "shipping": '0',
//                     "shipping_discount": 0
//                   }
//                 },
//                 "description": "Payment for Premium Widget",
//                 "item_list": {
//                   "items": items.map((item) => item.toJson()).toList(),
//                 }
//               }
//             ],
//             note: "Contact us for any questions on your order.",
//             onSuccess: (Map params) async {
//               // Handle successful payment
//               print("onSuccess: $params");
//               setState(() {
//                 paymentStatus = 'Payment Successful!\nTransaction ID: ${params['paymentId']}';
//                 isLoading = false;
//               });
//               Navigator.pop(context);
//             },
//             onError: (error) {
//               // Handle payment errors
//               print("onError: $error");
//               setState(() {
//                 paymentStatus = 'Payment Error: $error';
//                 isLoading = false;
//               });
//               Navigator.pop(context);
//             },
//             onCancel: () {
//               // Handle payment cancellation
//               print('Payment cancelled by user');
//               setState(() {
//                 paymentStatus = 'Payment Cancelled';
//                 isLoading = false;
//               });
//               Navigator.pop(context);
//             },
//           ),
//         ),
//       );
//     } catch (e) {
//       setState(() {
//         paymentStatus = 'Error: ${e.toString()}';
//         isLoading = false;
//       });
//       print(e);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('PayPal Payment Example'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Text(
//                 'PayPal Demo Store',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 20),
//               Card(
//                 elevation: 4,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       Image.network(
//                         'https://via.placeholder.com/150',
//                         height: 100,
//                         width: 100,
//                       ),
//                       SizedBox(height: 10),
//                       Text(
//                         'Premium Widget',
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(height: 5),
//                       Text(
//                         'The best widget money can buy',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                       SizedBox(height: 10),
//                       Text(
//                         'Price: \$$amount',
//                         style: TextStyle(fontSize: 18, color: Colors.green[700]),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 30),
//               if (isLoading)
//                 CircularProgressIndicator()
//               else
//                 ElevatedButton.icon(
//                   style: ElevatedButton.styleFrom(
//                     padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                   ),
//                   icon: Image.network(
//                     'https://www.paypalobjects.com/webstatic/en_US/i/buttons/PP_logo_h_100x26.png',
//                     height: 20,
//                     width: 70,
//                   ),
//                   label: Text(
//                     'Checkout',
//                     style: TextStyle(fontSize: 18),
//                   ),
//                   onPressed: _startPayPalPayment,
//                 ),
//               SizedBox(height: 20),
//               if (paymentStatus.isNotEmpty)
//                 Container(
//                   padding: EdgeInsets.all(16),
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: paymentStatus.contains('Successful')
//                         ? Colors.green[100]
//                         : paymentStatus.contains('Cancelled')
//                         ? Colors.orange[100]
//                         : Colors.red[100],
//                     borderRadius: BorderRadius.circular(8),
//                     border: Border.all(
//                       color: paymentStatus.contains('Successful')
//                           ? Colors.green
//                           : paymentStatus.contains('Cancelled')
//                           ? Colors.orange
//                           : Colors.red,
//                     ),
//                   ),
//                   child: Text(
//                     paymentStatus,
//                     style: TextStyle(fontSize: 16),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // Helper class to format PayPal items
// class PayPalItem {
//   String name;
//   String quantity;
//   String price;
//   String currency;
//
//   PayPalItem({
//     required this.name,
//     required this.price,
//     required this.quantity,
//     required this.currency,
//   });
//
//   Map<String, String> toJson() {
//     return {
//       "name": name,
//       "quantity": quantity.toString(),
//       "price": price,
//       "currency": currency,
//     };
//   }
// }