import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hjvyas/checkout/CheckoutWidgets.dart';

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

  Checkout({super.key, required this.total});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final TextEditingController _phoneController = TextEditingController();

  String? _selectedOptionCountry = "";
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

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Contact number is required';
    }
    if (value.length != 10) {
      return 'Contact number must be 10 digits';
    }
    return null;
  }

  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> getShippingCharge() async {
    //todo: uncomment below API call and show shipping charges accordingly
    //await widget.paginationController.getShippingCharge(2);
    _showCheckoutAddressWidget();
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

  void _tncCheckedValueUpdate(bool newValue) {
    setState(() {
      _tncChecked = newValue;
    });
  }

  void _onValueChangedCountry(String value) {
    setState(() {
      _selectedOptionCountry = value;
    });
  }

  void _onValueChangedCity(String value) {
    setState(() {
      _selectedOptionCity = value;
    });
  }

  void _onValueChangedState(String value) {
    setState(() {
      _selectedOptionState = value;
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
                                  CartTotalRow("Shipping Charge", "Rs. 00", 10),

                                  //grant Total
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
                                        "Grant Total",
                                        "₹ ${widget.total}",
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
                                              "Khali Jamnagar whala " +
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
                                                      ), // Sky color
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
