import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';

void main() {
  runApp(MaterialApp(home: PaypalPaymentDemo()));
}

class PaypalPaymentDemo extends StatelessWidget {
  const PaypalPaymentDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PaypalPaymentDemp',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: TextButton(
            onPressed: () {
              print('something pressed');

              Navigator.of(
                context,
                //).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
              ).pushReplacement(
                MaterialPageRoute(
                  builder:
                      (context) => PaypalCheckoutView(
                        sandboxMode: true,

                        clientId:
                            "AXYh1f38rSBrHwVZlhNMrybwLoa4xrLUnjW-g-G92ZH-Uu1c13caF-tlc7KNykAuz3YfPD9bD0W0_U0r",
                        secretKey:
                            "EAI55p1vNOqaUkdUEbaaGUnV3x0_W3yTo1Fv4ZWY4W4IwcBa1NXdqtCcIPyM30-aDJR8m6_pldyvDa5u",
                        transactions: const [
                          {
                            "amount": {
                              "total": '100',
                              "currency": "USD",
                              "details": {
                                "subtotal": '100',
                                "shipping": '0',
                                "shipping_discount": 0,
                              },
                            },
                            "description":
                                "The payment transaction description.",
                            // "payment_options": {
                            //   "allowed_payment_method":
                            //       "INSTANT_FUNDING_SOURCE"
                            // },
                            "item_list": {
                              "items": [
                                {
                                  "name": "Apple",
                                  "quantity": 4,
                                  "price": '10',
                                  "currency": "USD",
                                },
                                {
                                  "name": "Pineapple",
                                  "quantity": 5,
                                  "price": '12',
                                  "currency": "USD",
                                },
                              ],

                              // Optional
                              //   "shipping_address": {
                              //     "recipient_name": "Tharwat samy",
                              //     "line1": "tharwat",
                              //     "line2": "",
                              //     "city": "tharwat",
                              //     "country_code": "EG",
                              //     "postal_code": "25025",
                              //     "phone": "+00000000",
                              //     "state": "ALex"
                              //  },
                            },
                          },
                        ],
                        note: "Contact us for any questions on your order.",
                        onSuccess: (Map params) async {
                          log("onSuccess: $params");
                          Navigator.pop(context);
                        },
                        onError: (error) {
                          log("onError: $error");
                          Navigator.pop(context);
                        },
                        onCancel: () {
                          print('cancelled:');
                          Navigator.pop(context);
                        },
                      ),
                ),
              );

              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder:
              //         (BuildContext context) => PaypalCheckoutView(
              //           sandboxMode: true,
              //
              //           clientId:
              //               "AXYh1f38rSBrHwVZlhNMrybwLoa4xrLUnjW-g-G92ZH-Uu1c13caF-tlc7KNykAuz3YfPD9bD0W0_U0r",
              //           secretKey:
              //               "EAI55p1vNOqaUkdUEbaaGUnV3x0_W3yTo1Fv4ZWY4W4IwcBa1NXdqtCcIPyM30-aDJR8m6_pldyvDa5u",
              //           transactions: const [
              //             {
              //               "amount": {
              //                 "total": '100',
              //                 "currency": "USD",
              //                 "details": {
              //                   "subtotal": '100',
              //                   "shipping": '0',
              //                   "shipping_discount": 0,
              //                 },
              //               },
              //               "description":
              //                   "The payment transaction description.",
              //               // "payment_options": {
              //               //   "allowed_payment_method":
              //               //       "INSTANT_FUNDING_SOURCE"
              //               // },
              //               "item_list": {
              //                 "items": [
              //                   {
              //                     "name": "Apple",
              //                     "quantity": 4,
              //                     "price": '10',
              //                     "currency": "USD",
              //                   },
              //                   {
              //                     "name": "Pineapple",
              //                     "quantity": 5,
              //                     "price": '12',
              //                     "currency": "USD",
              //                   },
              //                 ],
              //
              //                 // Optional
              //                 //   "shipping_address": {
              //                 //     "recipient_name": "Tharwat samy",
              //                 //     "line1": "tharwat",
              //                 //     "line2": "",
              //                 //     "city": "tharwat",
              //                 //     "country_code": "EG",
              //                 //     "postal_code": "25025",
              //                 //     "phone": "+00000000",
              //                 //     "state": "ALex"
              //                 //  },
              //               },
              //             },
              //           ],
              //           note: "Contact us for any questions on your order.",
              //           onSuccess: (Map params) async {
              //             log("onSuccess: $params");
              //             Navigator.pop(context);
              //           },
              //           onError: (error) {
              //             log("onError: $error");
              //             Navigator.pop(context);
              //           },
              //           onCancel: () {
              //             print('cancelled:');
              //             Navigator.pop(context);
              //           },
              //         ),
              //   ),
              // );
            },
            child: const Text('Pay with paypal'),
          ),
        ),
      ),
    );
  }
}
