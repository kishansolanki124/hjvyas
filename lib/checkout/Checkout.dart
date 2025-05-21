import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hjvyas/checkout/CheckoutWidgets.dart';
import 'package:hjvyas/checkout/PaymentSuccessPage.dart';
import 'package:hjvyas/splash/NoIntternetScreen.dart';
import 'package:intl/intl.dart'; // Import the intl package
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../about/AboutWidgets.dart';
import '../api/models/AddOrderResponse.dart';
import '../api/models/CartItemModel.dart';
import '../api/models/ProductCartResponse.dart';
import '../api/models/ShippingStatusResponse.dart';
import '../api/models/StaticPageResponse.dart';
import '../api/services/HJVyasApiService.dart';
import '../injection_container.dart';
import '../product_detail/ProductDetailWidget.dart';
import '../repositories/HJVyasRepository.dart';
import '../utils/AppColors.dart';
import '../utils/CommonAppProgress.dart';
import 'CheckoutController.dart';
import 'PayPalItem.dart';
import 'TermsAndConditionPopup.dart';

class Checkout extends StatefulWidget {
  final CheckoutController paginationController = CheckoutController(
    getIt<HJVyasApiService>(),
  );

  final HJVyasRepository _userRepo = HJVyasRepository(
    getIt<HJVyasApiService>(),
  );

  final double total;
  final String productTesterId;
  final List<CartItemModel> cartItemShaaredPrefList;
  final List<ProductCartListItem> cartItemsFromAPIforPrice;

  Checkout({
    super.key,
    required this.total,
    required this.productTesterId,
    required this.cartItemShaaredPrefList,
    required this.cartItemsFromAPIforPrice,
  });

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  //paypal stuff
  //todo: change this to production from sandbox creds
  //sandbox
  final String payPalClientId =
      'AXYh1f38rSBrHwVZlhNMrybwLoa4xrLUnjW-g-G92ZH-Uu1c13caF-tlc7KNykAuz3YfPD9bD0W0_U0r';
  //sandbox
  final String payPalSecretKey =
      'EAI55p1vNOqaUkdUEbaaGUnV3x0_W3yTo1Fv4ZWY4W4IwcBa1NXdqtCcIPyM30-aDJR8m6_pldyvDa5u';
  //prod
  // final String payPalClientId =
  //     'AbG87vjmM-W9zV3fp_iop_IW9FneCkhV0mF18Ppk81Pxk1AKKToZHIAy9HX9OAvQX0-3rH0dR-BCmiB2';
  // //prod
  // final String payPalSecretKey =
  //     'EEgKoKiZYrCIrNUnfs8fIlj2gkDkqHEjo_aDSUarw24ttgdlDVZ1DiHaDu6M0Ef6YALexfZ7SOTEKOsT';

  String razorPayKey = "";
  String razorpayOrderid = "";

  // Set to your currency
  final String currency = 'USD';

  // Payment details
  String payPalPaymentStatus = '';
  bool isPayPalLoading = false;

  //payment methods
  late Razorpay _razorpay;
  bool _isRazorpayProcessing = false;

  String? _selectedPaymentMethod;

  String packingWeight = "";
  String packingWeightType = "";

  // Controllers for the TextField values
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _giftSenderNameController =
      TextEditingController();
  final TextEditingController _giftReceiverNameController =
      TextEditingController();
  final TextEditingController _giftSenderMobileController =
      TextEditingController();
  final TextEditingController _giftReceiverMobileController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  //final TextEditingController _areaController = TextEditingController();
  //final TextEditingController _subAreaController = TextEditingController();
  final TextEditingController _deliveryAddressController =
      TextEditingController();
  final TextEditingController _zipcodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();

  //final TextEditingController _stateController = TextEditingController();
  final TextEditingController _alternatePhoneController =
      TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  double shippingCharge = 0;
  double finalAmount = 0;
  double finalCharge = 0;
  double usdPrice = 80;
  double onlineCharge = 0;

  String? _selectedOptionCountry = "";

  String? _selectedOptionState;
  String? _selectedOptionCity;
  CountryListItem? countryListItem;
  StateListItem? stateListItem;
  ShippingStatusResponse? shippingStatusResponse;
  AddOrderResponse? addOrderResponse;
  String? orderNo;

  bool _giftPacksChecked = false;
  bool showCheckoutAddressWidget = false;
  bool shouldShowCheckoutDetails = false;
  bool _tncChecked = false;

  void _startPayPalPayment() async {
    String amountInUSD = "";
    final NumberFormat formatter = NumberFormat("#.00");
    if (usdPrice != 0) {
      amountInUSD = formatter.format(finalAmount / usdPrice);
    }

    if (kDebugMode) {
      print(
        "amountInUSD is $amountInUSD and usdPrice is $usdPrice and final amount is $finalAmount",
      );
    }

    setState(() {
      isPayPalLoading = true;
      payPalPaymentStatus = '';
    });
    try {
      // Define the items being purchased
      List<PayPalItem> items = [
        PayPalItem(
          name: orderNo ??= 'HJ Vyas Products',
          price: amountInUSD,
          quantity: "1",
          currency: currency,
        ),
      ];

      // Navigation and checkout configuration
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder:
              (context) => WillPopScope(
                // Handle back button press
                onWillPop: () async {
                  // This will be called when the system back button is pressed
                  setState(() {
                    payPalPaymentStatus = 'Payment Cancelled';
                    isPayPalLoading = false;
                    errorForPayment("Payment Cancelled.");
                  });
                  return true; // Allow the pop
                },
                child: PaypalCheckoutView(
                  //todo: change this to false for prod
                  sandboxMode: true,
                  clientId: payPalClientId,
                  secretKey: payPalSecretKey,
                  transactions: [
                    {
                      "amount": {
                        "total": amountInUSD,
                        "currency": currency,
                        "details": {
                          "subtotal": amountInUSD,
                          "shipping": '0',
                          "shipping_discount": 0,
                        },
                      },
                      "description":
                          (orderNo != null) ? "HJVyas $orderNo" : "HJVyas",
                      "item_list": {
                        "items": items.map((item) => item.toJson()).toList(),
                      },
                    },
                  ],
                  note: "Contact us for any questions on your order.",
                  onSuccess: (Map params) async {
                    // Handle successful payment
                    if (kDebugMode) {
                      print("onSuccess: $params");
                    }
                    setState(() {
                      payPalPaymentStatus =
                          'Payment Successful!\nTransaction ID: ${params['paymentId']}';
                      isPayPalLoading = false;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => PaymentSuccessPage(orderNo: orderNo!),
                      ),
                    );
                  },
                  onError: (error) {
                    // Handle payment errors
                    print("onError: $error");
                    setState(() {
                      payPalPaymentStatus = 'Payment Error: $error';
                      errorForPayment("Payment Error: $error");
                      isPayPalLoading = false;
                    });
                    Navigator.pop(context);
                  },
                  onCancel: () {
                    // Handle payment cancellation
                    print('Payment cancelled by user');
                    setState(() {
                      payPalPaymentStatus = 'Payment Cancelled';
                      errorForPayment("Payment Cancelled");
                      isPayPalLoading = false;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
        ),
      );

      // Check if we returned without any callbacks being triggered
      // This happens if the modal is dismissed in a way not caught by callbacks
      if (mounted && isPayPalLoading) {
        setState(() {
          payPalPaymentStatus = 'Payment Cancelled';
          isPayPalLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        payPalPaymentStatus = 'Error: ${e.toString()}';
        isPayPalLoading = false;
      });
      print(e);
    }
  }

  void errorForPayment(String errorMessage) {
    // // Show success dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Alert",
            style: TextStyle(
              fontSize: 22,
              color: AppColors.background,
              fontWeight: FontWeight.w700,
              fontFamily: "Montserrat",
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                errorMessage,
                style: TextStyle(
                  color: AppColors.background,
                  fontFamily: "Montserrat",
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
          actions: [
            TextButton(
              child: const Text(
                "OK",
                style: TextStyle(
                  color: AppColors.background,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Montserrat",
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void updatePaymentMethod(String newValue) {
    setState(() {
      _selectedPaymentMethod = newValue;
    });
  }

  void selectedCountryFromDropdown(CountryListItem? countryListItem) {
    if (kDebugMode) {
      print('selectedCountryFromDropdown is changed');
    }

    setState(() {
      this.countryListItem = countryListItem;
      if (kDebugMode) {
        print('_country is ${countryListItem!.countryName}');
      }
      _hideCheckoutAddressWidget();
    });
  }

  void selectedVariantInquiry(StateListItem? stateListItem) {
    if (kDebugMode) {
      print('stateListItem is changed');
    }

    setState(() {
      this.stateListItem = stateListItem;
      if (kDebugMode) {
        print('_country is ${stateListItem!.stateName}');
      }
    });
  }

  void _refreshData() {
    fetchData();
  }

  Future<void> fetchData() async {
    await widget.paginationController.getShippingStatus(); // Explicit call
  }

  @override
  void initState() {
    super.initState();
    //initialise Razorpay SDK
    _initializeRazorpay();
    widget.paginationController.getShippingStatus();
  }

  void _startRazorPayPayment() {
    setState(() {
      _isRazorpayProcessing = true;
    });

    // Parse amount and convert to paise (multiply by 100)
    double enteredAmount = finalAmount;
    int amountInPaise = (enteredAmount * 100).toInt();

    var options = {
      //'key': 'rzp_test_Aqr4FyB60dGtTR',
      'key': razorPayKey,
      // Replace with your Razorpay test key
      'amount': amountInPaise,
      // Amount in paise
      'name': 'HJ Vyas',
      'description':
          (orderNo != null && orderNo!.isNotEmpty)
              ? "H.J. Vyas Order No. $orderNo"
              : "Order Description",
      'prefill': {
        'contact': _phoneController.text,
        // Replace with customer's phone
        'email': _emailController.text,
        // Replace with customer's email
      },
      'notes': {
        'address': _deliveryAddressController.text,
        // Replace with customer's phone
        'merchant_order_id': orderNo,
        // Replace with customer's email
      },
      'external': {
        'wallets': ['paytm', 'gpay'],
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      setState(() {
        _isRazorpayProcessing = false;
      });
      debugPrint('Error: $e');
      showSnackbar(context, "Error: $e");
      // Fluttertoast.showToast(
      //   msg: "Error: $e",
      //   toastLength: Toast.LENGTH_LONG,
      // );
    }
  }

  void _initializeRazorpay() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handleRazorPayPaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handleRazorPayPaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleRazorPayExternalWallet);
  }

  void _handleRazorPayPaymentError(PaymentFailureResponse response) {
    setState(() {
      _isRazorpayProcessing = false;
    });

    if (response.message!.toLowerCase().contains("undefined")) {
      showSnackbar(context, "Payment Failed. Please Try Again!");
    } else {
      showSnackbar(context, "Payment Failed: ${response.message}");
    }
  }

  void _handleRazorPayExternalWallet(ExternalWalletResponse response) {
    setState(() {
      _isRazorpayProcessing = false;
    });

    showSnackbar(context, "External Wallet Selected: ${response.walletName}");
  }

  Future<void> updateRazorPayOrderStatus(String? razorPayPaymentId) async {
    //todo: test this with prod
    await widget.paginationController.addRazorpayStatus(
      orderNo!,
      razorpayOrderid,
      razorPayPaymentId!,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentSuccessPage(orderNo: orderNo!),
      ),
    );
  }

  void _handleRazorPayPaymentSuccess(PaymentSuccessResponse response) {
    print('response.paymentId: ${response.paymentId}');
    print('response.orderId: ${response.orderId}');
    print('response.signature: ${response.signature}');
    print('response.data: ${response.data}');

    setState(() {
      _isRazorpayProcessing = false;
    });

    updateRazorPayOrderStatus(response.paymentId);

    // // Show success dialog
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: const Text("Payment Successful"),
    //       content: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Text("Payment ID: ${response.paymentId}"),
    //           const SizedBox(height: 8),
    //           Text("Order ID: ${response.orderId}"),
    //           const SizedBox(height: 8),
    //           Text("Signature: ${response.signature}"),
    //         ],
    //       ),
    //       actions: [
    //         TextButton(
    //           child: const Text("OK"),
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //         ),
    //       ],
    //     );
    //   },
    // );
  }

  void onOrderPlaced() {
    if (_validatePhone(_phoneController.text) != null) {
      showSnackbar(context, _validatePhone(_phoneController.text).toString());
    } else if (_validateName(_nameController.text) != null) {
      showSnackbar(context, _validateName(_nameController.text).toString());
    } else if (_validateEmail(_emailController.text) != null) {
      showSnackbar(context, _validateEmail(_emailController.text).toString());
    }
    // else if (_validateCity(_areaController.text) != null) {
    //   showSnackbar(context,"Area field is required.");
    // }
    // else if (_validateCity(_subAreaController.text) != null) {
    //   showSnackbar(context,"Sub Area field is required.");
    // }
    else if (_validateCity(_deliveryAddressController.text) != null) {
      showSnackbar(context, "Delivery Address Is Required.");
    } else if (_validateZipcode(_zipcodeController.text) != null) {
      showSnackbar(
        context,
        _validateZipcode(_zipcodeController.text).toString(),
      );
    } else if (_validateCity(_cityController.text) != null) {
      showSnackbar(context, _validateCity(_cityController.text).toString());
    } else if (_selectedOptionCountry != "India" &&
        _validateState(_stateController.text) != null) {
      showSnackbar(context, "State Name Is Required.");
    } else if (stateListItem == null) {
      showSnackbar(context, "State Name Is Required.");
    } else if (_selectedOptionCountry == "India" &&
        _selectedOptionState == "Outside Gujarat" &&
        stateListItem!.stateName == "Select State") {
      showSnackbar(context, "Kindly Select State.");
    } else if (_alternatePhone(_alternatePhoneController.text) != null) {
      showSnackbar(
        context,
        _alternatePhone(_alternatePhoneController.text).toString(),
      );
    } else if (!_tncChecked) {
      showSnackbar(context, "You Must Accept The Terms & Conditions.");
    } else if (null == _selectedPaymentMethod ||
        _selectedPaymentMethod!.isEmpty) {
      showSnackbar(context, "Kindly Select Any Payment Option.");
    } else if (_giftPacksChecked) {
      if (_validateName(_giftSenderNameController.text) != null) {
        showSnackbar(context, "Gift Sender Name Is Required.");
      } else if (_validateName(_giftReceiverNameController.text) != null) {
        showSnackbar(context, "Gift Receiver Name is required.");
      } else if (_validatePhone(_giftSenderMobileController.text) != null) {
        showSnackbar(context, "Gift Sender Mobile Number is required.");
      } else if (_validatePhone(_giftReceiverMobileController.text) != null) {
        showSnackbar(context, "Gift Receiver Mobile Number is required.");
      } else {
        placeOrder();
      }
    } else {
      placeOrder();
    }
  }

  StaticPageResponse? staticPageResponse;
  Future<void> getStaticPage() async {
    staticPageResponse = await widget._userRepo.getStaticpage();
  }

  Future<void> showTNC() async {
    await getStaticPage();
    if (staticPageResponse != null) {
      showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: "Terms and Conditions",
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (_, __, ___) {
          return TermsAndConditionPopup(
            imageUrl:
                getItemByName(
                  staticPageResponse!.staticpageList,
                  "Terms",
                )!.description,
            onClose: () => {},
          );
        },
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      );
    }
  }

  Future<void> placeOrder() async {
    String productIds = widget.cartItemShaaredPrefList
        .map(
          (cartItem) =>
              (cartItem.productDetail.isNotEmpty)
                  ? cartItem.productDetail.elementAt(0).productId
                  : cartItem.comboDetail.elementAt(0).comboId,
        )
        .join(',');

    String productType = widget.cartItemShaaredPrefList
        .map((cartItem) => cartItem.productType.replaceAll("combo_", ""))
        .join(',');

    String productNames = widget.cartItemsFromAPIforPrice
        .map((cartItem) => cartItem.productName)
        .join(',');

    String packingIds = widget.cartItemsFromAPIforPrice
        .map((cartItem) => cartItem.packingId)
        .join(',');

    String packingQuantity = widget.cartItemShaaredPrefList
        .map((cartItem) => cartItem.quantity)
        .join(',');

    String packingPrice = widget.cartItemsFromAPIforPrice
        .map((cartItem) => cartItem.packingPrice)
        .join(',');

    getPackingWeightAndWeightType();

    String payment_type = "";

    String notes = "";
    if (_notesController.text.toString() != null &&
        _notesController.text.isNotEmpty) {
      notes = _notesController.text.toString();
    }

    if (_selectedPaymentMethod == "ICICI Bank Payment Gateway") {
      payment_type = "icici";
    } else if (_selectedPaymentMethod == "PayPal (Outside India Users)") {
      payment_type = "paypal";
    } else {
      payment_type = "ccavenue";
    }

    await widget.paginationController.addOrder(
      _nameController.text.toString(),
      _emailController.text.toString(),
      _phoneController.text.toString(),
      _alternatePhoneController.text.toString().isNotEmpty
          ? _alternatePhoneController.text.toString()
          : "",
      _deliveryAddressController.text.toString(),
      _zipcodeController.text.toString(),
      _selectedOptionCountry == "India"
          ? "India"
          : countryListItem!.countryName,
      _selectedOptionCountry != "India"
          ? _stateController.text.toString()
          : (_selectedOptionState == "Gujarat"
              ? "Gujarat"
              : stateListItem!.stateName),
      _cityController.text.toString(),
      _giftSenderNameController.text.toString(),
      _giftSenderMobileController.text.toString(),
      _giftReceiverNameController.text.toString(),
      _giftReceiverMobileController.text.toString(),
      widget.productTesterId,
      getTwoDecimalPrice(widget.total),
      getTwoDecimalPrice(shippingCharge),
      getTwoDecimalPrice(onlineCharge),
      payment_type,
      "ios",
      //todo: value android, ios any one value
      productIds.replaceAll("combo_", ""),
      productType,
      productNames,
      packingIds,
      packingWeight,
      packingWeightType,
      packingQuantity,
      packingPrice,
      notes,
    );

    addOrderResponse = widget.paginationController.addOrderResponse.value;

    if (null != addOrderResponse) {
      if (addOrderResponse!.orderNo != null &&
          addOrderResponse!.orderNo.isNotEmpty) {
        razorPayKey = addOrderResponse!.keyId;
        razorpayOrderid = addOrderResponse!.razorpayOrderid;

        orderNo = addOrderResponse!.orderNo.toString();
        if (_selectedPaymentMethod == "ICICI Bank Payment Gateway") {
          _startRazorPayPayment();
        } else if (_selectedPaymentMethod == "PayPal (Outside India Users)") {
          _startPayPalPayment();
        }
      }
    }
  }

  void getPackingWeightAndWeightType() {
    List<String> numbersList = [];
    List<String> unitsList = [];

    for (ProductCartListItem product in widget.cartItemsFromAPIforPrice) {
      String weightString = product.packingWeight;
      RegExp numberRegExp = RegExp(r'^\d+(\.\d+)?');
      RegExp unitRegExp = RegExp(r'[a-zA-Z]+$');

      Match? numberMatch = numberRegExp.firstMatch(weightString);
      Match? unitMatch = unitRegExp.firstMatch(weightString);

      if (numberMatch != null && unitMatch != null) {
        numbersList.add(numberMatch.group(0)!);
        unitsList.add(unitMatch.group(0)!.trim().toUpperCase());
      } else if (numberMatch != null) {
        numbersList.add(numberMatch.group(0)!);
        unitsList.add("NA");
      } else if (unitMatch != null) {
        numbersList.add("NA");
        unitsList.add(unitMatch.group(0)!);
      } else {
        numbersList.add("NA");
        unitsList.add("NA");
      }
    }

    packingWeight = numbersList.join(', ');
    packingWeightType = unitsList.join(', ');
  }

  void onContinueClick() {
    hideKeyboard(context);
    if (_validatePhone(_phoneController.text) != null) {
      showSnackbar(context, _validatePhone(_phoneController.text).toString());
    } else if (_selectedOptionCountry == "Outside India" &&
        countryListItem!.countryName == "Select Country") {
      showSnackbar(context, "Kindly Select Country.");
    } else {
      getShippingCharge();
    }
  }

  // Function to validate the form fields
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name Is Required.';
    }
    if (value.length < 3) {
      return 'Name Must Be At Least 3 Characters Long.';
    }
    return null; // Return null if the input is valid
  }

  String? _validateCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'City Is Required.';
    }
    if (value.length < 2) {
      return 'City Name Is Too Short.';
    }
    return null;
  }

  String? _validateState(String? value) {
    if (value == null || value.isEmpty) {
      return 'State Is Required.';
    }
    if (value.length < 2) {
      return 'State Name Is Too Short.';
    }
    return null;
  }

  String? _validateZipcode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Zipcode Is Required.';
    }
    // if (value.length < 6) {
    //   return 'Invalid Zipcode.';
    // }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email Is Required.';
    }
    if (!EmailValidator.validate(value)) {
      return 'Invalid Email Address.';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Contact Number Is required.';
    }
    if (value.length < 10) {
      return 'Contact No. Should Be At Least 10 digits.';
    }
    return null;
  }

  String? _alternatePhone(String? value) {
    if (value != null && value.isNotEmpty && value.length < 10) {
      return 'Alternate Mobile No. Must Be At Least 10 Digits.';
    }
    return null;
  }

  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed
    _phoneController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    //_areaController.dispose();
    //_subAreaController.dispose();
    _deliveryAddressController.dispose();
    _zipcodeController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _alternatePhoneController.dispose();
    _notesController.dispose();
    _giftSenderNameController.dispose();
    _giftReceiverNameController.dispose();
    _giftSenderMobileController.dispose();
    _giftReceiverMobileController.dispose();

    //remove razor pay objects
    _razorpay.clear();

    super.dispose();
  }

  Future<void> getShippingCharge() async {
    String countryOutside =
        _selectedOptionCountry == "India"
            ? "no"
            : (countryListItem != null)
            ? countryListItem!.id
            : "yes";

    String stateOutofGujarat =
        (_selectedOptionState == "Gujarat" || _selectedOptionCountry != "India")
            ? "no"
            : "yes";

    String cityJamnagar =
        (stateOutofGujarat == "no" &&
                _selectedOptionCity == "Jamnagar" &&
                _selectedOptionCountry == "India")
            ? "yes"
            : "no";

    String cityOther =
        (stateOutofGujarat == "no" &&
                countryOutside == "no" &&
                _selectedOptionCity == "Other City")
            ? "yes"
            : "no";

    List<String> weightList = [];

    for (int i = 0; i < widget.cartItemShaaredPrefList.length; i++) {
      int quantity = int.parse(
        widget.cartItemShaaredPrefList.elementAt(i).quantity,
      );
      if (quantity > 1) {
        for (int j = 0; j < quantity; j++) {
          weightList.add(
            widget.cartItemsFromAPIforPrice.elementAt(i).packingWeight,
          );
        }
      } else {
        weightList.add(
          widget.cartItemsFromAPIforPrice.elementAt(i).packingWeight,
        );
      }
    }

    double totalWeight = calculateTotalWeightInKg(weightList);

    if (kDebugMode) {
      print('totalWeight is $totalWeight');
    }

    String cartAmount = widget.total.toString();

    await widget.paginationController.getShippingCharge(
      cityJamnagar,
      cityOther,
      stateOutofGujarat,
      countryOutside,
      getTwoDecimalPrice(totalWeight),
      cartAmount,
    );

    showSnackbar(context, "Shipping Charge Is Updated.");

    _showCheckoutAddressWidget();
  }

  double calculateTotalWeightInKg(List<String> weights) {
    double totalKg = 0.0;

    if (weights.isEmpty) {
      return 0.0; // Handle empty list case
    }

    for (String weightString in weights) {
      // Remove leading/trailing spaces and convert to uppercase for easier parsing
      String cleanWeightString = weightString.trim().toUpperCase();

      // Use a regular expression to extract the numeric value and the unit
      RegExp regex = RegExp(r'(\d+\.?\d*)\s*(KG|GM|G)');
      Match? match = regex.firstMatch(cleanWeightString);

      if (match != null) {
        double value = double.parse(match.group(1)!); // Parse the numeric value
        String? unit = match.group(2); // Get the unit (KG, GM, or G)

        if (unit == 'KG') {
          totalKg += value;
        } else if (unit == 'GM' || unit == 'G') {
          totalKg += value / 1000; // Convert grams to kilograms
        }
        //If unit is not KG, GM, or G, then the value is ignored.
      } else {
        // Handle the case where the string doesn't match the expected format
        // You might want to log an error, show a message, or throw an exception
        if (kDebugMode) {
          print('Warning: Invalid weight format: $weightString');
        }
        //  You could choose to throw an exception here:
        //  throw FormatException('Invalid weight format: $weightString');
      }
    }

    return totalKg;
  }

  // Keep track of the selected option
  void _onBackPressed(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _onGiftPackValueUpdate(bool newValue) {
    setState(() {
      _giftPacksChecked = newValue;
    });
  }

  void _showCheckoutAddressWidget() {
    setState(() {
      showCheckoutAddressWidget = true;
    });
  }

  // void _updateCheckoutDetails(bool value) {
  //   setState(() {
  //     shouldShowCheckoutDetails = value;
  //   });
  // }

  void _hideCheckoutAddressWidget() {
    setState(() {
      showCheckoutAddressWidget = false;
    });
  }

  void _tncCheckedValueUpdate(bool newValue) {
    setState(() {
      _tncChecked = newValue;
    });
  }

  void _onValueChangedCountry(String value) {
    if (value == _selectedOptionCountry) {
      return;
    }

    setState(() {
      _cityController.text = "";

      _selectedOptionCountry = value;
      _hideCheckoutAddressWidget();
    });
  }

  void _onValueChangedCity(String value) {
    if (value == _selectedOptionCity) {
      return;
    }
    setState(() {
      _selectedOptionCity = value;
      if (_selectedOptionCity == "Jamnagar") {
        _cityController.text = "Jamnagar";
      } else {
        _cityController.text = "";
      }
      _hideCheckoutAddressWidget();
    });
  }

  void _onValueChangedState(String value) {
    if (value == _selectedOptionState) {
      return;
    }
    setState(() {
      _cityController.text = "";
      _selectedOptionState = value;
      _hideCheckoutAddressWidget();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        // if (widget.paginationController.isError.value) {
        //   return NoInternetScreen(
        //     showBackgroundImage: true,
        //     onRetry: () {
        //       _refreshData();
        //     },
        //   );
        // }

        bool outSideIndia = false;
        bool otherStateOn = false;
        bool isGujaratOn = false;
        if (!widget.paginationController.isLoading.value &&
            null != widget.paginationController.shippingStatusResponse.value) {
          shippingStatusResponse =
              widget.paginationController.shippingStatusResponse.value;

          if (null != shippingStatusResponse &&
              shippingStatusResponse!.countryList.isNotEmpty &&
              shippingStatusResponse!.countryList.elementAt(0).countryName !=
                  "Select Country") {
            //adding default first option as select Country
            shippingStatusResponse!.countryList.insert(
              0,
              CountryListItem(id: "-1", countryName: "Select Country"),
            );
          }

          if (null != shippingStatusResponse &&
              shippingStatusResponse!.stateList.isNotEmpty &&
              shippingStatusResponse!.stateList.elementAt(0).stateName !=
                  "Select State") {
            //adding default first option as select Country
            shippingStatusResponse!.stateList.insert(
              0,
              StateListItem(id: "-1", stateName: "Select State"),
            );
          }

          usdPrice = double.parse(
            shippingStatusResponse!.shippingStatusList
                .elementAt(0)
                .rupeeExchangeRate,
          );

          if (null !=
              widget.paginationController.shippingChargesResponse.value) {
            shippingCharge = double.parse(
              widget
                  .paginationController
                  .shippingChargesResponse
                  .value!
                  .shippingCharge, //actually we are showing final charge i.e. shipping + online charges
            );
            onlineCharge = double.parse(
              widget
                  .paginationController
                  .shippingChargesResponse
                  .value!
                  .onlineCharge, //actually we are showing final charge i.e. shipping + online charges
            );
            finalAmount = double.parse(
              widget
                  .paginationController
                  .shippingChargesResponse
                  .value!
                  .finalAmount, //actually we are showing final charge i.e. shipping + online charges
            );
            finalCharge = double.parse(
              widget
                  .paginationController
                  .shippingChargesResponse
                  .value!
                  .finalCharge, //actually we are showing final charge i.e. shipping + online charges
            );
          }

          outSideIndia =
              (shippingStatusResponse!.shippingStatusList
                          .elementAt(0)
                          .outsideindiaStatus ==
                      "on")
                  ? true
                  : false;

          otherStateOn =
              (shippingStatusResponse!.shippingStatusList
                          .elementAt(0)
                          .outofgujaratStatus ==
                      "on")
                  ? true
                  : false;

          isGujaratOn =
              (shippingStatusResponse!.shippingStatusList
                          .elementAt(0)
                          .gujaratStatus ==
                      "on")
                  ? true
                  : false;

          if (!outSideIndia && _selectedOptionCountry == "Outside India") {
            //_updateCheckoutDetails(false);
            shouldShowCheckoutDetails = false;
          } else if (!otherStateOn &&
              _selectedOptionState == "Outside Gujarat") {
            //_updateCheckoutDetails(false);
            shouldShowCheckoutDetails = false;
          } else if (!isGujaratOn && _selectedOptionCity == "Other City") {
            //_updateCheckoutDetails(false);
            shouldShowCheckoutDetails = false;
          } else if ((null != _selectedOptionCountry &&
                  _selectedOptionCountry == "Outside India") ||
              (null != _selectedOptionState &&
                  _selectedOptionState == "Outside Gujarat") ||
              (null != _selectedOptionCity &&
                  _selectedOptionCity!.isNotEmpty)) {
            //_updateCheckoutDetails(true);
            shouldShowCheckoutDetails = true;
          }

          countryListItem ??= shippingStatusResponse?.countryList.elementAt(0);
          stateListItem ??= shippingStatusResponse?.stateList.elementAt(0);
        }

        return SafeArea(
          child: Scaffold(
            body: Stack(
              children: <Widget>[
                // 1. Background Image
                Image.asset(
                  'images/bg.jpg', // Replace with your image path
                  fit: BoxFit.cover, // Cover the entire screen
                  width: double.infinity,
                  height: double.infinity,
                ),

                //square border app color
                IgnorePointer(
                  child: Container(
                    height: 80,
                    margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 0),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: AppColors.secondary,
                          width: 2.0,
                        ),
                        bottom: BorderSide(
                          color: AppColors.secondary,
                          width: 2.0,
                        ),
                        right: BorderSide(
                          color: AppColors.secondary,
                          width: 2.0,
                        ),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                    ),
                  ),
                ),

                backButton(() => _onBackPressed(context)),

                SafeArea(
                  // Use SafeArea to avoid overlapping with system UI
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 40.0),

                        // Title
                        Center(
                          child: Container(
                            color: AppColors.background,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'Checkout',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 8.0),

                        if (widget.paginationController.isLoading.value &&
                            null ==
                                widget
                                    .paginationController
                                    .shippingStatusResponse
                                    .value) ...[
                          getCommonProgressBar(),
                        ],

                        if (widget.paginationController.isError.value) ...[
                          NoInternetScreen(
                            showBackgroundImage: false,
                            onRetry: () {
                              _refreshData();
                            },
                          ),
                        ],

                        if (!widget.paginationController.isLoading.value &&
                            null !=
                                widget
                                    .paginationController
                                    .shippingStatusResponse
                                    .value) ...[
                          // cart total
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //cart total
                                  CartTotalRow(
                                    "Cart Total",
                                    "₹ ${getTwoDecimalPrice(widget.total)}",
                                    10,
                                  ),

                                  //shipping charge
                                  CartTotalRow(
                                    "Shipping Charge",
                                    "₹ ${getTwoDecimalPrice(finalCharge)}",
                                    10,
                                  ),

                                  //Grand Total
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(top: 20),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.secondary,
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      child: CartTotalRow(
                                        "Grand Total",
                                        finalAmount > 0
                                            ? "₹ ${getTwoDecimalPrice(finalAmount)}"
                                            : "₹ ${getTwoDecimalPrice(widget.total + shippingCharge)}",
                                        0,
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 20.0),
                                  // Description
                                  //your delivery address
                                  Text(
                                    "Your Delivery Address",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontFamily: "Montserrat",
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),

                                  SizedBox(height: 10.0),
                                  // Description
                                  //Select Country
                                  Text(
                                    "Select Country",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontFamily: "Montserrat",
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),

                                  SizedBox(height: 10),

                                  //country radio
                                  radioTwoOption(
                                    shippingStatusResponse,
                                    "India",
                                    "Outside India",
                                    _onValueChangedCountry,
                                    _selectedOptionCountry,
                                  ),

                                  if (_selectedOptionCountry ==
                                          "Outside India" && //!outSideIndia) ...[
                                      shippingStatusResponse!.shippingStatusList
                                          .elementAt(0)
                                          .outsideindiaMsg
                                          .isNotEmpty) ...[
                                    //outside india not allowed
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 8.0,
                                      ),
                                      child: Text(
                                        shippingStatusResponse!
                                            .shippingStatusList
                                            .elementAt(0)
                                            .outsideindiaMsg,
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontFamily: "Montserrat",
                                          color: Colors.red,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],

                                  if (_selectedOptionCountry == "India") ...[
                                    //selected option is India
                                    //Select State
                                    Text(
                                      "Select State",
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontFamily: "Montserrat",
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),

                                    SizedBox(height: 10),

                                    //state radio
                                    radioTwoOption(
                                      shippingStatusResponse,
                                      "Gujarat",
                                      "Outside Gujarat",
                                      _onValueChangedState,
                                      _selectedOptionState,
                                    ),

                                    if (_selectedOptionCountry == "India" &&
                                        _selectedOptionState != null &&
                                        _selectedOptionState!.isNotEmpty) ...[
                                      if (_selectedOptionState ==
                                              "Outside Gujarat" && //!otherStateOn) ...[
                                          shippingStatusResponse!
                                              .shippingStatusList
                                              .elementAt(0)
                                              .outofgujaratMsg
                                              .isNotEmpty) ...[
                                        //outside Gujarat not allowed
                                        Text(
                                          shippingStatusResponse!
                                              .shippingStatusList
                                              .elementAt(0)
                                              .outofgujaratMsg,
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontFamily: "Montserrat",
                                            color: Colors.red,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],

                                      if (_selectedOptionState == "Gujarat" ||
                                          otherStateOn) ...[
                                        if (_selectedOptionState ==
                                            "Gujarat") ...[
                                          //Select City
                                          Text(
                                            "Select City",
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontFamily: "Montserrat",
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),

                                          SizedBox(height: 10),

                                          //City radio
                                          radioTwoOption(
                                            shippingStatusResponse,
                                            "Jamnagar",
                                            "Other City",
                                            _onValueChangedCity,
                                            _selectedOptionCity,
                                          ),
                                        ],

                                        if (_selectedOptionState == "Gujarat" &&
                                            _selectedOptionCity ==
                                                "Other City" && //!isGujaratOn) ...[
                                            shippingStatusResponse!
                                                .shippingStatusList
                                                .elementAt(0)
                                                .gujaratMsg
                                                .isNotEmpty) ...[
                                          //within Gujarat only Jamnagar is allowed
                                          Text(
                                            shippingStatusResponse!
                                                .shippingStatusList
                                                .elementAt(0)
                                                .gujaratMsg,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontFamily: "Montserrat",
                                              color: Colors.red,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],

                                        if (_selectedOptionCity == "Jamnagar" ||
                                            isGujaratOn) ...[
                                          SizedBox(height: 20.0),
                                        ],
                                      ],
                                    ],
                                  ],

                                  if (outSideIndia &&
                                      _selectedOptionCountry ==
                                          "Outside India") ...[
                                    //selected option is out side india
                                    //dropdown of country
                                    Container(
                                      width: double.infinity,
                                      // Full width
                                      //height: 40,
                                      // Fixed height
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.secondary,
                                        ),
                                        borderRadius: BorderRadius.circular(0),
                                        color:
                                            Colors
                                                .transparent, // Background color
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 6.0,
                                      ),
                                      // Add horizontal padding
                                      child: DropdownButtonFormField<
                                        CountryListItem
                                      >(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                          0,
                                          8,
                                          0,
                                          8,
                                        ),
                                        value:
                                            (null != countryListItem)
                                                ? countryListItem
                                                : shippingStatusResponse!
                                                    .countryList
                                                    .elementAt(0),
                                        icon: Image.asset(
                                          'icons/dropdown_icon.png',
                                          // Replace with your icon path
                                          width: 18, // Adjust width as needed
                                          height: 18, // Adjust height as needed
                                        ),
                                        onChanged: (newValue) {
                                          // setState(() {
                                          selectedCountryFromDropdown(newValue);
                                          //selectedCountryFromDropdown = newValue;
                                          if (kDebugMode) {
                                            print(
                                              'country $selectedCountryFromDropdown',
                                            );
                                          }
                                          // });
                                        },
                                        items:
                                            shippingStatusResponse!.countryList
                                                .map((CountryListItem item) {
                                                  return DropdownMenuItem<
                                                    CountryListItem
                                                  >(
                                                    value: item,
                                                    child: Text(
                                                      item.countryName,
                                                      style: TextStyle(
                                                        backgroundColor:
                                                            AppColors
                                                                .background,
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                        fontFamily:
                                                            "Montserrat",
                                                        //fontWeight: FontWeight.w700,
                                                      ),
                                                    ),
                                                  );
                                                })
                                                .toList(),
                                        decoration: InputDecoration(
                                          border:
                                              InputBorder
                                                  .none, // Remove default border
                                          isDense: true, // Make it compact
                                          contentPadding: EdgeInsets.zero,
                                          // suffixIcon: Image.asset(
                                          //   width: 12,
                                          //   height: 12,
                                          //   'icons/dropdown_icon.png',
                                          // ),
                                        ),
                                        dropdownColor: AppColors.background,
                                        //underline: SizedBox(),
                                      ),
                                    ),

                                    SizedBox(height: 10),
                                  ],

                                  if (shouldShowCheckoutDetails) ...[
                                    //your delivery address
                                    Text(
                                      "Checkout Details",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: "Montserrat",
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),

                                    SizedBox(height: 10.0),

                                    //enter your mob no.
                                    // with 10 digit max length and input type should be only numbers
                                    TextField(
                                      controller: _phoneController,
                                      keyboardType: TextInputType.number,
                                      maxLength: 14,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Montserrat",
                                        fontSize: 14,
                                      ),
                                      // Set text color to white
                                      decoration: InputDecoration(
                                        hintText: "Enter Mobile No.",
                                        hintStyle: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Montserrat",
                                          fontSize: 14,
                                        ),

                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(0),
                                          ),
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: AppColors.secondary,
                                          ),
                                        ),
                                        // disabledBorder: OutlineInputBorder(
                                        //   borderRadius: BorderRadius.all(Radius.circular(4)),
                                        //   borderSide: BorderSide(width: 1,color: Colors.orange),
                                        // ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(0),
                                          ),
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: AppColors.secondary,
                                          ),
                                        ),

                                        contentPadding: EdgeInsets.all(8),
                                        isDense: true, //make textfield compact
                                      ),
                                    ),

                                    //Continue button
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          onContinueClick();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.secondary,
                                          // Sky color
                                          //foregroundColor: Colors.black,
                                          // Black text color
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius
                                                    .zero, // Square corners
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            vertical: 10.0,
                                            horizontal: 36,
                                          ), // Add some vertical padding
                                        ),
                                        child: Obx(() {
                                          if (widget
                                              .paginationController
                                              .shippingChargesLoading
                                              .value) {
                                            return SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.white,
                                              ),
                                            );
                                          }
                                          return Text(
                                            "Continue",
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ), // Adjust size
                                          );
                                        }),
                                      ),
                                    ),

                                    SizedBox(height: 10),

                                    if (showCheckoutAddressWidget) ...[
                                      CheckoutAddressWidget(
                                        _onGiftPackValueUpdate,
                                        _giftPacksChecked,
                                        _tncCheckedValueUpdate,
                                        _tncChecked,
                                        _nameController,
                                        _emailController,
                                        //_areaController,
                                        //_subAreaController,
                                        _deliveryAddressController,
                                        _zipcodeController,
                                        _cityController,
                                        _stateController,
                                        shippingStatusResponse!.stateList,
                                        _selectedOptionCity,
                                        _selectedOptionState,
                                        _selectedOptionCountry,
                                        selectedVariantInquiry,
                                        _alternatePhoneController,
                                        _notesController,
                                        _giftSenderNameController,
                                        _giftReceiverNameController,
                                        _giftSenderMobileController,
                                        _giftReceiverMobileController,
                                        showTNC,
                                      ),

                                      if (shippingStatusResponse != null &&
                                          (shippingStatusResponse!
                                                      .shippingStatusList
                                                      .elementAt(0)
                                                      .razorpayGateway ==
                                                  "on" ||
                                              shippingStatusResponse!
                                                      .shippingStatusList
                                                      .elementAt(0)
                                                      .ccavenueGateway ==
                                                  "on" ||
                                              shippingStatusResponse!
                                                      .shippingStatusList
                                                      .elementAt(0)
                                                      .paypalGateway ==
                                                  "on")) ...[
                                        //payment options
                                        paymentOptions(
                                          shippingStatusResponse!
                                              .shippingStatusList
                                              .elementAt(0),
                                          _selectedPaymentMethod,
                                          updatePaymentMethod,
                                        ),
                                      ],

                                      //submit button /Proceed To Pay button
                                      widget
                                              .paginationController
                                              .addOrderResponseLoading
                                              .value
                                          ? Center(
                                            child: getCommonProgressBar(),
                                          )
                                          : SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              onPressed: onOrderPlaced,
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    AppColors.secondary,
                                                // Sky color
                                                //foregroundColor: Colors.black,
                                                // Black text color
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius
                                                          .zero, // Square corners
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 10.0,
                                                  horizontal: 36,
                                                ), // Add some vertical padding
                                              ),
                                              child: Text(
                                                "Proceed To Pay",
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                ), // Adjust size
                                              ),
                                            ),
                                          ),
                                    ],

                                    if (null !=
                                            shippingStatusResponse!
                                                .shippingStatusList
                                                .elementAt(0)
                                                .shippingTerms &&
                                        shippingStatusResponse!
                                            .shippingStatusList
                                            .elementAt(0)
                                            .shippingTerms
                                            .isNotEmpty) ...[
                                      SizedBox(height: 10),

                                      Text(
                                        shippingStatusResponse!
                                            .shippingStatusList
                                            .elementAt(0)
                                            .shippingTerms,
                                        style: TextStyle(
                                          color: AppColors.secondary,
                                          fontSize: 10.0,
                                          fontFamily: "Montserrat",
                                        ),
                                      ),
                                    ],
                                  ],

                                  // // Pay button
                                  // ElevatedButton(
                                  //   onPressed:
                                  //       _isRazorpayProcessing
                                  //           ? null
                                  //           : _startRazorPayPayment,
                                  //   style: ElevatedButton.styleFrom(
                                  //     backgroundColor: Colors.blue,
                                  //     foregroundColor: Colors.white,
                                  //     padding: const EdgeInsets.symmetric(
                                  //       vertical: 16,
                                  //     ),
                                  //     shape: RoundedRectangleBorder(
                                  //       borderRadius: BorderRadius.circular(8),
                                  //     ),
                                  //   ),
                                  //   child:
                                  //       _isRazorpayProcessing
                                  //           ? const Row(
                                  //             mainAxisAlignment:
                                  //                 MainAxisAlignment.center,
                                  //             children: [
                                  //               SizedBox(
                                  //                 width: 20,
                                  //                 height: 20,
                                  //                 child:
                                  //                     CircularProgressIndicator(
                                  //                       color: Colors.white,
                                  //                       strokeWidth: 2,
                                  //                     ),
                                  //               ),
                                  //               SizedBox(width: 12),
                                  //               Text("Processing..."),
                                  //             ],
                                  //           )
                                  //           : Text(
                                  //             "Pay ₹${finalAmount.toStringAsFixed(2)}",
                                  //           ),
                                  // ),
                                  SizedBox(height: 100),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );

        return Center(child: Text("Empty"));
      }),
    );
  }
}
