import 'package:flutter/material.dart';
import 'package:hjvyas/product_detail/ImageWithProgress.dart';

Widget productListTitleWidget(String title, [Color? color, double? topMargin]) {
  color ??= Colors.white;
  topMargin ??= 10.0;

  return Padding(
    padding: EdgeInsets.fromLTRB(30.0, topMargin, 20, 0),
    child: Text(
      '$title\n',
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: TextStyle(
        height: 1.2,
        color: color,
        //color: Color.fromARGB(255, 255, 255, 254),
        fontSize: 16,
        fontFamily: "Montserrat",
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

Widget productListVariationWidget(
  String price,
  String productWeight, [
  Color? color,
]) {
  color ??= Colors.white;

  return Padding(
    padding: const EdgeInsets.fromLTRB(30.0, 5, 30, 0),
    child: Text(
      "₹ $price - $productWeight",
      style: TextStyle(
        color: color,
        fontSize: 12,
        fontFamily: "Montserrat",
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

Widget productListLife(String life, [Color? color]) {
  color ??= Color.fromARGB(255, 123, 138, 195);

  return Padding(
    padding: const EdgeInsets.fromLTRB(30.0, 5, 30, 0),
    child: Text(
      "Product Life : $life",
      style: TextStyle(color: color, fontSize: 11, fontFamily: "Montserrat"),
    ),
  );
}

Widget productListCalories(String calories, [Color? color]) {
  color ??= Color.fromARGB(255, 123, 138, 195);

  return Padding(
    padding: const EdgeInsets.fromLTRB(30.0, 0, 30, 10),
    child: Text(
      "Calories : $calories",
      style: TextStyle(color: color, fontFamily: "Montserrat", fontSize: 11),
    ),
  );
}

Widget productComboSpecification(String calories, [Color? color]) {
  color ??= Color.fromARGB(255, 123, 138, 195);

  return Padding(
    padding: const EdgeInsets.fromLTRB(30.0, 0, 30, 10),
    child: Text(
        calories,
      style: TextStyle(color: color, fontFamily: "Montserrat", fontSize: 11),
    ),
  );
}

Widget productListImage(String url, [Color? color]) {
  //color ??= Color.fromARGB(255, 123, 138, 195);
  color ??= Colors.transparent;

  // return Card(
  //   // with Card
  //   elevation: 5.0,
  //   shape: const CircleBorder(),
  //   clipBehavior: Clip.antiAlias,
  //   // with Card
  //   child: Center(
  //     child: Container(
  //       width: 180,
  //       height: 180,
  //       // decoration: BoxDecoration(
  //       //   color: Colors.red,
  //       //   border: Border.all(color: color, width: 2.0),
  //       //   shape: BoxShape.circle,
  //       //   //color: Colors.blue,
  //       //   // image: DecorationImage(image:
  //       //   // NetworkImage(url))
  //       //   // image: DecorationImage(
  //       //   //   image: AssetImage("images/circular_demo.png"),
  //       //   //   fit: BoxFit.cover,
  //       //   // ),
  //       // ),
  //       child: ImageWithProgress(imageURL: url,boxFit: BoxFit.fill,),
  //     ),
  //   ),
  // );

  if (color == Colors.transparent) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black.withAlpha(20),
              spreadRadius: 2,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: SizedBox(
          width: 190,
          height: 190,
          child: ImageWithProgress(
            imageURL: url, // Replace with your image URL
          ),
        ),
      ),
    );
  } else {
    return Center(
      child: Container(
        width: 180,
        height: 180,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: color, width: 1.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(25),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ClipOval(child: ImageWithProgress(imageURL: url)),
      ),
    );
  }

  // return Card(
  //   // with Card
  //   elevation: 5.0,
  //   shape: const CircleBorder(),
  //   clipBehavior: Clip.antiAlias,
  //   // with Card
  //   child: Image.asset("images/circular_demo.png"),
  // );
}

Widget productListWhiteBg(AlignmentGeometry alignment, [double? bgHeight]) {
  bgHeight ??= 110;
  return Align(
    alignment: alignment,
    //child: SizedBox(height: bgHeight, child: Container(color: Colors.white)),
    child: SizedBox(height: bgHeight, child: Container(color: Colors.transparent)),
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

Widget productDetailCenterImageRound(String imageUrl,[bool? isCombo]) {
  isCombo ??= false;

  if(isCombo) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 500, 0, 0),
      child: Align(
          child: SizedBox(width: 150, height: 150, child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.transparent, width: 1.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(25),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ClipOval(child: ImageWithProgress(imageURL: imageUrl)),
      ),
      ),
    )
    );
  }

  return Padding(
    padding: EdgeInsetsDirectional.fromSTEB(0, 500, 0, 0),
    child: Align(
      child: SizedBox(width: 150, height: 150, child: productListImage(imageUrl)),
    ),
  );
}

Widget soldOutText() {
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.fromLTRB(32, 16, 16, 16),
        child: Container(
          color: Color.fromARGB(255, 123, 138, 195),
          child: Padding(
            padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
            child: Text(
              "Sold Out",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
