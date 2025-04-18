import 'package:hjvyas/api/models/safe_convert.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ComboListResponse {
  final String status;
  final String message;
  final int totalRecords;
  final List<ComboListItem> comboList;

  ComboListResponse({
    this.status = "",
    this.message = "",
    this.totalRecords = 0,
    this.comboList = const [],
  });

  factory ComboListResponse.fromJson(Map<String, dynamic>? json) =>
      ComboListResponse(
        status: asString(json, 'status'),
        message: asString(json, 'message'),
        totalRecords: asInt(json, 'total_records'),
        comboList:
            asList(
              json,
              'combo_list',
            ).map((e) => ComboListItem.fromJson(e)).toList(),
      );

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'total_records': totalRecords,
    'combo_list': comboList.map((e) => e.toJson()).toList(),
  };
}

class ComboListItem {
  final String comboId;
  final String comboName;
  final String comboSpecification;
  final String comboImage;
  final String comboWeight;
  final String comboPrice;
  final String comboSoldout;

  ComboListItem({
    this.comboId = "",
    this.comboName = "",
    this.comboSpecification = "",
    this.comboImage = "",
    this.comboWeight = "",
    this.comboPrice = "",
    this.comboSoldout = "",
  });

  factory ComboListItem.fromJson(Map<String, dynamic>? json) => ComboListItem(
    comboId: asString(json, 'combo_id'),
    comboName: asString(json, 'combo_name'),
    comboSpecification: asString(json, 'combo_specification'),
    comboImage: asString(json, 'combo_image'),
    comboWeight: asString(json, 'combo_weight'),
    comboPrice: asString(json, 'combo_price'),
    comboSoldout: asString(json, 'combo_soldout'),
  );

  Map<String, dynamic> toJson() => {
    'combo_id': comboId,
    'combo_name': comboName,
    'combo_specification': comboSpecification,
    'combo_image': comboImage,
    'combo_weight': comboWeight,
    'combo_price': comboPrice,
    'combo_soldout': comboSoldout,
  };
}
