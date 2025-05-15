import 'package:flutter/material.dart';

import '../about/AboutWidgets.dart';
import '../utils/AppColors.dart';

class HomePopup2 extends StatelessWidget {
  final String imageUrl;
  final String text;
  final String title;
  final Function() onClose;

  const HomePopup2({
    super.key,
    required this.imageUrl,
    required this.text,
    required this.title,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.semiTransBlack,
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Stack(
        children: [
          // Close button
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: const Icon(color: Colors.white, Icons.close, size: 32),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          Stack(
            children: [
              // Content
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 50, 16, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Image (200 height, full width)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        imageUrl,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (_, __, ___) => Container(
                              color: Colors.grey[200],
                              height: 200,
                              child: const Icon(Icons.broken_image, size: 50),
                            ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Title (centered)
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // Scrollable text (minLines 10)
                    Container(
                      constraints: const BoxConstraints(minHeight: 200),
                      // minLines equivalent
                      child: SingleChildScrollView(
                        child: loadHTMLContent(text),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
