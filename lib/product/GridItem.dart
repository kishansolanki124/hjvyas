import 'package:flutter/material.dart';

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
      //color: Colors.blueGrey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Card( // with Card
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
            padding: const EdgeInsets.all(10.0),
            child: Text(
              title,
              style: TextStyle(color: Color.fromARGB(255, 255, 255, 254),fontSize: 18,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              description,
              style: TextStyle(
                color: Color.fromARGB(255, 2, 2, 2),
                  fontSize: 14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "Product life: 300 days",
              style: TextStyle(
                  color: Color.fromARGB(255, 138, 138, 138),
                  fontSize: 14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "Calories: 470",
              style: TextStyle(
                  color: Color.fromARGB(255, 138, 138, 138),
                  fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
