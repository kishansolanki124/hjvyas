import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget AboutUsContentWidget() {
  return Expanded(
    child: Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Change to .stretch
          children: <Widget>[
            SizedBox(height: 10),
            Expanded(
              // Added Expanded here
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 75),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromARGB(255, 123, 138, 195),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            "We Serve The Best Quality Food",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            textAlign: TextAlign.justify,
                            "Discover the Ultimate Sweet Experience with H.J. Vyas Mithaiwala.\n\nPicture yourself savoring the most exquisite sweets, no matter where your adventures take you. From bustling cities to quiet countryside re-treats, whether you're in Tokyo, Sydney, Rio deJaneiro, Cape Town, or Toronto, you can now relish the premium sweets from the 'City of Sweets', Jamnagar, Gujarat, India. It sounds too good to be true, doesn't it?\n\nSince 1908, H.J. Vyas Mithaiwala has been synon-ymous with exceptional quality in sweet manu-facturing. Our commitment to our customers'health and satisfaction ensures that every product meets the highest standards of purity and taste. If you ever have concerns about your order's taste, quality, or quantity, we back our products with a money-back guarantee.\n\nWe are dedicated to maintaining the integrity and excellence of our sweets. With a legacy spanning 116 years, we continue to strengthen our bond with our customers by delivering unparalleled quality. Whether you choose to in",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Wrap(
          children: [
            Center(
              child: Container(
                color: Color.fromARGB(255, 31, 47, 80),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    "About Us",
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
  );
}

Widget ContactUsContentWidget() {
  List<String> inquiryType = [
    'Inquiry type 1',
    'Inquiry type 2',
    'Inquiry type 3',
  ];

  // -1 indicates no item is selected
  final List<String> _imagePaths = [
    'icons/about_us_icon.png',
    'icons/contact_us_icon.png',
    'icons/refund_icon.png',
    'icons/privecy_policy_icon.png',
    'icons/term_icon.png',
  ];

  // -1 indicates no item is selected
  final List<String> _tabNames = [
    'About Us',
    'Contact Us',
    'Refund Policy',
    'Privacy Policy',
    'Terms',
  ];

  return Expanded(
    child: SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //contact us upper half portion
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Contact Us"),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // Distribute items evenly
                    children: List.generate(_imagePaths.length, (index) {
                      return _buildSelectItem(_tabNames, _imagePaths, index);
                    }),
                  ),

                  Text("Get in Touch"),

                  Text("Address:"),

                  Text("Address line 1\nAddress line 2\nAddress line 3"),

                  Text("Customer Care:"),

                  Text("Customer Care line 1\nCustomer Care line 2"),

                  Text("Email:"),

                  Text("email@gmail.com"),
                ],
              ),

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
        width: 50,
        height: 50,
        // Fixed width for the square
        //height: 50,
        // Fixed height for the square
        decoration: BoxDecoration(
          color: Color.fromARGB(180, 255, 255, 255), // Change background color
          border: Border.all(
            color: Color.fromARGB(180, 255, 255, 255),
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0), // Padding inside the container
          child: Image.asset(
            width: 50,
            // Fixed width for the square
            height: 50,
            _imagePaths[index],
            fit: BoxFit.contain, // Make the image fit within the square
          ),
        ),
      ),

      SizedBox(
        width: 50,
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
