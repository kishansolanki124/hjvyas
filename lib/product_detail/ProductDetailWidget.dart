import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hjvyas/product_detail/ProductDetail.dart';

Widget productDetailViewpager(FoodProductDetailsPage widget, onPageChange) {
  return CarouselSlider(
    items:
        widget.imageUrls
            .map(
              (url) => Image.network(
                url, //fit: BoxFit.cover,
                fit: BoxFit.fill,
                width: double.infinity,
                height: 350,
                errorBuilder: (context, error, stackTrace) {
                  return SizedBox(
                    width: double.infinity,
                    height: 350,
                    child: Center(child: Text('Failed to load image')),
                  );
                },
              ),
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
    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 0, 0),
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

      Text(
        widget.productName,
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
      SizedBox(height: 8),

      // 3. Product Price
      Text(
        widget.productPrice,
        style: TextStyle(
          fontSize: 18,
          fontFamily: "Montserrat",
          color: Colors.white,
        ),
      ),
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


Widget productDetailIngredients(FoodProductDetailsPage widget,) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          'Ingredients:',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      SizedBox(height: 8),
      SizedBox(
        height: 120, // Adjust height as needed
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
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
                      errorBuilder: (
                          context,
                          error,
                          stackTrace,
                          ) {
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