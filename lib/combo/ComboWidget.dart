import 'package:flutter/material.dart';

import 'ComboFirstItem.dart';
import 'ComboFourthItem.dart';
import 'ComboSecondItem.dart';
import 'ComboThirdItem.dart';

class Combowidget extends StatelessWidget {
  final List<Map<String, String>> gridItems;

  Combowidget({required this.gridItems});

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
                        "Combo",
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
                  if (index % 4 == 0) {
                    return ComboFirstItem(
                      imageUrl: gridItems[index]['imageUrl']!,
                      title: gridItems[index]['title']!,
                      price: gridItems[index]['price']!,
                      productLife: gridItems[index]['productLife']!,
                      calories: gridItems[index]['calories']!,
                    );
                  } else if (index % 4 == 1) {
                    return ComboSecondItem(
                      imageUrl: gridItems[index]['imageUrl']!,
                      title: gridItems[index]['title']!,
                      price: gridItems[index]['price']!,
                      productLife: gridItems[index]['productLife']!,
                      calories: gridItems[index]['calories']!,
                    );
                  } else if (index % 4 == 2) {
                    return ComboThirdItem(
                      imageUrl: gridItems[index]['imageUrl']!,
                      title: gridItems[index]['title']!,
                      price: gridItems[index]['price']!,
                      productLife: gridItems[index]['productLife']!,
                      calories: gridItems[index]['calories']!,
                    );
                  } else {
                    return ComboFourthItem(
                      imageUrl: gridItems[index]['imageUrl']!,
                      title: gridItems[index]['title']!,
                      price: gridItems[index]['price']!,
                      productLife: gridItems[index]['productLife']!,
                      calories: gridItems[index]['calories']!,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
