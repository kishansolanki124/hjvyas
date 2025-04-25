

import 'package:hjvyas/api/models/safe_convert.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ProductDetailResponse {
  final String status;
  final String message;
  final List<ProductDetailItem> productDetail;
  final List<ProductGalleryListItem> productGalleryList;
  final List<ProductPackingListItem> productPackingList;
  final List<ProductIngredientsListItem> productIngredientsList;
  final List<ProductMoreListItem> productMoreList;

  ProductDetailResponse({
    this.status = "",
    this.message = "",
    this.productDetail = const [],
    this.productGalleryList = const [],
    this.productPackingList = const [],
    this.productIngredientsList = const [],
    this.productMoreList = const [],
  });

  factory ProductDetailResponse.fromJson(Map<String, dynamic>? json) => ProductDetailResponse(
    status: asString(json, 'status'),
    message: asString(json, 'message'),
    productDetail: asList(json, 'product_detail').map((e) => ProductDetailItem.fromJson(e)).toList(),
    productGalleryList: asList(json, 'product_gallery_list').map((e) => ProductGalleryListItem.fromJson(e)).toList(),
    productPackingList: asList(json, 'product_packing_list').map((e) => ProductPackingListItem.fromJson(e)).toList(),
    productIngredientsList: asList(json, 'product_ingredients_list').map((e) => ProductIngredientsListItem.fromJson(e)).toList(),
    productMoreList: asList(json, 'product_more_list').map((e) => ProductMoreListItem.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'product_detail': productDetail.map((e) => e.toJson()).toList(),
    'product_gallery_list': productGalleryList.map((e) => e.toJson()).toList(),
    'product_packing_list': productPackingList.map((e) => e.toJson()).toList(),
    'product_ingredients_list': productIngredientsList.map((e) => e.toJson()).toList(),
    'product_more_list': productMoreList.map((e) => e.toJson()).toList(),
  };
}

class ProductDetailItem {
  final String productId;
  final String productType;
  final String productName;
  final String productPrice;
  final String productMaxQty;
  final String productDescription;
  final String productIngredients;
  final String productTerms;
  final String productImage;
  final String productNutritionImage;
  final String productAudioEnglish;
  final String productAudioHindi;
  final String productAudioGujarati;

  ProductDetailItem({
    this.productId = "",
    this.productType = "",
    this.productName = "",
    this.productPrice = "",
    this.productMaxQty = "",
    this.productDescription = "",
    this.productIngredients = "",
    this.productTerms = "",
    this.productImage = "",
    this.productNutritionImage = "",
    this.productAudioEnglish = "",
    this.productAudioHindi = "",
    this.productAudioGujarati = "",
  });

  factory ProductDetailItem.fromJson(Map<String, dynamic>? json) => ProductDetailItem(
    productId: asString(json, 'product_id'),
    productType: asString(json, 'product_type'),
    productName: asString(json, 'product_name'),
    productPrice: asString(json, 'product_price'),
    productMaxQty: asString(json, 'product_max_qty'),
    productDescription: asString(json, 'product_description'),
    productIngredients: asString(json, 'product_ingredients'),
    productTerms: asString(json, 'product_terms'),
    productImage: asString(json, 'product_image'),
    productNutritionImage: asString(json, 'product_nutrition_image'),
    productAudioEnglish: asString(json, 'product_audio_english'),
    productAudioHindi: asString(json, 'product_audio_hindi'),
    productAudioGujarati: asString(json, 'product_audio_gujarati'),
  );

  Map<String, dynamic> toJson() => {
    'product_id': productId,
    'product_type': productType,
    'product_name': productName,
    'product_price': productPrice,
    'product_max_qty': productMaxQty,
    'product_description': productDescription,
    'product_ingredients': productIngredients,
    'product_terms': productTerms,
    'product_image': productImage,
    'product_nutrition_image': productNutritionImage,
    'product_audio_english': productAudioEnglish,
    'product_audio_hindi': productAudioHindi,
    'product_audio_gujarati': productAudioGujarati,
  };
}


class ProductGalleryListItem {
  final String id;
  final String productId;
  final String upProImg;

  ProductGalleryListItem({
    this.id = "",
    this.productId = "",
    this.upProImg = "",
  });

  factory ProductGalleryListItem.fromJson(Map<String, dynamic>? json) => ProductGalleryListItem(
    id: asString(json, 'id'),
    productId: asString(json, 'product_id'),
    upProImg: asString(json, 'up_pro_img'),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'product_id': productId,
    'up_pro_img': upProImg,
  };
}


class ProductPackingListItem {
  final String packingId;
  final String productId;
  final String productWeight;
  final String productWeightType;
  final String productPackingPrice;
  final String productPieces;

  ProductPackingListItem({
    this.packingId = "",
    this.productId = "",
    this.productWeight = "",
    this.productWeightType = "",
    this.productPackingPrice = "",
    this.productPieces = "",
  });

  factory ProductPackingListItem.fromJson(Map<String, dynamic>? json) => ProductPackingListItem(
    packingId: asString(json, 'packing_id'),
    productId: asString(json, 'product_id'),
    productWeight: asString(json, 'product_weight'),
    productWeightType: asString(json, 'product_weight_type'),
    productPackingPrice: asString(json, 'product_packing_price'),
    productPieces: asString(json, 'product_pieces'),
  );

  Map<String, dynamic> toJson() => {
    'packing_id': packingId,
    'product_id': productId,
    'product_weight': productWeight,
    'product_weight_type': productWeightType,
    'product_packing_price': productPackingPrice,
    'product_pieces': productPieces,
  };
}


class ProductIngredientsListItem {
  final String productIngredientsId;
  final String productIngredientsName;
  final String productIngredientsIcon;

  ProductIngredientsListItem({
    this.productIngredientsId = "",
    this.productIngredientsName = "",
    this.productIngredientsIcon = "",
  });

  factory ProductIngredientsListItem.fromJson(Map<String, dynamic>? json) => ProductIngredientsListItem(
    productIngredientsId: asString(json, 'product_ingredients_id'),
    productIngredientsName: asString(json, 'product_ingredients_name'),
    productIngredientsIcon: asString(json, 'product_ingredients_icon'),
  );

  Map<String, dynamic> toJson() => {
    'product_ingredients_id': productIngredientsId,
    'product_ingredients_name': productIngredientsName,
    'product_ingredients_icon': productIngredientsIcon,
  };
}


class ProductMoreListItem {
  final String productId;
  final String productName;
  final String productImage;

  ProductMoreListItem({
    this.productId = "",
    this.productName = "",
    this.productImage = "",
  });

  factory ProductMoreListItem.fromJson(Map<String, dynamic>? json) => ProductMoreListItem(
    productId: asString(json, 'product_id'),
    productName: asString(json, 'product_name'),
    productImage: asString(json, 'product_image'),
  );

  Map<String, dynamic> toJson() => {
    'product_id': productId,
    'product_name': productName,
    'product_image': productImage,
  };
}

