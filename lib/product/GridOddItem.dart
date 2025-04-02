import 'package:flutter/material.dart';

class GridOddItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  GridOddItem({
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 110.0),
            decoration: BoxDecoration(
              border: Border.all(color: Color.fromARGB(255, 123,138,195), width: 2),
              borderRadius: BorderRadius.all(Radius.circular(0)),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              // Image.network(
              //   imageUrl,
              //   height: 250, // height: 100, // Adjust height as needed
              //   // width: 100,
              //   fit: BoxFit.fill,
              // ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 0),
                child: Text(
                  title,
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 254),
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 5, 30, 0),
                child: Text(
                  "₹ 900.00 - 300 gram",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 254),
                    fontSize: 14,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 5, 30, 0),
                child: Text(
                  "Product life: 300 days",
                  style: TextStyle(
                    color: Color.fromARGB(255, 123,138,195),
                    fontSize: 12,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 0, 30, 10),
                child: Text(
                  "Calories: 470",
                  style: TextStyle(
                    color: Color.fromARGB(255, 123,138,195),
                    fontSize: 12,
                  ),
                ),
              ),
              Card(
                // with Card
                child: Image.asset("images/circular_demo.png"),
                elevation: 20.0,
                shape: const CircleBorder(),
                clipBehavior: Clip.antiAlias,
              ),

            ],
          ),
        ],
      ),
    );
  }
}