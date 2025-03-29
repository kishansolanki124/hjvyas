import 'package:flutter/material.dart';

Widget homeImageItem(String url) {
  return Image.network(
    url,
    fit: BoxFit.cover,
    height: double.infinity,
    width: double.infinity,
    alignment: Alignment.center,
  );
}
