import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget ContactUsContentWidget() {
  List<String> inquiryType = [
    'Inquiry type 1',
    'Inquiry type 2',
    'Inquiry type 3',
  ];

  final List<String> _imagePaths = [
    'icons/map_icon.png',
    'icons/whatsapp_icon.png',
    'icons/call_icon.png',
    'icons/e-mail_icon.png',
  ];

  final List<String> _tabNames = ['Google Map', 'WhatsApp', 'Call', 'E-Mail'];

  return Expanded(
    child: SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              //contact us upper half portion
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 123, 138, 195),
                      ),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8, 30, 8, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //contact us 4 icons top horizontal
                          Wrap(
                            children: [
                              Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  // Distribute items evenly
                                  children: List.generate(_imagePaths.length, (
                                    index,
                                  ) {
                                    return _buildSelectItem(
                                      _tabNames,
                                      _imagePaths,
                                      index,
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 20),

                          Text(
                            "Get in Touch",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Montserrat",
                            ),
                          ),

                          SizedBox(height: 10),

                          Text(
                            "Address:",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Montserrat",
                            ),
                          ),

                          Text(
                            "Address line 1\nAddress line 2\nAddress line 3",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily: "Montserrat",
                            ),
                          ),

                          SizedBox(height: 10),

                          Text(
                            "Customer Care:",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Montserrat",
                            ),
                          ),

                          Text(
                            "Customer Care line 1\nCustomer Care line 2",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily: "Montserrat",
                            ),
                          ),

                          SizedBox(height: 10),

                          Text(
                            "Email:",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Montserrat",
                            ),
                          ),

                          Text(
                            "email@gmail.com",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily: "Montserrat",
                            ),
                          ),

                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),

                  Wrap(
                    children: [
                      Center(
                        child: Container(
                          color: Color.fromARGB(255, 31, 47, 80),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              "Contact Us",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              //contact us bottom half portion
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Send us an Email"),

                  //dropdown of inquiry
                  productDetailDropDown(inquiryType, inquiryType.first),

                  //edittext name
                  TextField(
                    keyboardType: TextInputType.name,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.singleLineFormatter,
                    ],
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Montserrat",
                      fontSize: 14,
                    ),
                    // Set text color to white
                    decoration: InputDecoration(
                      hintText: "Name",
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
                      // disabledBorder: OutlineInputBorder(
                      //   borderRadius: BorderRadius.all(Radius.circular(4)),
                      //   borderSide: BorderSide(width: 1,color: Colors.orange),
                      // ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                        borderSide: BorderSide(
                          width: 1,
                          color: Color.fromARGB(255, 123, 138, 195),
                        ),
                      ),

                      // border: OutlineInputBorder(
                      //     borderRadius: BorderRadius.all(Radius.circular(4)),
                      //     borderSide: BorderSide(width: 1,)
                      // ),
                      // errorBorder: OutlineInputBorder(
                      //     borderRadius: BorderRadius.all(Radius.circular(4)),
                      //     borderSide: BorderSide(width: 1,color: Colors.black)
                      // ),
                      // focusedErrorBorder: OutlineInputBorder(
                      //     borderRadius: BorderRadius.all(Radius.circular(4)),
                      //     borderSide: BorderSide(width: 1,color: Colors.yellowAccent)
                      // ),
                      contentPadding: EdgeInsets.all(8),
                      isDense: true, //make textfield compact
                    ),
                  ),

                  //edittext email
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    //maxLength: 10,
                    // inputFormatters: <TextInputFormatter>[
                    //   FilteringTextInputFormatter.digitsOnly,
                    // ],
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Montserrat",
                      fontSize: 14,
                    ),
                    // Set text color to white
                    decoration: InputDecoration(
                      hintText: "E-mail",
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
                      // disabledBorder: OutlineInputBorder(
                      //   borderRadius: BorderRadius.all(Radius.circular(4)),
                      //   borderSide: BorderSide(width: 1,color: Colors.orange),
                      // ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                        borderSide: BorderSide(
                          width: 1,
                          color: Color.fromARGB(255, 123, 138, 195),
                        ),
                      ),

                      // border: OutlineInputBorder(
                      //     borderRadius: BorderRadius.all(Radius.circular(4)),
                      //     borderSide: BorderSide(width: 1,)
                      // ),
                      // errorBorder: OutlineInputBorder(
                      //     borderRadius: BorderRadius.all(Radius.circular(4)),
                      //     borderSide: BorderSide(width: 1,color: Colors.black)
                      // ),
                      // focusedErrorBorder: OutlineInputBorder(
                      //     borderRadius: BorderRadius.all(Radius.circular(4)),
                      //     borderSide: BorderSide(width: 1,color: Colors.yellowAccent)
                      // ),
                      contentPadding: EdgeInsets.all(8),
                      isDense: true, //make textfield compact
                    ),
                  ),

                  //contact no
                  TextField(
                    keyboardType: TextInputType.number,
                    maxLength: 10,
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
                      hintText: "Contact No.",
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
                      // disabledBorder: OutlineInputBorder(
                      //   borderRadius: BorderRadius.all(Radius.circular(4)),
                      //   borderSide: BorderSide(width: 1,color: Colors.orange),
                      // ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                        borderSide: BorderSide(
                          width: 1,
                          color: Color.fromARGB(255, 123, 138, 195),
                        ),
                      ),

                      // border: OutlineInputBorder(
                      //     borderRadius: BorderRadius.all(Radius.circular(4)),
                      //     borderSide: BorderSide(width: 1,)
                      // ),
                      // errorBorder: OutlineInputBorder(
                      //     borderRadius: BorderRadius.all(Radius.circular(4)),
                      //     borderSide: BorderSide(width: 1,color: Colors.black)
                      // ),
                      // focusedErrorBorder: OutlineInputBorder(
                      //     borderRadius: BorderRadius.all(Radius.circular(4)),
                      //     borderSide: BorderSide(width: 1,color: Colors.yellowAccent)
                      // ),
                      contentPadding: EdgeInsets.all(8),
                      isDense: true, //make textfield compact
                    ),
                  ),

                  //city
                  TextField(
                    keyboardType: TextInputType.streetAddress,
                    //maxLength: 10,
                    // inputFormatters: <TextInputFormatter>[
                    //   FilteringTextInputFormatter.digitsOnly,
                    // ],
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Montserrat",
                      fontSize: 14,
                    ),
                    // Set text color to white
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
                      // disabledBorder: OutlineInputBorder(
                      //   borderRadius: BorderRadius.all(Radius.circular(4)),
                      //   borderSide: BorderSide(width: 1,color: Colors.orange),
                      // ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                        borderSide: BorderSide(
                          width: 1,
                          color: Color.fromARGB(255, 123, 138, 195),
                        ),
                      ),

                      // border: OutlineInputBorder(
                      //     borderRadius: BorderRadius.all(Radius.circular(4)),
                      //     borderSide: BorderSide(width: 1,)
                      // ),
                      // errorBorder: OutlineInputBorder(
                      //     borderRadius: BorderRadius.all(Radius.circular(4)),
                      //     borderSide: BorderSide(width: 1,color: Colors.black)
                      // ),
                      // focusedErrorBorder: OutlineInputBorder(
                      //     borderRadius: BorderRadius.all(Radius.circular(4)),
                      //     borderSide: BorderSide(width: 1,color: Colors.yellowAccent)
                      // ),
                      contentPadding: EdgeInsets.all(8),
                      isDense: true, //make textfield compact
                    ),
                  ),

                  //message
                  TextField(
                    keyboardType: TextInputType.text,
                    // maxLength: 10,
                    // inputFormatters: <TextInputFormatter>[
                    //   FilteringTextInputFormatter.digitsOnly,
                    // ],
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Montserrat",
                      fontSize: 14,
                    ),
                    // Set text color to white
                    decoration: InputDecoration(
                      hintText: "Message",
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
                      // disabledBorder: OutlineInputBorder(
                      //   borderRadius: BorderRadius.all(Radius.circular(4)),
                      //   borderSide: BorderSide(width: 1,color: Colors.orange),
                      // ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                        borderSide: BorderSide(
                          width: 1,
                          color: Color.fromARGB(255, 123, 138, 195),
                        ),
                      ),

                      // border: OutlineInputBorder(
                      //     borderRadius: BorderRadius.all(Radius.circular(4)),
                      //     borderSide: BorderSide(width: 1,)
                      // ),
                      // errorBorder: OutlineInputBorder(
                      //     borderRadius: BorderRadius.all(Radius.circular(4)),
                      //     borderSide: BorderSide(width: 1,color: Colors.black)
                      // ),
                      // focusedErrorBorder: OutlineInputBorder(
                      //     borderRadius: BorderRadius.all(Radius.circular(4)),
                      //     borderSide: BorderSide(width: 1,color: Colors.yellowAccent)
                      // ),
                      contentPadding: EdgeInsets.all(8),
                      isDense: true, //make textfield compact
                    ),
                  ),

                  //send message button
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: () {
                        //  Add your notification logic here
                        print("Notify Me button clicked");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 123, 138, 195),
                        // Sky color
                        //foregroundColor: Colors.black,
                        // Black text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero, // Square corners
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 12,
                        ), // Add some vertical padding
                      ),
                      child: Text(
                        "Notify Me",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ), // Adjust size
                      ),
                    ),
                  ),

                  SizedBox(height: 100),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildSelectItem(_tabNames, _imagePaths, int index) {
  return Column(
    children: [
      Container(
        width: 70,
        height: 70, // Fixed width for the square
        //height: 50,
        // Fixed height for the square
        child: Image.asset(
          width: 70,
          // Fixed width for the square
          height: 70,
          _imagePaths[index],
          fit: BoxFit.fill, // Make the image fit within the square
          //),
        ),
      ),

      SizedBox(
        width: 70,
        child: Center(
          child: Text(
            _tabNames[index],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.0,
              fontFamily: "Montserrat",
              color: Colors.white,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget productDetailDropDown(
  List<String> contactUsDropdownList,
  _selectedVariant,
) {
  return Container(
    height: 35,
    decoration: BoxDecoration(
      border: Border.all(color: Color.fromARGB(255, 123, 138, 195)),
      borderRadius: BorderRadius.circular(0),
      color: Colors.transparent, // Background color
    ),
    padding: EdgeInsets.symmetric(horizontal: 6.0),
    // Add some padding inside the border
    child: DropdownButton<String>(
      icon: Image.asset(
        'icons/dropdown_icon.png', // Replace with your icon path
        width: 12, // Adjust width as needed
        height: 12, // Adjust height as needed
      ),
      // Custom icon
      value: _selectedVariant,
      hint: Text(
        'Select Color',
        style: TextStyle(
          backgroundColor: Color.fromARGB(255, 31, 47, 80),
          fontSize: 12,
          color: Colors.white,
          fontFamily: "Montserrat",
          //fontWeight: FontWeight.w700,
        ),
      ),
      underline: SizedBox(),
      dropdownColor: Color.fromARGB(255, 31, 47, 80),
      // This line hides the bottom line
      items:
          contactUsDropdownList.map((String variation) {
            return DropdownMenuItem<String>(
              value: variation,
              child: Text(
                variation,
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
      onChanged: (String? newValue) {
        //todo here
        // setState(() {
        //   _selectedVariant = newValue;
        // });
        //onChangedDropDownValue(newValue);
      },
    ),
  );
}
