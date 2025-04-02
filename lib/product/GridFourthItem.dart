import 'package:flutter/material.dart';

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
          Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.redAccent, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(0)),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Card(
                // with Card
                child: Image.asset("images/circular_demo.png"),
                elevation: 10.0,
                shape: const CircleBorder(),
                clipBehavior: Clip.antiAlias,
              ),

              // Image.network(
              //   imageUrl,
              //   height: 250, // height: 100, // Adjust height as needed
              //   // width: 100,
              //   fit: BoxFit.fill,
              // ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 0, 30, 0),
                child: Text(
                  title,
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 254),
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 0, 30, 0),
                child: Text(
                  description,
                  style: TextStyle(
                    color: Color.fromARGB(255, 2, 2, 2),
                    fontSize: 14,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 0, 30, 0),
                child: Text(
                  "Product life: 300 days",
                  style: TextStyle(
                    color: Color.fromARGB(255, 138, 138, 138),
                    fontSize: 14,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 0, 30, 0),
                child: Text(
                  "Calories: 470",
                  style: TextStyle(
                    color: Color.fromARGB(255, 138, 138, 138),
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
