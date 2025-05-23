import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hjvyas/combo/ComboDetail.dart';
import 'package:hjvyas/product_detail/ProductDetail.dart';

import '../api/models/ComboDetailResponse.dart';
import '../api/models/ProductDetailResponse.dart';
import '../utils/AppColors.dart';
import 'IngredientsImageWithLoading.dart';
import 'NetworkImageWithLoading.dart';
import 'ProductYouMayLikeItem.dart';

Widget backButton(Function() _onBackPressed) {
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

Widget productDetailViewpager(
  List<ProductGalleryListItem> galleryList,
  onPageChange,
) {
  return CarouselSlider(
    items:
        galleryList
            .map((item) => networkImageWithLoader(item.upProImg))
            .toList(),
    options: CarouselOptions(
      height: 550,
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

Widget comboDetailViewpager(
  List<ComboGalleryListItem> galleryList,
  onPageChange,
) {
  return CarouselSlider(
    items:
        galleryList
            .map((item) => networkImageWithLoader(item.upProImg))
            .toList(),
    options: CarouselOptions(
      height: 550,
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
  List<Object> galleryList,
  int currentImageIndex,
) {
  return Padding(
    padding: EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children:
          galleryList.asMap().entries.map((entry) {
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

Widget productDetailNameAndPrice(String name, String price, bool isOutOfStock) {
  return Column(
    children: [
      SizedBox(height: 50),

      //product name
      Container(
        color: AppColors.background,
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
          child: Text(
            name,
            style: TextStyle(
              backgroundColor: AppColors.background,
              fontSize: 18,
              color: Colors.white,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),

      // 3. Product Price
      if (price.isNotEmpty)
        Text(
          "₹ $price",
          style: TextStyle(
            fontSize: 16,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),

      // if(isOutOfStock)
      //   outOfStockDetail(),
      SizedBox(height: 16),
    ],
  );
}

Widget productDetailDropDown(
  List<ProductPackingListItem> productPackingList,
  _selectedVariant,
  onChangedDropDownValue,
) {
  return Container(
    height: 35,
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.secondary),
      borderRadius: BorderRadius.circular(0),
      color: Colors.transparent, // Background color
    ),
    padding: EdgeInsets.symmetric(horizontal: 6.0),
    // Add some padding inside the border
    child: DropdownButton<ProductPackingListItem>(
      isExpanded: true,
      // Important! Makes dropdown use all available width
      icon: Image.asset(
        'icons/dropdown_icon.png', // Replace with your icon path
        width: 12, // Adjust width as needed
        height: 12, // Adjust height as needed
      ),
      // Custom icon
      value: _selectedVariant,
      underline: SizedBox(),
      dropdownColor: AppColors.background,
      // This line hides the bottom line
      items:
          productPackingList.map((ProductPackingListItem variation) {
            return DropdownMenuItem<ProductPackingListItem>(
              value: variation,
              child: Text(
                variation.productPieces.isNotEmpty
                    ? ("${variation.productWeight} ${variation.productWeightType} "
                        "(₹${variation.productPackingPrice}) - ${variation.productPieces} Pieces")
                    : ("${variation.productWeight} ${variation.productWeightType} "
                        "(₹${variation.productPackingPrice})"),
                // "${variation.productWeight} ${variation.productWeightType} "
                // "(₹${variation.productPackingPrice}) - ${variation.productPieces} Pieces",
                style: TextStyle(
                  backgroundColor: AppColors.background,
                  fontSize: 12,
                  color: Colors.white,
                  fontFamily: "Montserrat",
                  //fontWeight: FontWeight.w700,
                ),
              ),
            );
          }).toList(),
      onChanged: (ProductPackingListItem? newValue) {
        // setState(() {
        //   _selectedVariant = newValue;
        // });
        onChangedDropDownValue(newValue);
      },

      // This controls how the selected item appears in the closed dropdown
      selectedItemBuilder: (BuildContext context) {
        return productPackingList.map<Widget>((
          ProductPackingListItem variation,
        ) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                variation.productPieces.isNotEmpty
                    ? ("${variation.productWeight} ${variation.productWeightType} "
                        "(₹${variation.productPackingPrice}) - ${variation.productPieces} Pieces")
                    : ("${variation.productWeight} ${variation.productWeightType} "
                        "(₹${variation.productPackingPrice})"),
                style: TextStyle(
                  backgroundColor: Colors.transparent,
                  fontSize: 12,
                  color: Colors.white,
                  fontFamily: "Montserrat",
                  //fontWeight: FontWeight.w700,
                ),
              ),
            ],
          );
        }).toList();
      },
    ),
  );
}

Widget productDetailItemCounter(
  decrementQuantity,
  incrementQuantity,
  quantity,
) {
  return Container(
    height: 35,
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.secondary),
      borderRadius: BorderRadius.circular(0),
      color: Colors.transparent, // Background color
    ),
    // Add some padding inside the border
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        //minus icon
        SizedBox(
          width: 40,
          height: 40,
          child: IconButton(
            iconSize: 12,
            padding: EdgeInsets.zero,
            color: Colors.white,
            icon: Icon(Icons.remove),
            onPressed: decrementQuantity,
          ),
        ),
        //counter text
        SizedBox(
          width: 30,
          child: Center(
            child: Text(
              '$quantity',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontFamily: "Montserrat",
              ),
            ),
          ),
        ),
        //plus icon
        SizedBox(
          width: 40,
          height: 40,
          child: IconButton(
            iconSize: 12,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            color: Colors.white,
            icon: Icon(Icons.add),
            onPressed: incrementQuantity,
          ),
        ),
      ],
    ),
  );
}

Widget productDetailItemCounterNew(
  decrementQuantity,
  incrementQuantity,
  quantity,
) {
  return Container(
    height: 40, // Add some padding inside the border
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        //minus icon
        SizedBox(
          width: 40,
          height: 40,
          child: IconButton(
            iconSize: 16,
            padding: EdgeInsets.zero,
            color: Colors.white,
            icon: Icon(Icons.remove),
            onPressed: decrementQuantity,
          ),
        ),
        //counter text
        SizedBox(
          width: 30,
          child: Center(
            child: Text(
              '$quantity',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontFamily: "Montserrat",
              ),
            ),
          ),
        ),
        //plus icon
        SizedBox(
          width: 40,
          height: 40,
          child: IconButton(
            iconSize: 16,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            color: Colors.white,
            icon: Icon(Icons.add),
            onPressed: incrementQuantity,
          ),
        ),
      ],
    ),
  );
}

Widget productDetailIngredients(
  List<ProductIngredientsListItem> productIngredients,
) {
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
          itemCount: productIngredients.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Column(
                children: [
                  Container(
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.secondary,
                      ),
                    ),
                    child: IngredientsImageWithLoading(
                      imageUrl:
                          productIngredients
                              .elementAt(index)
                              .productIngredientsIcon,
                    ),
                  ),

                  //Ingredient text name
                  SizedBox(
                    width: 75,
                    child: Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        productIngredients
                            .elementAt(index)
                            .productIngredientsName,
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
    ],
  );
}

Widget productDetailYouMayLike(List<ProductMoreListItem> moreItemList) {
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
        height: 180, // Adjust height as needed
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          itemCount: moreItemList.length,
          itemBuilder: (context, index) {
            final product = moreItemList.elementAt(index);

            Widget youMayLikeWidget = ProductYouMayLikeItem(
              index: index,
              productMoreListItem: product,
            );

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => //ProductDetail(item: item),
                            ProductDetail(productId: product.productId),
                  ),
                );
              },
              child: youMayLikeWidget,
            );
          },
        ),
      ),
    ],
  );
}

Widget comboDetailYouMayLike(List<ComboMoreListItem> moreItemList) {
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
        height: 180, // Adjust height as needed
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          itemCount: moreItemList.length,
          itemBuilder: (context, index) {
            final product = moreItemList.elementAt(index);
            Widget youMayLikeWidget = Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Container(
                width: 120,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.secondary),
                ),
                child: Column(
                  children: [
                    if (product.productImage.isNotEmpty)
                      SizedBox(
                        height: 110,
                        width: 110,
                        child: Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Image.network(
                            product.productImage,
                            height: 110,
                            width: 110,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return SizedBox(
                                height: 60,
                                child: Center(child: Text('Err')),
                              );
                            },
                          ),
                        ),
                      ),

                    SizedBox(height: 4),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2),
                      child: Text(
                        product.comboName,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1),
                      child: Text(
                        "₹ ${product.comboPrice ?? ''} -  ${product.comboWeight}",
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Montserrat",
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => //ProductDetail(item: item),
                            ComboDetail(comboId: product.comboId),
                  ),
                );
              },
              child: youMayLikeWidget,
            );
          },
        ),
      ),
    ],
  );
}

Widget productDetailTabs(tabController, activeTabIndex) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: TabBar(
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: Colors.transparent,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      indicator: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.secondary,
            width: 6.0,
          ),
          left: BorderSide(
            color: AppColors.secondary,
            width: 1.0,
          ),
          right: BorderSide(
            color: AppColors.secondary,
            width: 1.0,
          ),
        ),
      ),
      labelColor: Colors.white,
      indicatorPadding: const EdgeInsets.fromLTRB(0, 0, 0, 2),
      labelPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      unselectedLabelColor: Colors.white,
      controller: tabController,
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
                          : AppColors.secondary,
                  width: 1.0,
                ),
              ),
            ),
            child: const Align(
              alignment: Alignment.center,
              child: Text(
                "Description",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w700,
                ),
              ),
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
                          : AppColors.secondary,
                  width: 1.0,
                ),
              ),
            ),
            child: const Align(
              alignment: Alignment.center,
              child: Text(
                "Nutrition Value",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget comboDetailTabs(tabController, activeTabIndex) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: TabBar(
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: Colors.transparent,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      indicator: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.secondary,
            width: 6.0,
          ),
          left: BorderSide(
            color: AppColors.secondary,
            width: 1.0,
          ),
          right: BorderSide(
            color: AppColors.secondary,
            width: 1.0,
          ),
        ),
      ),
      labelColor: Colors.white,
      indicatorPadding: const EdgeInsets.fromLTRB(0, 0, 0, 2),
      labelPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      unselectedLabelColor: Colors.white,
      controller: tabController,
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
                          : AppColors.secondary,
                  width: 1.0,
                ),
              ),
            ),
            child: const Align(
              alignment: Alignment.center,
              child: Text(
                "Description",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w700,
                ),
              ),
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
