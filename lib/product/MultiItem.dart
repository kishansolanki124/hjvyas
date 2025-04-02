import 'package:flutter/material.dart';

import 'GridFourthItem.dart';
import 'GridItem.dart';
import 'GridOddItem.dart';
import 'GridThirdItem.dart';

class AppLogoNameGridView extends StatelessWidget {
  final List<Map<String, String>> gridItems;

  AppLogoNameGridView({
    required this.gridItems,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // App Logo
                  // App Name
                  Expanded(
                    child: Text(
                      textAlign: TextAlign.center,
                    "DryFruit kachori",
                    style: TextStyle(color: Colors.white,fontSize: 30, fontWeight: FontWeight.bold),
                  )),

                  Expanded(
                    child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      "images/logo.png",
                      height: 100, // Adjust logo height as needed
                    ),
                  ),
                  ),


                ],
              ),),

              // GridView
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                // Disable GridView scrolling
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: (1 / 2),
                ),
                itemCount: gridItems.length,
                itemBuilder: (context, index) {
                  if (index % 4 == 0) {
                    return GridOddItem(
                      imageUrl: gridItems[index]['imageUrl']!,
                      title: gridItems[index]['title']!,
                      description: gridItems[index]['title']!,
                    );
                  } else if (index % 4 == 1) {
                    return GridItem(
                      imageUrl: gridItems[index]['imageUrl']!,
                      title: gridItems[index]['title']!,
                      description: gridItems[index]['title']!,
                    );
                  } else if (index % 4 == 2) {
                    return Gridthirditem(
                      imageUrl: gridItems[index]['imageUrl']!,
                      title: gridItems[index]['title']!,
                      description: gridItems[index]['title']!,
                    );
                  } else {
                    return Gridfourthitem(
                      imageUrl: gridItems[index]['imageUrl']!,
                      title: gridItems[index]['title']!,
                      description: gridItems[index]['title']!,
                    );
                  }

                  // return Card(
                  //   child: Column(
                  //     children: <Widget>[
                  //       Expanded(
                  //         child: Image.network(
                  //           gridItems[index]['imageUrl']!,
                  //           fit: BoxFit.cover,
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Text(
                  //           gridItems[index]['title']!,
                  //           style: TextStyle(fontWeight: FontWeight.bold),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
