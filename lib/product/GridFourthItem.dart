import 'package:flutter/material.dart';

import 'ProductListWidgets.dart';

class Gridfourthitem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  Gridfourthitem({
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.blueGrey,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(height: 85, child: Container(color: Colors.white)),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 100,
              left: 20.0,
              right: 20.0,
              bottom: 20,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromARGB(255, 123, 138, 195),
                width: 2,
              ),
              borderRadius: BorderRadius.all(Radius.circular(0)),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                // with Card
                elevation: 20.0,
                shape: const CircleBorder(),
                clipBehavior: Clip.antiAlias,
                // with Card
                child: Image.asset("images/circular_demo.png"),
              ), // Image.network(

              //   imageUrl,
              //   height: 250, // height: 100, // Adjust height as needed
              //   // width: 100,
              //   fit: BoxFit.fill,
              // ),
              productListTitleWidget(title),

              productListVariationWidget("₹ 900.00 - 300 grams"),

              productListLife("Product life: 300 days"),

              productListCalories("Calories: 470"),

              // Padding(
              //   padding: const EdgeInsets.fromLTRB(30.0, 0, 30, 20),
              //   child: Text(
              //     "Calories: 470",
              //     style: TextStyle(
              //       color: Color.fromARGB(255, 123, 138, 195),
              //       fontFamily: "Montserrat",
              //       fontSize: 11,
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
