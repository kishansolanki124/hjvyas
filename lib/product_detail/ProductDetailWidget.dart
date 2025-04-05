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
