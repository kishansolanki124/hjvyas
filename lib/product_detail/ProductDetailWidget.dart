import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hjvyas/product_detail/ProductDetail.dart';

import 'NetworkImageWithLoading.dart';

Widget backButton(_onBackPressed) {
  return TextButton.icon(
    onPressed: _onBackPressed,
    icon: Image.asset(
      "icons/back_icon.png",
      width: 22, // Adjust size as needed
      height: 22,
    ),
    label: Text(
      "Back",
      style: TextStyle(
        fontSize: 14,
        fontFamily: "Montserrat",
        color: Colors.white, // Inherit text color
      ),
    ),
    style: TextButton.styleFrom(
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ), // Optional rounded border
    ),
  );
}

Widget productDetailViewpager(FoodProductDetailsPage widget, onPageChange) {
  return CarouselSlider(
    items:
        widget.imageUrls
            .map(
              (url) => networkImageWithLoader(url),

            )
            .toList(),
    options: CarouselOptions(
      height: 350,
      viewportFraction: 1,

      //autoPlay: true,
      //enlargeCenterPage: true,
      //aspectRatio: 9 / 16,
      onPageChanged: (index, reason) {
        onPageChange(index);
        // setState(() {
        //   _currentImageIndex = index;
        // });
      },
    ),
  );
}

Widget productDetailCorosoulDots(
  FoodProductDetailsPage widget,
  int currentImageIndex,
) {
  return Padding(
    padding: EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children:
          widget.imageUrls.asMap().entries.map((entry) {
            return Container(
              width: currentImageIndex == entry.key ? 10.0 : 8.0,
              height: currentImageIndex == entry.key ? 10.0 : 8.0,
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 3.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    currentImageIndex == entry.key
                        ? Color.fromARGB(255, 230, 12, 11)
                        : Color.fromARGB(255, 179, 179, 179),
              ),
            );
          }).toList(),
    ),
  );
}

Widget productDetailNameAndPrice(FoodProductDetailsPage widget) {
  return Column(
    children: [
      SizedBox(height: 50),

      //product name
      Container(
        color: Color.fromARGB(255, 31, 47, 80),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
          child: Text(
            widget.productName,
            style: TextStyle(
              backgroundColor: Color.fromARGB(255, 31, 47, 80),
              fontSize: 16,
              color: Colors.white,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),

      SizedBox(height: 8),

      // 3. Product Price
      if (widget.productPrice.isNotEmpty)
        Text(
          //widget.productPrice,
          "₹ 3000.00 (1 KG)",
          style: TextStyle(
            fontSize: 16,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),

      // out of stock
      if (widget.productPrice.isEmpty) outOfStockDetail(),

      SizedBox(height: 16),
    ],
  );
}

Widget productDetailDropDown(
  FoodProductDetailsPage widget,
  _selectedVariant,
  onChangedDropDownValue,
) {
  return Container(
    height: 35,
    decoration: BoxDecoration(
      border: Border.all(color: Color.fromARGB(255, 123, 138, 195)),
      borderRadius: BorderRadius.circular(0),
      color: Colors.transparent, // Background color
    ),
    padding: EdgeInsets.symmetric(horizontal: 6.0),
    // Add some padding inside the border
    child: DropdownButton<String>(
      icon: Image.asset(
        'icons/dropdown_icon.png', // Replace with your icon path
        width: 12, // Adjust width as needed
        height: 12, // Adjust height as needed
      ),
      // Custom icon
      value: _selectedVariant,
      hint: Text(
        'Select Color',
        style: TextStyle(
          backgroundColor: Color.fromARGB(255, 31, 47, 80),
          fontSize: 12,
          color: Colors.white,
          fontFamily: "Montserrat",
          //fontWeight: FontWeight.w700,
        ),
      ),
      underline: SizedBox(),
      dropdownColor: Color.fromARGB(255, 31, 47, 80),
      // This line hides the bottom line
      items:
          widget.availableColors.map((String variation) {
            return DropdownMenuItem<String>(
              value: variation,
              child: Text(
                variation,
                style: TextStyle(
                  backgroundColor: Color.fromARGB(255, 31, 47, 80),
                  fontSize: 14,
                  color: Colors.white,
                  fontFamily: "Montserrat",
                  //fontWeight: FontWeight.w700,
                ),
              ),
            );
          }).toList(),
      onChanged: (String? newValue) {
        // setState(() {
        //   _selectedVariant = newValue;
        // });
        onChangedDropDownValue(newValue);
      },
    ),
  );
}

Widget productDetailItemCounter(
  FoodProductDetailsPage widget,
  _decrementQuantity,
  _incrementQuantity,
  _quantity,
) {
  return Container(
    height: 35,
    decoration: BoxDecoration(
      border: Border.all(color: Color.fromARGB(255, 123, 138, 195)),
      borderRadius: BorderRadius.circular(0),
      color: Colors.transparent, // Background color
    ),
    // Add some padding inside the border
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
          child: IconButton(
            iconSize: 15,
            color: Colors.white,
            icon: Icon(Icons.remove),
            onPressed: _decrementQuantity,
          ),
        ),
        Text(
          '$_quantity',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontFamily: "Montserrat",
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          child: IconButton(
            iconSize: 15,
            color: Colors.white,
            icon: Icon(Icons.add),
            onPressed: _incrementQuantity,
          ),
        ),
      ],
    ),
  );
}

Widget productDetailIngredients(FoodProductDetailsPage widget) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          'Ingredients :',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      SizedBox(height: 8),
      SizedBox(
        height: 120, // Adjust height as needed
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          itemCount: widget.ingredientImageUrls.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 123, 138, 195),
                      ),
                    ),
                    child: Image.network(
                      widget.ingredientImageUrls[index],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(child: Text('Err'));
                      },
                    ),
                  ),

                  Container(
                    width: 80,
                    child: Center(
                      child: Text(
                        "Black Currant",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: "Montserrat",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      SizedBox(height: 16),
    ],
  );
}

Widget productDetailYouMayLike(FoodProductDetailsPage widget) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          'You May Also Like :',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      SizedBox(height: 8),
      SizedBox(
        height: 120, // Adjust height as needed
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          itemCount: widget.youMayLikeProducts.length,
          itemBuilder: (context, index) {
            final product = widget.youMayLikeProducts[index];
            return Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Container(
                width: 120,
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 123, 138, 195)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (product['imageUrl'] != null)
                      Image.network(
                        product['imageUrl']!,
                        height: 85,
                        width: 110,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return SizedBox(
                            height: 60,
                            child: Center(child: Text('Err')),
                          );
                        },
                      ),
                    SizedBox(height: 8),
                    Text(
                      product['name'] ?? 'Product',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Montserrat",
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
}

Widget productDetailTabs(_tabController, activeTabIndex) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: TabBar(
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: Colors.transparent,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      indicator: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color.fromARGB(255, 123, 138, 195),
            width: 6.0,
          ),
          left: BorderSide(
            color: Color.fromARGB(255, 123, 138, 195),
            width: 1.0,
          ),
          right: BorderSide(
            color: Color.fromARGB(255, 123, 138, 195),
            width: 1.0,
          ),
        ),
      ),
      labelColor: Colors.white,
      //indicatorPadding: const EdgeInsets.all(0),
      indicatorPadding: const EdgeInsets.fromLTRB(0, 0, 0, 2),
      labelPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      unselectedLabelColor: Colors.white,
      controller: _tabController,
      tabs: [
        //Tab(text: 'Description',),
        Tab(
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color:
                      activeTabIndex == 0
                          ? Colors.transparent
                          : Color.fromARGB(255, 123, 138, 195),
                  width: 1.0,
                ),
              ),
            ),
            child: const Align(
              alignment: Alignment.center,
              child: Text("Description",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w700,
                ),),
            ),
          ),
        ),

        Tab(
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color:
                      activeTabIndex == 1
                          ? Colors.transparent
                          : Color.fromARGB(255, 123, 138, 195),
                  width: 1.0,
                ),
              ),
            ),
            child: const Align(
              alignment: Alignment.center,
              child: Text("Nutrition Value",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w700,
              ),),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget networkImageWithLoader(String url) {
  return NetworkImageWithLoading(imageUrl: url);
}

Widget outOfStockDetail() {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
      children: <Widget>[
        // 1. "We're Sorry!" text in bold
        Text(
          "We're Sorry!",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0, // Adjust size as needed
            fontWeight: FontWeight.w500,
            fontFamily: "Montserrat",
          ),
        ),

        SizedBox(height: 8.0), // Add some vertical spacing
        // 2. "This item has sold out" text in normal font
        Text(
          "This Item Has Sold Out. We Will Get Back Soon With This Product.",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.0, // Adjust size as needed
            fontFamily: "Montserrat",
          ),
        ),

        SizedBox(height: 16.0),

        // 3. "Notify Me !" Text with leading email icon
        Row(
          children: [
            Image.asset(width: 24, height: 24, "icons/notify_me_icon.png"),
            // Use the email icon
            SizedBox(width: 8.0),

            Text(
              "Notify Me !",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0, // Adjust size as needed
                fontWeight: FontWeight.w500,
                fontFamily: "Montserrat",
              ),
            ),
          ],
        ),

        SizedBox(height: 8.0),

        // 4. Text "Notify me when Product is Available"
        Text(
          "Notify Me When Product Is Available.",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.0, // Adjust size as needed
            fontFamily: "Montserrat",
          ),
        ),

        SizedBox(height: 8.0),

        // 5. Input text or Edit text with hint "Enter your mobile no."
        // with 10 digit max length and input type should be only numbers
        TextField(
          keyboardType: TextInputType.number,
          maxLength: 10,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Montserrat",
            fontSize: 14,
          ),
          // Set text color to white
          decoration: InputDecoration(
            hintText: "Enter Your Mobile No.",
            hintStyle: TextStyle(
              color: Colors.white,
              fontFamily: "Montserrat",
              fontSize: 14,
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(0)),
              borderSide: BorderSide(width: 1,color: Color.fromARGB(255, 123, 138, 195)),
            ),
            // disabledBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(4)),
            //   borderSide: BorderSide(width: 1,color: Colors.orange),
            // ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(0)),
              borderSide: BorderSide(width: 1,color: Color.fromARGB(255, 123, 138, 195)),
            ),
            // border: OutlineInputBorder(
            //     borderRadius: BorderRadius.all(Radius.circular(4)),
            //     borderSide: BorderSide(width: 1,)
            // ),
            // errorBorder: OutlineInputBorder(
            //     borderRadius: BorderRadius.all(Radius.circular(4)),
            //     borderSide: BorderSide(width: 1,color: Colors.black)
            // ),
            // focusedErrorBorder: OutlineInputBorder(
            //     borderRadius: BorderRadius.all(Radius.circular(4)),
            //     borderSide: BorderSide(width: 1,color: Colors.yellowAccent)
            // ),

            contentPadding: EdgeInsets.all(8),
            isDense: true, //make textfield compact
          ),
        ),


        // 6. Input text or Edit text with hint "Enter your email id"
        // with input type email
        TextField(
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Montserrat",
            fontSize: 14,
          ), decoration: InputDecoration(
            hintText: "Enter your email id",
            hintStyle: TextStyle(
              color: Colors.white,
              fontFamily: "Montserrat",
              fontSize: 14,
            ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(0)),
            borderSide: BorderSide(width: 1,color: Color.fromARGB(255, 123, 138, 195)),
          ),
          // disabledBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.all(Radius.circular(4)),
          //   borderSide: BorderSide(width: 1,color: Colors.orange),
          // ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(0)),
            borderSide: BorderSide(width: 1,color: Color.fromARGB(255, 123, 138, 195)),
          ),
            contentPadding: EdgeInsets.all(8),
            isDense: true, //make textfield compact
          ),
        ),

        SizedBox(height: 24.0),

        // 7. Notify Me square Button in black color text and sky color background
        SizedBox(
          child: ElevatedButton(
            onPressed: () {
              //  Add your notification logic here
              print("Notify Me button clicked");
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 123, 138, 195),
              // Sky color
              //foregroundColor: Colors.black,
              // Black text color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero, // Square corners
              ),
              padding: EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 16
              ), // Add some vertical padding
            ),
            child: Text(
              "Notify Me",
              style: TextStyle(fontSize: 16.0,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w600,
              color: Colors.black), // Adjust size
            ),
          ),
        ),
      ],

  );
}
