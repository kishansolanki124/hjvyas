import 'package:flutter/material.dart';

Widget AboutUsContentWidget() {
  return Expanded(
    child: Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Change to .stretch
          children: <Widget>[
            SizedBox(height: 10),
            Expanded(
              // Added Expanded here
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 75),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromARGB(255, 123, 138, 195),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            "We Serve The Best Quality Food",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            textAlign: TextAlign.justify,
                            "Discover the Ultimate Sweet Experience with H.J. Vyas Mithaiwala.\n\nPicture yourself savoring the most exquisite sweets, no matter where your adventures take you. From bustling cities to quiet countryside re-treats, whether you're in Tokyo, Sydney, Rio deJaneiro, Cape Town, or Toronto, you can now relish the premium sweets from the 'City of Sweets', Jamnagar, Gujarat, India. It sounds too good to be true, doesn't it?\n\nSince 1908, H.J. Vyas Mithaiwala has been synon-ymous with exceptional quality in sweet manu-facturing. Our commitment to our customers'health and satisfaction ensures that every product meets the highest standards of purity and taste. If you ever have concerns about your order's taste, quality, or quantity, we back our products with a money-back guarantee.\n\nWe are dedicated to maintaining the integrity and excellence of our sweets. With a legacy spanning 116 years, we continue to strengthen our bond with our customers by delivering unparalleled quality. Whether you choose to in",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Wrap(
          children: [
            Center(
              child: Container(
                color: Color.fromARGB(255, 31, 47, 80),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    "About Us",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
