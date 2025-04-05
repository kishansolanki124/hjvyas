import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hjvyas/product_detail/ProductDetail.dart';

Widget productDetailViewpager(FoodProductDetailsPage widget, onPageChange) {
  return CarouselSlider(
    items:
        widget.imageUrls
            .map(
              (url) => Image.network(
                url, //fit: BoxFit.cover,
                fit: BoxFit.fill,
                width: double.infinity,
                height: 350,
                errorBuilder: (context, error, stackTrace) {
                  return SizedBox(
                    width: double.infinity,
                    height: 350,
                    child: Center(child: Text('Failed to load image')),
                  );
                },
              ),
            )
            .toList(),
    options: CarouselOptions(
      height: 350,
      viewportFraction: 1,

      //autoPlay: true,
      //enlargeCenterPage: true,
      //aspectRatio: 9 / 16,
      onPageChanged: (index, reason) {
        onPageChange(index);
        // setState(() {
        //   _currentImageIndex = index;
        // });
      },
    ),
  );
}

Widget productDetailCorosoulDots(
  FoodProductDetailsPage widget,
  int currentImageIndex,
) {
  return Padding(
    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 0, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children:
          widget.imageUrls.asMap().entries.map((entry) {
            return Container(
              width: currentImageIndex == entry.key ? 10.0 : 8.0,
              height: currentImageIndex == entry.key ? 10.0 : 8.0,
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 3.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    currentImageIndex == entry.key
                        ? Color.fromARGB(255, 230, 12, 11)
                        : Color.fromARGB(255, 179, 179, 179),
              ),
            );
          }).toList(),
    ),
  );
}

Widget productDetailNameAndPrice(FoodProductDetailsPage widget) {
  return Column(
    children: [
      SizedBox(height: 50),

      Text(
        widget.productName,
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
      SizedBox(height: 8),

      // 3. Product Price
      Text(
        widget.productPrice,
        style: TextStyle(
          fontSize: 18,
          fontFamily: "Montserrat",
          color: Colors.white,
        ),
      ),
      SizedBox(height: 16),
    ],
  );
}
