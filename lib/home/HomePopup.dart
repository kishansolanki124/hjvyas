import 'package:flutter/material.dart';

import '../about/AboutWidgets.dart';
import '../product_detail/ImageWithProgress.dart';
import '../utils/AppColors.dart';

class HomePopup extends StatelessWidget {
  final String imageUrl;
  final String text;
  final String title;
  final Function() onClose;

  const HomePopup({
    super.key,
    required this.imageUrl,
    required this.text,
    required this.title,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SizedBox(
          height: 300,
          child: Stack(
            children: [
              Center(
                child: SizedBox(
                  height: 310,
                  child: GestureDetector(
                    onTap: onClose,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Stack(
                        children: <Widget>[
                          // 1. Background Image
                          Center(
                            child: SizedBox(
                              height: 300,
                              child: ImageWithProgress(imageURL: imageUrl),
                            ),
                          ),
                          // 2. Popup-like Container with Text
                          Align(
                            alignment: Alignment.centerRight,
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                final screenWidth =
                                    MediaQuery.of(context).size.width;
                                //final screenHeight = MediaQuery.of(context).size.height;

                                return SizedBox(
                                  width: screenWidth * 0.45,
                                  height: 300,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      // Use a Stack to position the close button
                                      children: [
                                        Text(
                                          title,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                          ),
                                        ),

                                        //text
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: SizedBox(
                                            //width: screenWidth * 0.5,
                                            child: loadHTMLContentPopup(text),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Close button
              Positioned(
                top: 16,
                right: 5,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero, // Remove default padding
                    iconSize: 18,
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                      onClose;
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
