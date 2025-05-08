import 'package:flutter/material.dart';
import 'package:hjvyas/product_detail/ImageWithProgress.dart';

class ImageWithTextPopup extends StatelessWidget {
  final String imageUrl;
  final String text;
  final TextStyle? textStyle;
  final VoidCallback? onClose; // Add an optional onClose callback

  const ImageWithTextPopup({
    super.key,
    required this.imageUrl,
    required this.text,
    this.textStyle,
    this.onClose, // Make onClose optional
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          // 1. Background Image
          Positioned.fill(child: ImageWithProgress(imageURL: imageUrl)),
          // 2. Popup-like Container with Text
          Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final screenWidth = MediaQuery.of(context).size.width;
                final screenHeight = MediaQuery.of(context).size.height;

                return Container(
                  width: screenWidth,
                  height: screenHeight,
                  color: Colors.transparent,
                  child: Stack(
                    // Use a Stack to position the close button
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          width: screenWidth * 0.5,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              text,
                              style:
                                  textStyle ??
                                  const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ),
                      // 3. Close Button
                      Positioned(
                        top: 10, // Position from the top
                        right: 10, // Position from the right
                        child: GestureDetector(
                          onTap: () {
                            // Use the provided onClose callback, or just pop the route.
                            if (onClose != null) {
                              onClose!(); // Call the custom callback if provided
                            } else {
                              Navigator.of(
                                context,
                              ).pop(); // Default close behavior
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            // Add padding around the icon
                            decoration: BoxDecoration(
                              //shape: BoxShape.circle, // Make it a circle
                              color: Colors.black.withOpacity(0.5),
                              // Optional: Background for better visibility
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed:
                                  () => Navigator.pop(context, {
                                    'status': 'cancelled',
                                  }),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      home: ImageWithTextPopup(
        imageUrl:
            'https://www.mithaiwalahjvyas.com/uploads/app_popup_img/1-2-1-1-diwali-01.jpg',
        text:
            'This is the text description, positioned on the right side.  A close icon is in the top right.',
        textStyle: TextStyle(fontSize: 18, color: Colors.white),
      ),
    ),
  );
}
