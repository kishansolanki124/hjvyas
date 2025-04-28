import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hjvyas/checkout/CheckoutWidgets.dart';

import '../api/models/CartItemModel.dart';
import '../api/models/ProductCartResponse.dart';
import '../api/models/ShippingStatusResponse.dart';
import '../api/services/HJVyasApiService.dart';
import '../injection_container.dart';
import '../product_detail/ProductDetailWidget.dart';
import 'CheckoutController.dart';

class Checkout extends StatefulWidget {
  final CheckoutController paginationController = CheckoutController(
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

  String packingWeight = "";
  String packingWeightType = "";


  // Controllers for the TextField values
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _subAreaController = TextEditingController();
  final TextEditingController _deliveryAddressController =
      TextEditingController();
  final TextEditingController _zipcodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _alternatePhoneController =
      TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  double shippingCharge = 0;
  double finalAmount = 0;
  double onlineCharge = 0;

  String? _selectedOptionCountry = "";

  //todo: API have country list and state list, implement here :(
  //todo: shipping_terms also available in API, show here
  String? _selectedOptionState;
  String? _selectedOptionCity;
  ShippingStatusResponse? shippingStatusResponse;

  bool _giftPackisChecked = false;
  bool showCheckoutAddressWidget = false;
  bool _tncChecked = false;

  @override
  void initState() {
    super.initState();
    widget.paginationController.getShippingStatus();
  }

  void onOrderPlaced() {
    if (_validatePhone(_phoneController.text) != null) {
      showSnackbar(_validatePhone(_phoneController.text).toString());
    } else if (_validateName(_nameController.text) != null) {
      showSnackbar(_validateName(_nameController.text).toString());
    } else if (_validateEmail(_emailController.text) != null) {
      showSnackbar(_validateEmail(_emailController.text).toString());
    } else if (_validateCity(_areaController.text) != null) {
      showSnackbar("Area field is required.");
    } else if (_validateCity(_subAreaController.text) != null) {
      showSnackbar("Sub Area field is required.");
    } else if (_validateCity(_deliveryAddressController.text) != null) {
      showSnackbar("Delivery Address is required.");
    } else if (_validateZipcode(_zipcodeController.text) != null) {
      showSnackbar(_validateZipcode(_zipcodeController.text).toString());
    } else if (_validateCity(_cityController.text) != null) {
      showSnackbar(_validateCity(_cityController.text).toString());
    } else if (_validateCity(_stateController.text) != null) {
      showSnackbar("State name is required.");
    } else if (_alternatePhone(_alternatePhoneController.text) != null) {
      showSnackbar(_alternatePhone(_alternatePhoneController.text).toString());
    } else {
      placeOrder();
    }
  }

  Future<void> placeOrder() async  {
    String productIds = widget.cartItemShaaredPrefList
        .map((cartItem) => cartItem.productPackingId)
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

    await widget.paginationController.addOrder(
      _nameController.text.toString(),
      _emailController.text.toString(),
      _phoneController.text.toString(),
      _alternatePhoneController.text.toString().isNotEmpty ? _alternatePhoneController.text.toString()
          : "",
      _deliveryAddressController.text.toString(),
      _zipcodeController.text.toString(),
      _selectedOptionCountry!,//todo work for country
      _stateController.text.toString(),
      _cityController.text.toString(),
      "gift_sender", //todo
      "gift_sender_mobile", //todo
      "gift_receiver",//todo
      "gift_receiver_mobile",//todo
      widget.productTesterId,
      finalAmount.toString(),
      shippingCharge.toString(),
      onlineCharge.toString(),
      "icici", //todo payment_type value icici, ccavenue, paypal any one
      "android", //todo: value android, ios any one value
        productIds.replaceAll("combo_", ""),
        productType,
      productNames,
      packingIds,
      packingWeight,
      packingWeightType,
      packingQuantity,
      packingPrice,
    );
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

  void showSnackbar(String s) {
    var snackBar = SnackBar(
      backgroundColor: Colors.white,
      content: Text(
        s,
        style: TextStyle(
          fontSize: 14.0,
          fontFamily: "Montserrat",
          color: Color.fromARGB(255, 32, 47, 80),
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void onContinueClick() {
    if (_validatePhone(_phoneController.text) != null) {
      showSnackbar(_validatePhone(_phoneController.text).toString());
    } else {
      getShippingCharge();
    }
  }

  // Function to validate the form fields
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 3) {
      return 'Name must be at least 3 characters long';
    }
    return null; // Return null if the input is valid
  }

  String? _validateCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'City is required';
    }
    if (value.length < 2) {
      return 'City name is too short';
    }
    return null;
  }

  String? _validateZipcode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Zipcode is required';
    }
    if (value.length < 6) {
      return 'Invalid Zipcode.';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!EmailValidator.validate(value)) {
      return 'Invalid email address';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Contact number is required';
    }
    if (value.length != 10) {
      return 'Contact number must be 10 digits';
    }
    return null;
  }

  String? _alternatePhone(String? value) {
    if (value != null && value.isNotEmpty && value.length != 10) {
      return 'Alternate mobile number must be 10 digits';
    }
    return null;
  }

  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed
    _phoneController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _areaController.dispose();
    _subAreaController.dispose();
    _deliveryAddressController.dispose();
    _zipcodeController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _alternatePhoneController.dispose();
    _notesController.dispose();

    super.dispose();
  }

  Future<void> getShippingCharge() async {
    String stateOutofGujarat = _selectedOptionState == "Gujarat" ? "no" : "yes";
    String cityJamnagar =
        (stateOutofGujarat == "no" && _selectedOptionCity == "Jamnagar")
            ? "yes"
            : "no";
    String cityOther =
        (stateOutofGujarat == "no" && _selectedOptionCity == "Other City")
            ? "yes"
            : "no";
    String countryOutside = _selectedOptionCountry == "India" ? "no" : "yes";

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
      totalWeight.toString(),
      cartAmount,
    );
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
      _giftPackisChecked = newValue;
    });
  }

  void _showCheckoutAddressWidget() {
    setState(() {
      showCheckoutAddressWidget = true;
    });
  }

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
      _hideCheckoutAddressWidget();
    });
  }

  void _onValueChangedState(String value) {
    if (value == _selectedOptionState) {
      return;
    }
    setState(() {
      _selectedOptionState = value;
      _hideCheckoutAddressWidget();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (widget.paginationController.isLoading.value &&
            null == widget.paginationController.shippingStatusResponse.value) {
          //API called
          //todo: change this
          return Container(
            color: Color.fromARGB(255, 31, 47, 80),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (!widget.paginationController.isLoading.value &&
            null != widget.paginationController.shippingStatusResponse.value) {
          shippingStatusResponse =
              widget.paginationController.shippingStatusResponse.value;

          if (null !=
              widget.paginationController.shippingChargesResponse.value) {
            shippingCharge = double.parse(
              widget
                  .paginationController
                  .shippingChargesResponse
                  .value!
                  .finalCharge, //actually we are showing final charge i.e. shipping + online charges
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
          }

          bool outSideIndia =
              (shippingStatusResponse!.shippingStatusList
                          .elementAt(0)
                          .outsideindiaStatus ==
                      "on")
                  ? true
                  : false;

          bool isGujaratOn =
              (shippingStatusResponse!.shippingStatusList
                          .elementAt(0)
                          .gujaratStatus ==
                      "on")
                  ? true
                  : false;

          bool otherStateOn =
              (shippingStatusResponse!.shippingStatusList
                          .elementAt(0)
                          .outofgujaratStatus ==
                      "on")
                  ? true
                  : false;

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
                      height: 100,
                      margin: EdgeInsets.only(
                        left: 16.0,
                        right: 16.0,
                        bottom: 0,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: Color.fromARGB(255, 123, 138, 195),
                            width: 2.0,
                          ),
                          bottom: BorderSide(
                            color: Color.fromARGB(255, 123, 138, 195),
                            width: 2.0,
                          ),
                          right: BorderSide(
                            color: Color.fromARGB(255, 123, 138, 195),
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
                          SizedBox(height: 60.0),

                          // Title
                          Center(
                            child: Container(
                              color: Color.fromARGB(255, 31, 47, 80),
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

                          SizedBox(height: 8.0), // Description

                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //cart total
                                  CartTotalRow(
                                    "Cart Total",
                                    "₹ ${widget.total}",
                                    10,
                                  ),

                                  //shipping charge
                                  CartTotalRow(
                                    "Shipping Charge",
                                    "₹ $shippingCharge",
                                    10,
                                  ),

                                  //Grand Total
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(top: 20),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color.fromARGB(
                                          255,
                                          123,
                                          138,
                                          195,
                                        ),
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
                                            ? "₹ $finalAmount"
                                            : "₹ ${widget.total + shippingCharge}",
                                        0,
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 20.0), // Description
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

                                  SizedBox(height: 10.0), // Description
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
                                          "Outside India" &&
                                      !outSideIndia) ...[
                                    //outside india not allowed
                                    Text(
                                      shippingStatusResponse!.shippingStatusList
                                          .elementAt(0)
                                          .outsideindiaMsg,
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontFamily: "Montserrat",
                                        color: Colors.red,
                                        fontWeight: FontWeight.w500,
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
                                    if (_selectedOptionCountry != null &&
                                        _selectedOptionCountry!.isNotEmpty) ...[
                                      radioTwoOption(
                                        shippingStatusResponse,
                                        "Gujarat",
                                        "Outside Gujarat",
                                        _onValueChangedState,
                                        _selectedOptionState,
                                      ),

                                      if (_selectedOptionState != null &&
                                          _selectedOptionState!.isNotEmpty) ...[
                                        if (_selectedOptionState ==
                                                "Outside Gujarat" &&
                                            !otherStateOn) ...[
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

                                          if (_selectedOptionCity ==
                                                  "Other City" &&
                                              !isGujaratOn) ...[
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

                                          if (_selectedOptionCity ==
                                                  "Jamnagar" ||
                                              isGujaratOn) ...[
                                            SizedBox(height: 20.0),
                                            // Description
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
                                              keyboardType:
                                                  TextInputType.number,
                                              maxLength: 10,
                                              inputFormatters:
                                                  <TextInputFormatter>[
                                                    FilteringTextInputFormatter
                                                        .digitsOnly,
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

                                                focusedBorder:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                            Radius.circular(0),
                                                          ),
                                                      borderSide: BorderSide(
                                                        width: 1,
                                                        color: Color.fromARGB(
                                                          255,
                                                          123,
                                                          138,
                                                          195,
                                                        ),
                                                      ),
                                                    ),
                                                // disabledBorder: OutlineInputBorder(
                                                //   borderRadius: BorderRadius.all(Radius.circular(4)),
                                                //   borderSide: BorderSide(width: 1,color: Colors.orange),
                                                // ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                            Radius.circular(0),
                                                          ),
                                                      borderSide: BorderSide(
                                                        width: 1,
                                                        color: Color.fromARGB(
                                                          255,
                                                          123,
                                                          138,
                                                          195,
                                                        ),
                                                      ),
                                                    ),

                                                contentPadding: EdgeInsets.all(
                                                  8,
                                                ),
                                                isDense:
                                                    true, //make textfield compact
                                              ),
                                            ),

                                            //Continue button
                                            SizedBox(
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  onContinueClick();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                        255,
                                                        123,
                                                        138,
                                                        195,
                                                      ),
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
                                                    horizontal: 12,
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
                                                      child:
                                                          CircularProgressIndicator(
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
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black,
                                                    ), // Adjust size
                                                  );
                                                }),
                                              ),
                                            ),

                                            SizedBox(height: 10),

                                            if (showCheckoutAddressWidget)
                                              CheckoutAddressWidget(
                                                _onGiftPackValueUpdate,
                                                _giftPackisChecked,
                                                _tncCheckedValueUpdate,
                                                _tncChecked,
                                                _nameController,
                                                _emailController,
                                                _areaController,
                                                _subAreaController,
                                                _deliveryAddressController,
                                                _zipcodeController,
                                                _cityController,
                                                _stateController,
                                                _alternatePhoneController,
                                                _notesController,
                                                onOrderPlaced,
                                              ),
                                          ],
                                        ],
                                      ],
                                    ],
                                  ],

                                  if (outSideIndia &&
                                      _selectedOptionCountry ==
                                          "Outside India") ...[
                                    //selected option is out side india
                                  ],

                                  SizedBox(height: 100),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return Center(child: Text("Empty"));
      }),
    );
  }
}
