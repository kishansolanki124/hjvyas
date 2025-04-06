import 'package:flutter/material.dart';

import '../product_detail/ProductDetail.dart';
import 'GridFourthItem.dart';
import 'GridItem.dart';
import 'GridOddItem.dart';
import 'GridThirdItem.dart';

class AppLogoNameGridView extends StatelessWidget {
  final List<Map<String, String>> gridItems;

  AppLogoNameGridView({required this.gridItems});

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
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // App Logo
                    // App Name
                    Expanded(
                      child: Text(
                        textAlign: TextAlign.center,
                        "DryFruit Kachori",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: "Archistico",
                        ),
                      ),
                    ),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset(
                          "images/logo.png",
                          height: 80, // Adjust logo height as needed
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // GridView
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                // Disable GridView scrolling
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: (1 / 1.8),
                ),
                itemCount: gridItems.length,
                itemBuilder: (context, index) {
                  Widget lloadWidget;

                  if (index % 4 == 0) {
                    lloadWidget = GridOddItem(
                      imageUrl: gridItems[index]['imageUrl']!,
                      title: gridItems[index]['title']!,
                      price: gridItems[index]['price']!,
                      productLife: gridItems[index]['calories']!,
                      calories: gridItems[index]['productLife']!,
                    );
                  } else if (index % 4 == 1) {
                    lloadWidget = GridItem(
                      imageUrl: gridItems[index]['imageUrl']!,
                      title: gridItems[index]['title']!,
                      price: gridItems[index]['price']!,
                      productLife: gridItems[index]['calories']!,
                      calories: gridItems[index]['productLife']!,                    );
                  } else if (index % 4 == 2) {
                    lloadWidget = Gridthirditem(
                      imageUrl: gridItems[index]['imageUrl']!,
                      title: gridItems[index]['title']!,
                      description: gridItems[index]['title']!,
                    );
                  } else {
                    lloadWidget = Gridfourthitem(
                      imageUrl: gridItems[index]['imageUrl']!,
                      title: gridItems[index]['title']!,
                      description: gridItems[index]['title']!,
                    );
                  }


                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => //ProductDetail(item: item),
                                  ProductDetail(),
                        ),
                      );
                    },
                    child: lloadWidget,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
