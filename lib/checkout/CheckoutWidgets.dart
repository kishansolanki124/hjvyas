import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../api/models/ShippingStatusResponse.dart';

Widget CartTotalRow(String title, String value, double bottomPadding) {
  return Padding(
    padding: EdgeInsets.only(bottom: bottomPadding, left: 10, right: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.0,
            fontFamily: "Montserrat",
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.0,
            fontFamily: "Montserrat",
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Widget radioTwoOption(
  ShippingStatusResponse? shippingStatusResponse,
  String option1,
  String option2,
  _onValueChanged,
  _selectedOption,
) {
  if (option1 == "India") {
    //country radio options
  } else if (option1 == "Gujarat") {
    //state radio options
  } else if (option1 == "Jamnagar") {
    //city radio
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    // Center the buttons horizontally
    children: <Widget>[
      Row(
        children: [
          Radio<String>(
            value: option1,
            groupValue: _selectedOption,
            onChanged: (value) {
              _onValueChanged(value);
            }, // Selected color
            fillColor: WidgetStateProperty.resolveWith<Color>((
              Set<WidgetState> states,
            ) {
              if (states.contains(WidgetState.selected)) {
                return Colors.white; // Selected color
              }
              return Colors.white; // Default color
            }),
          ),
          GestureDetector(
            onTap: () {
              _onValueChanged(option1); // Update selected option
            },
            child: Text(
              option1,
              style: TextStyle(
                fontSize: 14.0,
                fontFamily: "Montserrat",
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      Row(
        children: [
          Radio<String>(
            value: option2,
            groupValue: _selectedOption,
            onChanged: (value) {
              _onValueChanged(value);
            }, // Selected color
            fillColor: WidgetStateProperty.resolveWith<Color>((
              Set<WidgetState> states,
            ) {
              if (states.contains(WidgetState.selected)) {
                return Colors.white; // Selected color
              }
              return Colors.white; // Default color
            }),
          ),
          GestureDetector(
            onTap: () {
              _onValueChanged(option2); // Update selected option
            },
            child: Text(
              option2,
              style: TextStyle(
                fontSize: 14.0,
                fontFamily: "Montserrat",
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

Widget paymentOptions(
  ShippingStatusListItem shippingStatusListItem,
  selectedPaymentMethod,
  updatePaymentMethod,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      //Select Payment Option
      Text(
        "Select Payment Option",
        style: TextStyle(
          fontSize: 14.0,
          fontFamily: "Montserrat",
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),

      //icici payment
      if (shippingStatusListItem.razorpayGateway == "on") ...[
        Row(
          children: [
            Radio<String>(
              value: 'ICICI Bank Payment Gateway',
              groupValue: selectedPaymentMethod,
              onChanged: (value) {
                updatePaymentMethod(value);
              },
              // Selected color
              fillColor: WidgetStateProperty.resolveWith<Color>((
                Set<WidgetState> states,
              ) {
                if (states.contains(WidgetState.selected)) {
                  return Colors.white; // Selected color
                }
                return Colors.white; // Default color
              }),
            ),
            GestureDetector(
              onTap: () {
                updatePaymentMethod(
                  'ICICI Bank Payment Gateway',
                ); // Update selected option
              },
              child: Text(
                'ICICI Bank Payment Gateway',
                style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: "Montserrat",
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
          child: Text(
            "(Support Any Bank Debit Card, Credit Card, Master Card , Visa Card, Maestro Card, Net Banking, Wallet, UPI)",
            style: TextStyle(
              fontSize: 12.0,
              fontFamily: "Montserrat",
              color: Color.fromARGB(255, 123, 138, 195),
            ),
          ),
        ),
      ],

      //CCAVenue Payment
      if (shippingStatusListItem.ccavenueGateway == "on")
        Row(
          children: [
            Radio<String>(
              value: 'CCAvenue Payment Gateway',
              groupValue: selectedPaymentMethod,
              onChanged: (value) {
                updatePaymentMethod(value);
              },
              // Selected color
              fillColor: WidgetStateProperty.resolveWith<Color>((
                Set<WidgetState> states,
              ) {
                if (states.contains(WidgetState.selected)) {
                  return Colors.white; // Selected color
                }
                return Colors.white; // Default color
              }),
            ),
            GestureDetector(
              onTap: () {
                updatePaymentMethod(
                  'CCAvenue Payment Gateway',
                ); // Update selected option
              },
              child: Text(
                'CCAvenue Payment Gateway',
                style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: "Montserrat",
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),

      //PayPal Payment
      if (shippingStatusListItem.paypalGateway == "on")
        Row(
          children: [
            Radio<String>(
              value: "PayPal (Outside India Users)",
              groupValue: selectedPaymentMethod,
              onChanged: (value) {
                updatePaymentMethod(value);
              },
              // Selected color
              fillColor: WidgetStateProperty.resolveWith<Color>((
                Set<WidgetState> states,
              ) {
                if (states.contains(WidgetState.selected)) {
                  return Colors.white; // Selected color
                }
                return Colors.white; // Default color
              }),
            ),
            GestureDetector(
              onTap: () {
                updatePaymentMethod(
                  'PayPal (Outside India Users)',
                ); // Update selected option
              },
              child: Text(
                'PayPal (Outside India Users)',
                style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: "Montserrat",
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
    ],
  );
}

Widget CheckoutAddressWidget(
  _onGiftPackValueUpdate,
  _giftPacksChecked,
  _tncCheckedValueUpdate,
  _tncChecked,
  _nameController,
  _emailController,
  // _areaController,
  // _subAreaController,
  _deliveryAddressController,
  _zipcodeController,
  _cityController,
  _stateController,
  List<StateListItem> stateList,
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
  VoidCallback showTNC,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      //edittext name
      TextField(
        textInputAction: TextInputAction.next,
        controller: _nameController,
        keyboardType: TextInputType.name,
        textCapitalization: TextCapitalization.words,
        // Capitalize each word
        style: TextStyle(
          color: Colors.white,
          fontFamily: "Montserrat",
          fontSize: 14,
        ),
        decoration: InputDecoration(
          hintText: "Your Name",
          hintStyle: TextStyle(
            color: Colors.white,
            fontFamily: "Montserrat",
            fontSize: 14,
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(0)),
            borderSide: BorderSide(
              width: 1,
              color: Color.fromARGB(255, 123, 138, 195),
            ),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(0)),
            borderSide: BorderSide(
              width: 1,
              color: Color.fromARGB(255, 123, 138, 195),
            ),
          ),

          contentPadding: EdgeInsets.all(8),
          isDense: true, //make textfield compact
        ),
      ),

      SizedBox(height: 20),

      //edittext email
      TextField(
        textInputAction: TextInputAction.next,
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
          color: Colors.white,
          fontFamily: "Montserrat",
          fontSize: 14,
        ),
        // Set text color to white
        decoration: InputDecoration(
          hintText: "Your Email",
          hintStyle: TextStyle(
            color: Colors.white,
            fontFamily: "Montserrat",
            fontSize: 12,
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(0)),
            borderSide: BorderSide(
              width: 1,
              color: Color.fromARGB(255, 123, 138, 195),
            ),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(0)),
            borderSide: BorderSide(
              width: 1,
              color: Color.fromARGB(255, 123, 138, 195),
            ),
          ),

          contentPadding: EdgeInsets.all(8),
          isDense: true, //make textfield compact
        ),
      ),
      Text(
        "(no spam, you get an email for your order details)",
        style: TextStyle(
          fontSize: 12.0,
          fontFamily: "Montserrat",
          color: Color.fromARGB(255, 123, 138, 195),
        ),
      ),

      SizedBox(height: 20),

      // //area
      // TextField(
      //   controller: _areaController,
      //   keyboardType: TextInputType.streetAddress,
      //   textCapitalization: TextCapitalization.words,
      //   style: TextStyle(
      //     color: Colors.white,
      //     fontFamily: "Montserrat",
      //     fontSize: 14,
      //   ),
      //   decoration: InputDecoration(
      //     hintText: "Area",
      //     hintStyle: TextStyle(
      //       color: Colors.white,
      //       fontFamily: "Montserrat",
      //       fontSize: 14,
      //     ),
      //
      //     focusedBorder: OutlineInputBorder(
      //       borderRadius: BorderRadius.all(Radius.circular(0)),
      //       borderSide: BorderSide(
      //         width: 1,
      //         color: Color.fromARGB(255, 123, 138, 195),
      //       ),
      //     ),
      //     enabledBorder: OutlineInputBorder(
      //       borderRadius: BorderRadius.all(Radius.circular(0)),
      //       borderSide: BorderSide(
      //         width: 1,
      //         color: Color.fromARGB(255, 123, 138, 195),
      //       ),
      //     ),
      //     contentPadding: EdgeInsets.all(8),
      //     isDense: true, //make textfield compact
      //   ),
      // ),
      //
      // SizedBox(height: 20),

      // //sub area
      // TextField(
      //   controller: _subAreaController,
      //   keyboardType: TextInputType.streetAddress,
      //   textCapitalization: TextCapitalization.words,
      //   style: TextStyle(
      //     color: Colors.white,
      //     fontFamily: "Montserrat",
      //     fontSize: 14,
      //   ),
      //   decoration: InputDecoration(
      //     hintText: "Sub Area",
      //     hintStyle: TextStyle(
      //       color: Colors.white,
      //       fontFamily: "Montserrat",
      //       fontSize: 14,
      //     ),
      //
      //     focusedBorder: OutlineInputBorder(
      //       borderRadius: BorderRadius.all(Radius.circular(0)),
      //       borderSide: BorderSide(
      //         width: 1,
      //         color: Color.fromARGB(255, 123, 138, 195),
      //       ),
      //     ),
      //     enabledBorder: OutlineInputBorder(
      //       borderRadius: BorderRadius.all(Radius.circular(0)),
      //       borderSide: BorderSide(
      //         width: 1,
      //         color: Color.fromARGB(255, 123, 138, 195),
      //       ),
      //     ),
      //     contentPadding: EdgeInsets.all(8),
      //     isDense: true, //make textfield compact
      //   ),
      // ),
      //
      // SizedBox(height: 20),

      //Delivery Address: (Enter Full Address With Street, Road, Building Name,No etc)
      //Delivery Address
      TextField(
        textInputAction: TextInputAction.next,
        controller: _deliveryAddressController,
        keyboardType: TextInputType.multiline,
        // Use multiline input type
        maxLines: null,
        // Allow unlimited lines
        minLines: 4,
        // Start with a minimum of 4 lines
        style: TextStyle(
          color: Colors.white,
          fontFamily: "Montserrat",
          fontSize: 14,
        ),
        // Set text color to white
        decoration: InputDecoration(
          hintText: "Delivery Address",
          hintStyle: TextStyle(
            color: Colors.white,
            fontFamily: "Montserrat",
            fontSize: 14,
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(0)),
            borderSide: BorderSide(
              width: 1,
              color: Color.fromARGB(255, 123, 138, 195),
            ),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(0)),
            borderSide: BorderSide(
              width: 1,
              color: Color.fromARGB(255, 123, 138, 195),
            ),
          ),

          contentPadding: EdgeInsets.all(8),
          isDense: true, //make textfield compact
        ),
      ),
      Text(
        "(Enter Full Address With Street, Road, Building Name, No etc)",
        style: TextStyle(
          fontSize: 12.0,
          fontFamily: "Montserrat",
          color: Color.fromARGB(255, 123, 138, 195),
        ),
      ),

      SizedBox(height: 20),

      //Zip Code
      TextField(
        textInputAction: TextInputAction.done,
        controller: _zipcodeController,
        keyboardType: TextInputType.text,
        maxLength: 10,
        // inputFormatters: <TextInputFormatter>[
        //   FilteringTextInputFormatter.,
        // ],
        style: TextStyle(
          color: Colors.white,
          fontFamily: "Montserrat",
          fontSize: 14,
        ),
        decoration: InputDecoration(
          hintText: "Zip Code",
          hintStyle: TextStyle(
            color: Colors.white,
            fontFamily: "Montserrat",
            fontSize: 14,
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(0)),
            borderSide: BorderSide(
              width: 1,
              color: Color.fromARGB(255, 123, 138, 195),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(0)),
            borderSide: BorderSide(
              width: 1,
              color: Color.fromARGB(255, 123, 138, 195),
            ),
          ),
          contentPadding: EdgeInsets.all(8),
          isDense: true, //make textfield compact
        ),
      ),

      //City
      if (_selectedOptionCountry != "India" ||
          _selectedOptionState != "Gujarat" ||
          _selectedOptionCity != "Jamnagar") ...[
        TextField(
          textInputAction: TextInputAction.next,
          controller: _cityController,
          keyboardType: TextInputType.streetAddress,
          textCapitalization: TextCapitalization.words,
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Montserrat",
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: "City",
            hintStyle: TextStyle(
              color: Colors.white,
              fontFamily: "Montserrat",
              fontSize: 14,
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(0)),
              borderSide: BorderSide(
                width: 1,
                color: Color.fromARGB(255, 123, 138, 195),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(0)),
              borderSide: BorderSide(
                width: 1,
                color: Color.fromARGB(255, 123, 138, 195),
              ),
            ),
            contentPadding: EdgeInsets.all(8),
            isDense: true, //make textfield compact
          ),
        ),

        SizedBox(height: 20),
      ],

      if (_selectedOptionState == "Outside Gujarat" &&
          _selectedOptionCountry == "India") ...[
        //State
        Container(
          width: double.infinity,
          // Full width
          //height: 40,
          // Fixed height
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromARGB(255, 123, 138, 195)),
            borderRadius: BorderRadius.circular(0),
            color: Colors.transparent, // Background color
          ),
          padding: EdgeInsets.symmetric(horizontal: 6.0),
          // Add horizontal padding
          child: DropdownButtonFormField<StateListItem>(
            padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
            value: stateList.elementAt(0),
            icon: Image.asset(
              'icons/dropdown_icon.png', // Replace with your icon path
              width: 18, // Adjust width as needed
              height: 18, // Adjust height as needed
            ),
            onChanged: (newValue) {
              selectedVariantInquiry(newValue);
            },
            items:
                stateList.map((StateListItem item) {
                  return DropdownMenuItem<StateListItem>(
                    value: item,
                    child: Text(
                      item.stateName,
                      style: TextStyle(
                        backgroundColor: Color.fromARGB(255, 31, 47, 80),
                        fontSize: 14,
                        color: Colors.white,
                        fontFamily: "Montserrat",
                        //fontWeight: FontWeight.w700,
                      ),
                    ),
                  );
                }).toList(),
            decoration: InputDecoration(
              border: InputBorder.none, // Remove default border
              isDense: true, // Make it compact
              contentPadding: EdgeInsets.zero,
              // suffixIcon: Image.asset(
              //   width: 12,
              //   height: 12,
              //   'icons/dropdown_icon.png',
              // ),
            ),
            dropdownColor: Color.fromARGB(255, 31, 47, 80),
            //underline: SizedBox(),
          ),
        ),

        SizedBox(height: 20),
      ],

      //state input field for out side india
      if (_selectedOptionCountry != "India") ...[
        TextField(
          textInputAction: TextInputAction.next,
          controller: _stateController,
          keyboardType: TextInputType.streetAddress,
          textCapitalization: TextCapitalization.words,
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Montserrat",
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: "State",
            hintStyle: TextStyle(
              color: Colors.white,
              fontFamily: "Montserrat",
              fontSize: 14,
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(0)),
              borderSide: BorderSide(
                width: 1,
                color: Color.fromARGB(255, 123, 138, 195),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(0)),
              borderSide: BorderSide(
                width: 1,
                color: Color.fromARGB(255, 123, 138, 195),
              ),
            ),
            contentPadding: EdgeInsets.all(8),
            isDense: true, //make textfield compact
          ),
        ),
        SizedBox(height: 20),
      ],

      //Alternate Mobile no.
      TextField(
        textInputAction: TextInputAction.next,
        controller: _alternatePhoneController,
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
          hintText: "Alternate Mobile No.",
          hintStyle: TextStyle(
            color: Colors.white,
            fontFamily: "Montserrat",
            fontSize: 14,
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(0)),
            borderSide: BorderSide(
              width: 1,
              color: Color.fromARGB(255, 123, 138, 195),
            ),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(0)),
            borderSide: BorderSide(
              width: 1,
              color: Color.fromARGB(255, 123, 138, 195),
            ),
          ),

          contentPadding: EdgeInsets.all(8),
          isDense: true, //make textfield compact
        ),
      ),

      //Notes if any
      TextField(
        textInputAction: TextInputAction.done,
        controller: _notesController,
        keyboardType: TextInputType.multiline,
        // Use multiline input type
        maxLines: null,
        // Allow unlimited lines
        minLines: 4,
        // Start with a minimum of 4 lines
        style: TextStyle(
          color: Colors.white,
          fontFamily: "Montserrat",
          fontSize: 14,
        ),
        // Set text color to white
        decoration: InputDecoration(
          hintText: "Notes if any",
          hintStyle: TextStyle(
            color: Colors.white,
            fontFamily: "Montserrat",
            fontSize: 14,
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(0)),
            borderSide: BorderSide(
              width: 1,
              color: Color.fromARGB(255, 123, 138, 195),
            ),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(0)),
            borderSide: BorderSide(
              width: 1,
              color: Color.fromARGB(255, 123, 138, 195),
            ),
          ),

          contentPadding: EdgeInsets.all(8),
          isDense: true, //make textfield compact
        ),
      ),

      SizedBox(height: 10),
      //gift pack Checkbox
      Row(
        children: [
          Checkbox(
            value: _giftPacksChecked,
            onChanged: (newValue) {
              _onGiftPackValueUpdate(newValue!);
            },
            visualDensity: VisualDensity.compact,
            //remove padding
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            //remove padding
            checkColor: Color.fromARGB(255, 123, 138, 195),
            // Color of the tick
            fillColor: WidgetStatePropertyAll(Colors.white),
          ),

          GestureDetector(
            onTap: () {
              _giftPacksChecked = !_giftPacksChecked;
              _onGiftPackValueUpdate(_giftPacksChecked);
            },
            child: Text(
              "If It\'s Gift Please Mark the Check box",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Montserrat",
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),

      if (_giftPacksChecked) ...[
        SizedBox(height: 20),

        //gift sender name
        TextField(
          controller: _giftSenderNameController,
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.words,
          // Capitalize each word
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Montserrat",
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: "Gift Sender Name",
            hintStyle: TextStyle(
              color: Colors.white,
              fontFamily: "Montserrat",
              fontSize: 14,
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(0)),
              borderSide: BorderSide(
                width: 1,
                color: Color.fromARGB(255, 123, 138, 195),
              ),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(0)),
              borderSide: BorderSide(
                width: 1,
                color: Color.fromARGB(255, 123, 138, 195),
              ),
            ),

            contentPadding: EdgeInsets.all(8),
            isDense: true, //make textfield compact
          ),
        ),

        SizedBox(height: 20), //gift sender mobile number
        TextField(
          controller: _giftSenderMobileController,
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
            hintText: "Gift Sender Mobile No",
            hintStyle: TextStyle(
              color: Colors.white,
              fontFamily: "Montserrat",
              fontSize: 14,
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(0)),
              borderSide: BorderSide(
                width: 1,
                color: Color.fromARGB(255, 123, 138, 195),
              ),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(0)),
              borderSide: BorderSide(
                width: 1,
                color: Color.fromARGB(255, 123, 138, 195),
              ),
            ),

            contentPadding: EdgeInsets.all(8),
            isDense: true, //make textfield compact
          ),
        ),

        SizedBox(height: 10),

        //gift receiver name
        TextField(
          controller: _giftReceiverNameController,
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.words,
          // Capitalize each word
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Montserrat",
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: "Gift Receiver Name",
            hintStyle: TextStyle(
              color: Colors.white,
              fontFamily: "Montserrat",
              fontSize: 14,
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(0)),
              borderSide: BorderSide(
                width: 1,
                color: Color.fromARGB(255, 123, 138, 195),
              ),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(0)),
              borderSide: BorderSide(
                width: 1,
                color: Color.fromARGB(255, 123, 138, 195),
              ),
            ),

            contentPadding: EdgeInsets.all(8),
            isDense: true, //make textfield compact
          ),
        ),

        SizedBox(height: 20),

        //gift receiver mobile number
        TextField(
          controller: _giftReceiverMobileController,
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
            hintText: "Gift Receiver Mobile No",
            hintStyle: TextStyle(
              color: Colors.white,
              fontFamily: "Montserrat",
              fontSize: 14,
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(0)),
              borderSide: BorderSide(
                width: 1,
                color: Color.fromARGB(255, 123, 138, 195),
              ),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(0)),
              borderSide: BorderSide(
                width: 1,
                color: Color.fromARGB(255, 123, 138, 195),
              ),
            ),

            contentPadding: EdgeInsets.all(8),
            isDense: true, //make textfield compact
          ),
        ),
      ],

      SizedBox(height: 10),
      //TNC Checkbox
      Row(
        children: [
          Checkbox(
            value: _tncChecked,
            onChanged: (newValue) {
              _tncCheckedValueUpdate(newValue!);
            },
            visualDensity: VisualDensity.compact,
            //remove padding
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            //remove padding
            checkColor: Color.fromARGB(255, 123, 138, 195),
            // Color of the tick
            fillColor: WidgetStatePropertyAll(Colors.white),
          ),

          GestureDetector(
            onTap: () {
              _tncChecked = !_tncChecked;
              _tncCheckedValueUpdate(_tncChecked);
            },
            child: Text(
              'I Agree : ',
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Montserrat",
                fontSize: 12,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              showTNC.call();
            },
            child: Text(
              '(Terms & Conditions)',
              style: TextStyle(
                decoration: TextDecoration.underline,
                decorationColor: Color.fromARGB(255, 123, 138, 195),
                color: Color.fromARGB(255, 123, 138, 195),
                fontFamily: "Montserrat",
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),

      SizedBox(height: 20),
    ],
  );
}
