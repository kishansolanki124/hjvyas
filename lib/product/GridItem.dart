import 'package:flutter/material.dart';

import 'ProductListWidgets.dart';

class GridItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  GridItem({
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          // White color box at the bottom
          Align(
            alignment: Alignment.bottomCenter,
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
                child: Image.asset("images/circular_demo.png"),
                elevation: 20.0,
                shape: const CircleBorder(),
                clipBehavior: Clip.antiAlias,
              ),

              // Image.network(
              //   imageUrl,
              //   height: 250, // height: 100, // Adjust height as needed
              //   // width: 100,
              //   fit: BoxFit.fill,
              // ),
              productListTitleWidget(title),

              productListVariationWidget(
                "₹ 900.00 - 300 grams",
                Color.fromARGB(255, 1, 1, 1),
              ),

              productListLife("Product life: 300 days",
                  Color.fromARGB(255, 139, 139, 139)),

              productListCalories("Calories: 470",
                  Color.fromARGB(255, 139, 139, 139)),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(30.0, 0, 30, 20),
              //   child: Text(
              //     "Calories: 470",
              //     style: TextStyle(
              //       color: Color.fromARGB(255, 139, 139, 139),
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

    // return Container(
    //   //color: Colors.blueGrey,
    //   child: Stack(
    //     children: [
    //       Container(
    //         margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
    //         decoration: BoxDecoration(
    //           border: Border.all(color: Colors.cyan, width: 2),
    //           borderRadius: BorderRadius.all(Radius.circular(0)),
    //         ),
    //       ),
    //
    //       Column(
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: <Widget>[
    //           Card(
    //             // with Card
    //             child: Image.asset("images/circular_demo.png"),
    //             elevation: 20.0,
    //             shape: const CircleBorder(),
    //             clipBehavior: Clip.antiAlias,
    //           ),
    //
    //           // Image.network(
    //           //   imageUrl,
    //           //   height: 250, // height: 100, // Adjust height as needed
    //           //   // width: 100,
    //           //   fit: BoxFit.fill,
    //           // ),
    //           Padding(
    //             padding: const EdgeInsets.fromLTRB(30.0, 0, 30, 0),
    //             child: Text(
    //               title,
    //               style: TextStyle(
    //                 color: Color.fromARGB(255, 255, 255, 254),
    //                 fontSize: 18,
    //               ),
    //             ),
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.fromLTRB(30.0, 0, 30, 0),
    //             child: Text(
    //               description,
    //               style: TextStyle(
    //                 color: Color.fromARGB(255, 2, 2, 2),
    //                 fontSize: 14,
    //               ),
    //             ),
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.fromLTRB(30.0, 0, 30, 0),
    //             child: Text(
    //               "Product life: 300 days",
    //               style: TextStyle(
    //                 color: Color.fromARGB(255, 138, 138, 138),
    //                 fontSize: 14,
    //               ),
    //             ),
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.fromLTRB(30.0, 0, 30, 0),
    //             child: Text(
    //               "Calories: 470",
    //               style: TextStyle(
    //                 color: Color.fromARGB(255, 138, 138, 138),
    //                 fontSize: 14,
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }
}
