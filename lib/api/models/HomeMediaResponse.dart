

import 'package:hjvyas/api/models/safe_convert.dart';

class HomeMediaResponse {
  final String status;
  final String message;
  final int totalRecords;
  final List<SliderListItem> sliderList;

  HomeMediaResponse({
    this.status = "",
    this.message = "",
    this.totalRecords = 0,
    this.sliderList = const [],
  });

  factory HomeMediaResponse.fromJson(Map<String, dynamic>? json) => HomeMediaResponse(
    status: asString(json, 'status'),
    message: asString(json, 'message'),
    totalRecords: asInt(json, 'total_records'),
    sliderList: asList(json, 'slider_list').map((e) => SliderListItem.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'total_records': totalRecords,
    'slider_list': sliderList.map((e) => e.toJson()).toList(),
  };
}

class SliderListItem {
  final String id;
  final String type;
  final String image;

  SliderListItem({
    this.id = "",
    this.type = "",
    this.image = "",
  });

  factory SliderListItem.fromJson(Map<String, dynamic>? json) => SliderListItem(
    id: asString(json, 'id'),
    type: asString(json, 'type'),
    image: asString(json, 'image'),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'image': image,
  };
}

