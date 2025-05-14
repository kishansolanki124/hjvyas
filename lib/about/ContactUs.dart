import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hjvyas/splash/NoIntternetScreen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../api/models/ContactusResponse.dart';
import '../menu/CategoryController.dart';
import '../utils/AppColors.dart';
import '../utils/CommonAppProgress.dart';
import '../utils/NetworkImageWithProgress.dart';

class ContactUs extends StatefulWidget {
  final CategoryController categoryController;

  const ContactUs({super.key, required this.categoryController});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  Future<void> fetchData() async {
    await widget.categoryController.getContactus();
  }

  void _refreshData() {
    fetchData();
  }

  @override
  void initState() {
    super.initState();
    widget.categoryController.getContactus(); // Explicit call
  }

  // Controllers for the TextField values
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  String? _selectedVariantInquiry = null;

  final List<String> imagePaths = [
    'icons/map_icon.png',
    'icons/whatsapp_icon.png',
    'icons/call_icon.png',
    'icons/e-mail_icon.png',
  ];

  // Function to launch URL
  Future<void> _launchURL(String url) async {
    await launchUrl(Uri.parse(url));
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
      showTwoPhoneCallOptionDialog(
        contactListItem.mobile1,
        contactListItem.mobile2,
      );
      //callIntent(contactListItem.mobile1);
    } else if (index == 3) {
      //email
      emailIntent(contactListItem.email);
    }
  }

  final List<String> _tabNames = ['Google Map', 'WhatsApp', 'Call', 'E-Mail'];

  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void onSubmitClick() {
    if (_validateName(_nameController.text) != null) {
      showSnackbar(context, _validateName(_nameController.text).toString());
    } else if (_validateEmail(_emailController.text) != null) {
      showSnackbar(context, _validateEmail(_emailController.text).toString());
    } else if (_validatePhone(_phoneController.text) != null) {
      showSnackbar(context, _validatePhone(_phoneController.text).toString());
    } else if (_validateCity(_cityController.text) != null) {
      showSnackbar(context, _validateCity(_cityController.text).toString());
    } else if (_validateMessage(_messageController.text) != null) {
      showSnackbar(
        context,
        _validateMessage(_messageController.text).toString(),
      );
    } else {
      newFunction();
    }
  }

  void showTwoPhoneCallOptionDialog(String phoneNumber1, String phoneNumber2) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Call Number'),
          content: const Text('Choose a number to call:'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                callIntent(phoneNumber1); // Call the first number
              },
              child: Text(
                phoneNumber1,
                style: TextStyle(
                  color: AppColors.background,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Montserrat",
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                callIntent(phoneNumber2); // Call the second number
              },
              child: Text(
                phoneNumber2,
                style: TextStyle(
                  color: AppColors.background,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Montserrat",
                ),
              ),
            ),
          ],
        );
      },
    );
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

  String? _validateCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'City Is Required.';
    }
    if (value.length < 2) {
      return 'City Name Is Too Short.';
    }
    return null;
  }

  String? _validateMessage(String? value) {
    if (value == null || value.isEmpty) {
      return 'Message Is Required.';
    }
    if (value.length < 3) {
      return 'Message Must Be At Least 3 Characters Long.';
    }
    return null;
  }

  void selectedVariantInquiry(String text) {
    if (kDebugMode) {
      print('selectedVariantInquiry is changed');
    }

    setState(() {
      _selectedVariantInquiry = text;
      if (kDebugMode) {
        print('_selectedVariantInquiry is $_selectedVariantInquiry');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (widget.categoryController.isLoading.value) {
        return getCommonProgressBar();
      }

      if (widget.categoryController.error.isNotEmpty) {
        return NoInternetScreen(
          showBackgroundImage: false,
          onRetry: () {
            _refreshData();
          },
        );
      }

      final cateogories = widget.categoryController.contactItem.elementAt(0);
      _selectedVariantInquiry ??= cateogories.inquiryType.split(', ').first;

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
                            color: AppColors.secondary,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      // Distribute items evenly
                                      children: List.generate(
                                        imagePaths.length,
                                        (index) {
                                          return _buildSelectItem(
                                            cateogories,
                                            _tabNames,
                                            imagePaths,
                                            index,
                                            _onIconClick,
                                          );
                                        },
                                      ),
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
                                cateogories.address,
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

                              GestureDetector(
                                onTap: () {
                                  showTwoPhoneCallOptionDialog(
                                    cateogories.mobile1,
                                    cateogories.mobile2,
                                  );
                                },
                                child: Text(
                                  "${cateogories.mobile1} / ${cateogories.mobile2}\n(${cateogories.timing})",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontFamily: "Montserrat",
                                  ),
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
                                cateogories.email,
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
                              color: AppColors.background,
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
                          color: Colors.transparent, // Background color
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 6.0),
                        // Add horizontal padding
                        child: DropdownButtonFormField<String>(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                          value: cateogories.inquiryType.split(', ').first,
                          icon: Image.asset(
                            'icons/dropdown_icon.png', // Replace with your icon path
                            width: 18, // Adjust width as needed
                            height: 18, // Adjust height as needed
                          ),
                          onChanged: (newValue) {
                            // setState(() {
                            selectedVariantInquiry(newValue!);
                            //selectedVariantInquiry = newValue;
                            if (kDebugMode) {
                              print(
                                'selectedVariantInquiry $selectedVariantInquiry',
                              );
                            }
                            // });
                          },
                          items:
                              cateogories.inquiryType.split(', ').map((
                                String item,
                              ) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                      backgroundColor: AppColors.background,
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
                          dropdownColor: AppColors.background,
                          //underline: SizedBox(),
                        ),
                      ), // inquiryDropdown(
                      //   contactListItem.inquiryType.split(', '),
                      //   contactListItem.inquiryType.split(', ').first,
                      //   selectedVariantInquiry,
                      // ),
                      SizedBox(height: 20),

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
                              color: AppColors.secondary,
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
                              color: AppColors.secondary,
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
                              color: AppColors.secondary,
                            ),
                          ),

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                            borderSide: BorderSide(
                              width: 1,
                              color: AppColors.secondary,
                            ),
                          ),

                          contentPadding: EdgeInsets.all(8),
                          isDense: true, //make textfield compact
                        ),
                      ),

                      SizedBox(height: 20),

                      //contact no
                      TextField(
                        textInputAction: TextInputAction.next,
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
                              color: AppColors.secondary,
                            ),
                          ),

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                            borderSide: BorderSide(
                              width: 1,
                              color: AppColors.secondary,
                            ),
                          ),

                          contentPadding: EdgeInsets.all(8),
                          isDense: true, //make textfield compact
                        ),
                      ),

                      SizedBox(height: 20),

                      //city
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
                              color: AppColors.secondary,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                            borderSide: BorderSide(
                              width: 1,
                              color: AppColors.secondary,
                            ),
                          ),
                          contentPadding: EdgeInsets.all(8),
                          isDense: true, //make textfield compact
                        ),
                      ),

                      SizedBox(height: 20),

                      //message
                      TextField(
                        textInputAction: TextInputAction.done,
                        controller: _messageController,
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
                              color: AppColors.secondary,
                            ),
                          ),

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                            borderSide: BorderSide(
                              width: 1,
                              color: AppColors.secondary,
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
                              onSubmitClick();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secondary,
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
                          child: Obx(() {
                            if (widget
                                .categoryController
                                .adInquiryLoading
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
                              "Send Message",
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

                      SizedBox(height: 100),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  void newFunction() async {
    // Show loading on button
    widget.categoryController.adInquiryLoading.value = true;

    try {
      // Call API
      await widget.categoryController.addInquiry(
        _selectedVariantInquiry!,
        _nameController.text,
        _phoneController.text,
        _emailController.text,
        _cityController.text,
        _messageController.text,
      );

      // Check if widget is still mounted before showing dialog
      if (mounted) {
        _nameController.text = "";
        _emailController.text = "";
        _phoneController.text = "";
        _cityController.text = "";
        _messageController.text = "";

        showAlertWithCallback(
          context: context,
          title: 'Success',
          message: widget.categoryController.addInquiryResponse.value!.message,
          onOkPressed: () {
            // Optional callback after dialog dismissal
            if (kDebugMode) {
              print('User acknowledged success');
            }
          },
        );
      }
    } finally {
      // Hide loading regardless of success/failure
      if (mounted) {
        widget.categoryController.adInquiryLoading.value = false;
      }
    }
  }
}

Widget contactUsWidget(ContactListItem? contactListItem) {
  if (kDebugMode) {
    print('contactListItem $contactListItem');
  }
  return Text("Hello ererr");
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
            width: 60,
            // Fixed width for the square
            height: 60,
            imagePaths[index],
            fit: BoxFit.cover, // Make the image fit within the square
            //),
          ),
        ),

        SizedBox(
          width: 70,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Text(
                tabNames[index],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11.0,
                  fontFamily: "Montserrat",
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
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
