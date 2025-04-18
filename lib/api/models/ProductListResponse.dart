import 'package:hjvyas/api/models/safe_convert.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ProductListResponse {
  final String status;
  final String message;
  final String categoryName;
  final int totalRecords;
  final List<ProductListItem> productList;

  ProductListResponse({
    this.status = "",
    this.message = "",
    this.categoryName = "",
    this.totalRecords = 0,
    this.productList = const [],
  });

  factory ProductListResponse.fromJson(Map<String, dynamic>? json) =>
      ProductListResponse(
        status: asString(json, 'status'),
        message: asString(json, 'message'),
        categoryName: asString(json, 'category_name'),
        totalRecords: asInt(json, 'total_records'),
        productList:
            asList(
              json,
              'product_list',
            ).map((e) => ProductListItem.fromJson(e)).toList(),
      );

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'category_name': categoryName,
    'total_records': totalRecords,
    'product_list': productList.map((e) => e.toJson()).toList(),
  };
}

class ProductListItem {
  final String productId;
  final String productName;
  final String productLife;
  final String productCalories;
  final String productImage;
  final String productWeight;
  final String productPrice;
  final String productSoldout;

  ProductListItem({
    this.productId = "",
    this.productName = "",
    this.productLife = "",
    this.productCalories = "",
    this.productImage = "",
    this.productWeight = "",
    this.productPrice = "",
    this.productSoldout = "",
  });

  factory ProductListItem.fromJson(Map<String, dynamic>? json) =>
      ProductListItem(
        productId: asString(json, 'product_id'),
        productName: asString(json, 'product_name'),
        productLife: asString(json, 'product_life'),
        productCalories: asString(json, 'product_calories'),
        productImage: asString(json, 'product_image'),
        productWeight: asString(json, 'product_weight'),
        productPrice: asString(json, 'product_price'),
        productSoldout: asString(json, 'product_soldout'),
      );

  Map<String, dynamic> toJson() => {
    'product_id': productId,
    'product_name': productName,
    'product_life': productLife,
    'product_calories': productCalories,
    'product_image': productImage,
    'product_weight': productWeight,
    'product_price': productPrice,
    'product_soldout': productSoldout,
  };
}
