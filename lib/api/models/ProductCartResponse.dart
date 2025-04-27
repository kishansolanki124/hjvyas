
import 'package:hjvyas/api/models/safe_convert.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ProductCartResponse {
  final String status;
  final String message;
  final List<ProductCartListItem> productCartList;
  final String productMaxQty;

  ProductCartResponse({
    this.status = "",
    this.message = "",
    this.productCartList = const [],
    this.productMaxQty = "",
  });

  factory ProductCartResponse.fromJson(Map<String, dynamic>? json) => ProductCartResponse(
    status: asString(json, 'status'),
    message: asString(json, 'message'),
    productCartList: asList(json, 'product_cart_list').map((e) => ProductCartListItem.fromJson(e)).toList(),
    productMaxQty: asString(json, 'product_max_qty'),
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'product_cart_list': productCartList.map((e) => e.toJson()).toList(),
    'product_max_qty': productMaxQty,
  };
}

class ProductCartListItem {
  final String packingId;
  final String productType;
  final String productName;
  final String packingWeight;
  final String packingPrice;
  final String productImage;
  final String productSoldout;

  ProductCartListItem({
    this.packingId = "",
    this.productType = "",
    this.productName = "",
    this.packingWeight = "",
    this.packingPrice = "",
    this.productImage = "",
    this.productSoldout = "",
  });

  factory ProductCartListItem.fromJson(Map<String, dynamic>? json) => ProductCartListItem(
    packingId: asString(json, 'packing_id'),
    productType: asString(json, 'product_type'),
    productName: asString(json, 'product_name'),
    packingWeight: asString(json, 'packing_weight'),
    packingPrice: asString(json, 'packing_price'),
    productImage: asString(json, 'product_image'),
    productSoldout: asString(json, 'product_soldout'),
  );

  Map<String, dynamic> toJson() => {
    'packing_id': packingId,
    'product_type': productType,
    'product_name': productName,
    'packing_weight': packingWeight,
    'packing_price': packingPrice,
    'product_image': productImage,
    'product_soldout': productSoldout,
  };
}

