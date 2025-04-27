import 'package:hjvyas/api/models/safe_convert.dart';
import 'package:json_annotation/json_annotation.dart';

import 'ComboDetailResponse.dart';
import 'ProductDetailResponse.dart';

@JsonSerializable()
class CartItemModel {
  final String productType;
  final String productPackingId;
  String quantity;
  final List<ProductDetailItem> productDetail;
  final List<ComboDetailItem> comboDetail;
  final List<ProductGalleryListItem> productGalleryList;
  final List<ProductPackingListItem> productPackingList;
  final List<ProductIngredientsListItem> productIngredientsList;
  final List<ProductMoreListItem> productMoreList;

  CartItemModel({
    this.productType = "",
    this.productPackingId = "",
    this.quantity = "",
    this.productDetail = const [],
    this.comboDetail = const [],
    this.productGalleryList = const [],
    this.productPackingList = const [],
    this.productIngredientsList = const [],
    this.productMoreList = const [],
  });

  factory CartItemModel.fromJson(Map<String, dynamic>? json) => CartItemModel(
    productType: asString(json, 'productType'),
    productPackingId: asString(json, 'productPackingId'),
    quantity: asString(json, 'quantity'),
    productDetail:
        asList(
          json,
          'product_detail',
        ).map((e) => ProductDetailItem.fromJson(e)).toList(),
    comboDetail:
        asList(
          json,
          'combo_detail',
        ).map((e) => ComboDetailItem.fromJson(e)).toList(),
    productGalleryList:
        asList(
          json,
          'product_gallery_list',
        ).map((e) => ProductGalleryListItem.fromJson(e)).toList(),
    productPackingList:
        asList(
          json,
          'product_packing_list',
        ).map((e) => ProductPackingListItem.fromJson(e)).toList(),
    productIngredientsList:
        asList(
          json,
          'product_ingredients_list',
        ).map((e) => ProductIngredientsListItem.fromJson(e)).toList(),
    productMoreList:
        asList(
          json,
          'product_more_list',
        ).map((e) => ProductMoreListItem.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson() => {
    'productType': productType,
    'productPackingId': productPackingId,
    'quantity': quantity,
    'product_detail': productDetail.map((e) => e.toJson()).toList(),
    'combo_detail': comboDetail.map((e) => e.toJson()).toList(),
    'product_gallery_list': productGalleryList.map((e) => e.toJson()).toList(),
    'product_packing_list': productPackingList.map((e) => e.toJson()).toList(),
    'product_ingredients_list':
        productIngredientsList.map((e) => e.toJson()).toList(),
    'product_more_list': productMoreList.map((e) => e.toJson()).toList(),
  };
}
