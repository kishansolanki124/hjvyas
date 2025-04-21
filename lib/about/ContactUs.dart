import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../api/models/ContactusResponse.dart';
import '../api/services/HJVyasApiService.dart';
import '../injection_container.dart';
import '../repositories/HJVyasRepository.dart';

class ContactUs extends StatefulWidget {
  final HJVyasRepository _userRepo = HJVyasRepository(
    getIt<HJVyasApiService>(),
  );

  ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ContactusResponse>(
      future: widget._userRepo.getContactus(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return contactUsContentWidget(
            snapshot.data!.contactList.elementAt(0),
          );
          // return staticPageMainContent(
          //   _tabNames,
          //   _imagePaths,
          //   _imagePathsSelected,
          //   _selectedIndex,
          //   _changeIndex,
          //   snapshot.data!.staticpageList,
          // );
        } else if (snapshot.hasError) {
          if (snapshot.error.toString() == 'No internet connection') {
            //todo: change this to common error page retry page
            return Center(child: Text('Error: Internt issue vhala'));
          } else {
            //todo: change this to common error page
            return Center(child: Text('Error: ${snapshot.error}'));
          }
        }
        //todo: change this to common progress
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

Widget contactUsContentWidget(ContactListItem contactListItem) {
  // List<String> inquiryType = [
  //   'Inquiry type Inquiry type 1',
  //   'Inquiry type 2',
  //   'Inquiry type 3',
  // ];

  final List<String> imagePaths = [
    'icons/map_icon.png',
    'icons/whatsapp_icon.png',
    'icons/call_icon.png',
    'icons/e-mail_icon.png',
  ];

  // Function to launch URL
  Future<void> _launchURL(String url) async {
    await launchUrl(Uri.parse(contactListItem.googleMap));
  }

  void callIntent(String phonenumber) {
    launchUrlString("tel://$phonenumber");
  }

  void emailIntent(String email) {
    var url = Uri.parse("mailto:$email?subject=&body=");
    launchUrl(url);
  }

  // Function to launch WhatsApp
  Future<void> openWhatsApp(String phoneNumber) async {
    await launchUrl(Uri.parse("https://wa.me/$phoneNumber?text="));
  }

  void _onIconClick(int index, ContactListItem contactListItem) {
    if (index == 0) {
      //google map
      _launchURL(contactListItem.googleMap);
    } else if (index == 1) {
      //whatsapp
      openWhatsApp(contactListItem.whatsappNo);
    } else if (index == 2) {
      //call
      //todo: show 2 call intent options as 2 numbers are available
      callIntent(contactListItem.mobile1);
    } else if (index == 3) {
      //email
      emailIntent(contactListItem.email);
    }
  }

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
                                  children: List.generate(imagePaths.length, (
                                    index,
                                  ) {
                                    return _buildSelectItem(
                                      contactListItem,
                                      _tabNames,
                                      imagePaths,
                                      index,
                                      _onIconClick,
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
                            "Address :",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Montserrat",
                            ),
                          ),

                          Text(
                            contactListItem.address,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily: "Montserrat",
                            ),
                          ),

                          SizedBox(height: 10),

                          Text(
                            "Customer Care :",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Montserrat",
                            ),
                          ),

                          Text(
                            "${contactListItem.mobile1} / ${contactListItem.mobile2}\n(${contactListItem.timing})",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily: "Montserrat",
                            ),
                          ),

                          SizedBox(height: 10),

                          Text(
                            "Email :",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Montserrat",
                            ),
                          ),

                          Text(
                            contactListItem.email,
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
                  //send us an email
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                    child: Text(
                      "Send us an Email",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Montserrat",
                      ),
                    ),
                  ),

                  //dropdown of inquiry
                  inquiryDropdown(
                    contactListItem.inquiryType.split(', '),
                    contactListItem.inquiryType.split(', ').first,
                  ),

                  SizedBox(height: 20),

                  //edittext name
                  TextField(
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    // Capitalize each word
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Montserrat",
                      fontSize: 14,
                    ),
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

                  SizedBox(height: 20),

                  //edittext email
                  TextField(
                    keyboardType: TextInputType.emailAddress,
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

                  SizedBox(height: 20),

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
                      counterText: "",
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

                      contentPadding: EdgeInsets.all(8),
                      isDense: true, //make textfield compact
                    ),
                  ),

                  SizedBox(height: 20),

                  //city
                  TextField(
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

                  //message
                  TextField(
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

                  //send message button
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: () {
                        //  Add your notification logic here
                        if (kDebugMode) {
                          print("Notify Me button clicked");
                        }
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
                        "Send Message",
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

Widget _buildSelectItem(
  ContactListItem contactListItem,
  tabNames,
  imagePaths,
  int index,
  onIconClick,
) {
  return GestureDetector(
    child: Column(
      children: [
        SizedBox(
          width: 70,
          height: 70, // Fixed width for the square
          //height: 50,
          // Fixed height for the square
          child: Image.asset(
            width: 70,
            // Fixed width for the square
            height: 70,
            imagePaths[index],
            fit: BoxFit.fill, // Make the image fit within the square
            //),
          ),
        ),

        SizedBox(
          width: 70,
          child: Center(
            child: Text(
              tabNames[index],
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
    ),
    onTap: () {
      onIconClick(index, contactListItem);
    },
  );
}

Widget inquiryDropdown(List<String> contactUsDropdownList, selectedVariant) {
  return Container(
    width: double.infinity, // Full width
    //height: 40,
    // Fixed height
    decoration: BoxDecoration(
      border: Border.all(color: Color.fromARGB(255, 123, 138, 195)),
      borderRadius: BorderRadius.circular(0),
      color: Colors.transparent, // Background color
    ),
    padding: EdgeInsets.symmetric(horizontal: 6.0), // Add horizontal padding
    child: DropdownButtonFormField<String>(
      padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
      value: selectedVariant,
      icon: Image.asset(
        'icons/dropdown_icon.png', // Replace with your icon path
        width: 18, // Adjust width as needed
        height: 18, // Adjust height as needed
      ),
      onChanged: (newValue) {
        // setState(() {
        // _selectedVariant = newValue;
        // });
      },
      items:
          contactUsDropdownList.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
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
  );
}
