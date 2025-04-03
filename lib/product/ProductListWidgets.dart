import 'package:flutter/material.dart';

Widget productListTitleWidget(String title, [Color? color]) {
  color ??= Colors.white;

  return Padding(
    padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 0),
    child: Text(
      '$title\n',
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: TextStyle(
        color: color,
        //color: Color.fromARGB(255, 255, 255, 254),
        fontSize: 18,
        fontFamily: "Montserrat",
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

Widget productListVariationWidget(String title, [Color? color]) {
  color ??= Colors.white;

  return Padding(
    padding: const EdgeInsets.fromLTRB(30.0, 5, 30, 0),
    child: Text(
      title,
      style: TextStyle(
        color: color,
        fontSize: 12,
        fontFamily: "Montserrat",
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget productListLife(String title, [Color? color]) {
  color ??= Color.fromARGB(255, 123, 138, 195);

  return Padding(
    padding: const EdgeInsets.fromLTRB(30.0, 5, 30, 0),
    child: Text(
      title,
      style: TextStyle(color: color, fontSize: 11, fontFamily: "Montserrat"),
    ),
  );
}

Widget productListCalories(String text, [Color? color]) {
  color ??= Color.fromARGB(255, 123, 138, 195);

  return Padding(
    padding: const EdgeInsets.fromLTRB(30.0, 0, 30, 10),
    child: Text(
      text,
      style: TextStyle(color: color, fontFamily: "Montserrat", fontSize: 11),
    ),
  );
}

Widget productListImage(String url) {
  return Card(
    // with Card
    elevation: 20.0,
    shape: const CircleBorder(),
    clipBehavior: Clip.antiAlias,
    // with Card
    child: Image.asset("images/circular_demo.png"),
  );
}

Widget productListWhiteBg(AlignmentGeometry alignment) {
  return Align(
    alignment: alignment,
    child: SizedBox(height: 90, child: Container(color: Colors.white)),
  );
}

Widget productListColoredBorderBox(double marginTop, double marginBottom) {
  return Container(
    margin: EdgeInsets.only(
      left: 20.0,
      right: 20.0,
      bottom: marginBottom,
      top: marginTop,
    ),
    decoration: BoxDecoration(
      border: Border.all(color: Color.fromARGB(255, 123, 138, 195), width: 2),
      borderRadius: BorderRadius.all(Radius.circular(0)),
    ),
  );
}
