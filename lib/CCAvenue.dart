import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CCAvenue Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PaymentScreen(),
    );
  }
}

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _uuid = Uuid();

  // Form controllers
  final _amountController = TextEditingController(text: '10.00');
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _isProcessing = false;
  String _paymentStatus = '';

  @override
  void dispose() {
    _amountController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _initiatePayment() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isProcessing = true;
        _paymentStatus = '';
      });

      // Generate a unique order ID
      final orderId =
          'ORD_${_uuid.v4().substring(0, 8)}_${DateTime.now().millisecondsSinceEpoch}';

      try {
        // Navigate to CCAvenue payment page
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => CCAvenuePay(
              orderId: orderId,
              amount: double.parse(_amountController.text),
              customerName: _nameController.text,
              customerEmail: _emailController.text,
              customerPhone: _phoneController.text,
            ),
          ),
        );

        // Handle payment result
        if (result != null) {
          setState(() {
            _paymentStatus =
            'Payment ${result['status']}: ${result['message'] ?? ''}';

            if (result['status'] == 'success') {
              _resetForm();
            }
          });
        }
      } catch (e) {
        setState(() {
          _paymentStatus = 'Error: ${e.toString()}';
        });
      } finally {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  void _resetForm() {
    _amountController.text = '100.00';
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CCAvenue Payment Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Payment form
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Amount (INR)',
                    prefixText: '₹',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an amount';
                    }
                    if (double.tryParse(value) == null ||
                        double.parse(value) <= 0) {
                      return 'Please enter a valid amount';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Full Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Email Address'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _isProcessing ? null : _initiatePayment,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child:
                  _isProcessing
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Text('Processing...'),
                    ],
                  )
                      : Text('Pay Now with CCAvenue'),
                ),
                if (_paymentStatus.isNotEmpty) ...[
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color:
                      _paymentStatus.contains('success')
                          ? Colors.green.shade50
                          : _paymentStatus.contains('failed') ||
                          _paymentStatus.contains('Error')
                          ? Colors.red.shade50
                          : Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _paymentStatus,
                      style: TextStyle(
                        color:
                        _paymentStatus.contains('success')
                            ? Colors.green.shade800
                            : _paymentStatus.contains('failed') ||
                            _paymentStatus.contains('Error')
                            ? Colors.red.shade800
                            : Colors.grey.shade800,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// CCAvenue Payment Widget Implementation in the same file
class CCAvenuePay extends StatefulWidget {
  final String orderId;
  final double amount;
  final String customerName;
  final String customerEmail;
  final String customerPhone;

  const CCAvenuePay({
    Key? key,
    required this.orderId,
    required this.amount,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
  }) : super(key: key);

  @override
  _CCAvenuePayState createState() => _CCAvenuePayState();
}

class _CCAvenuePayState extends State<CCAvenuePay> {
  late WebViewController _controller;
  bool _isLoading = true;

  // Your CCAvenue credentials
  final String merchantId = '26833';
  final String accessCode = 'AVDG01BA07CA91GDAC';
  final String workingKey = '1B94F2D638174A5A5D0F6E82F0516F3B';

  // Your server URL that will generate the encrypted request
  final String _serverUrl = "https://your-server.com/ccavenue-encrypt";

  // The CCAvenue payment URL
  final String _ccavenueUrl =
      "https://test.ccavenue.com/transaction/transaction.do";

  @override
  void initState() {
    super.initState();
    // Initialize CCAvenue payment
    _initiateCCAvenue();
  }

  Future<void> _initiateCCAvenue() async {
    // Prepare the payment parameters
    final Map<String, String> params = {
      'merchant_id': merchantId,
      'order_id': widget.orderId,
      'currency': 'INR',
      'amount': widget.amount.toString(),
      'redirect_url': 'https://your-server.com/ccavenue-response',
      'cancel_url': 'https://your-server.com/ccavenue-response',
      'language': 'EN',
      'customer_name': widget.customerName,
      'customer_email': widget.customerEmail,
      'customer_phone': widget.customerPhone,
      'merchant_param1': 'Flutter App',
      'merchant_param2': 'CCAvenue Integration',
    };

    try {
      // Option 1: Using your own server to encrypt data
      final response = await http.post(Uri.parse(_serverUrl), body: params);

      if (response.statusCode == 200) {
        final encryptedData = response.body;
        _loadCCAvenue(encryptedData);
      } else {
        _showError("Failed to encrypt payment data");
      }

      // Option 2: Local encryption (Not recommended for production)
      // Only use this for testing purposes
      /*
      final String encryptedData = _encryptData(params);
      _loadCCAvenue(encryptedData);
      */
    } catch (e) {
      _showError("Error: ${e.toString()}");
    }
  }

  void _loadCCAvenue(String encryptedData) {
    // HTML form to submit to CCAvenue
    final String htmlForm = '''
      <html>
        <head>
          <title>CCAvenue Payment</title>
        </head>
        <body onload="document.forms['payment_form'].submit();">
          <form id="payment_form" method="post" action="$_ccavenueUrl">
            <input type="hidden" name="encRequest" value="$encryptedData">
            <input type="hidden" name="access_code" value="$accessCode">
          </form>
        </body>
      </html>
    ''';

    _controller =
    WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });

            // Handle the response from CCAvenue
            _handleResponse(url);
          },
          onWebResourceError: (WebResourceError error) {
            _showError("WebView error: ${error.description}");
          },
        ),
      )
      ..loadHtmlString(htmlForm);
  }

  void _handleResponse(String url) {
    // Parse response URL
    if (url.contains('your-server.com/ccavenue-response')) {
      // Extract parameters from URL or let your server handle it
      // For security reasons, verification should be done on your server

      // Example of success navigation
      if (url.contains('order_status=Success')) {
        Navigator.pop(context, {
          'status': 'success',
          'order_id': widget.orderId,
        });
      } else {
        Navigator.pop(context, {
          'status': 'failed',
          'order_id': widget.orderId,
        });
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
    Navigator.pop(context, {'status': 'error', 'message': message});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CCAvenue Payment'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context, {'status': 'cancelled'}),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
