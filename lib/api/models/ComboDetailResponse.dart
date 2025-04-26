import 'package:hjvyas/api/models/safe_convert.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ComboDetailResponse {
  final String status;
  final String message;
  final List<ComboDetailItem> comboDetail;
  final List<ComboGalleryListItem> comboGalleryList;
  final List<ComboMoreListItem> comboMoreList;

  ComboDetailResponse({
    this.status = "",
    this.message = "",
    this.comboDetail = const [],
    this.comboGalleryList = const [],
    this.comboMoreList = const [],
  });

  factory ComboDetailResponse.fromJson(Map<String, dynamic>? json) =>
      ComboDetailResponse(
        status: asString(json, 'status'),
        message: asString(json, 'message'),
        comboDetail:
            asList(
              json,
              'combo_detail',
            ).map((e) => ComboDetailItem.fromJson(e)).toList(),
        comboGalleryList:
            asList(
              json,
              'combo_gallery_list',
            ).map((e) => ComboGalleryListItem.fromJson(e)).toList(),
        comboMoreList:
            asList(
              json,
              'combo_more_list',
            ).map((e) => ComboMoreListItem.fromJson(e)).toList(),
      );

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'combo_detail': comboDetail.map((e) => e.toJson()).toList(),
    'combo_gallery_list': comboGalleryList.map((e) => e.toJson()).toList(),
    'combo_more_list': comboMoreList.map((e) => e.toJson()).toList(),
  };
}

class ComboDetailItem {
  final String comboId;
  final String comboType;
  final String comboName;
  final String comboPrice;
  final String comboDescription;
  final String comboImage;

  ComboDetailItem({
    this.comboId = "",
    this.comboType = "",
    this.comboName = "",
    this.comboPrice = "",
    this.comboDescription = "",
    this.comboImage = "",
  });

  factory ComboDetailItem.fromJson(Map<String, dynamic>? json) =>
      ComboDetailItem(
        comboId: asString(json, 'combo_id'),
        comboType: asString(json, 'combo_type'),
        comboName: asString(json, 'combo_name'),
        comboPrice: asString(json, 'combo_price'),
        comboDescription: asString(json, 'combo_description'),
        comboImage: asString(json, 'combo_image'),
      );

  Map<String, dynamic> toJson() => {
    'combo_id': comboId,
    'combo_type': comboType,
    'combo_name': comboName,
    'combo_price': comboPrice,
    'combo_description': comboDescription,
    'combo_image': comboImage,
  };
}

class ComboGalleryListItem {
  final String id;
  final String comboId;
  final String upProImg;

  ComboGalleryListItem({this.id = "", this.comboId = "", this.upProImg = ""});

  factory ComboGalleryListItem.fromJson(Map<String, dynamic>? json) =>
      ComboGalleryListItem(
        id: asString(json, 'id'),
        comboId: asString(json, 'combo_id'),
        upProImg: asString(json, 'up_pro_img'),
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'combo_id': comboId,
    'up_pro_img': upProImg,
  };
}

class ComboMoreListItem {
  final String comboId;
  final String comboName;
  final String productImage;

  ComboMoreListItem({
    this.comboId = "",
    this.comboName = "",
    this.productImage = "",
  });

  factory ComboMoreListItem.fromJson(Map<String, dynamic>? json) =>
      ComboMoreListItem(
        comboId: asString(json, 'combo_id'),
        comboName: asString(json, 'combo_name'),
        productImage: asString(json, 'product_image'),
      );

  Map<String, dynamic> toJson() => {
    'combo_id': comboId,
    'combo_name': comboName,
    'product_image': productImage,
  };
}
