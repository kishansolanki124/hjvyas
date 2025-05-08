import 'package:hjvyas/api/models/safe_convert.dart';

class HomeMediaResponse {
  final String status;
  final String message;
  final int totalRecords;
  final List<SliderListItem> sliderList;
  final List<PopupListItem> popupList;

  HomeMediaResponse({
    this.status = "",
    this.message = "",
    this.totalRecords = 0,
    this.sliderList = const [],
    this.popupList = const [],
  });

  factory HomeMediaResponse.fromJson(Map<String, dynamic>? json) =>
      HomeMediaResponse(
        status: asString(json, 'status'),
        message: asString(json, 'message'),
        totalRecords: asInt(json, 'total_records'),
        sliderList:
            asList(
              json,
              'slider_list',
            ).map((e) => SliderListItem.fromJson(e)).toList(),
        popupList:
            asList(
              json,
              'popup_list',
            ).map((e) => PopupListItem.fromJson(e)).toList(),
      );

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'total_records': totalRecords,
    'slider_list': sliderList.map((e) => e.toJson()).toList(),
    'popup_list': sliderList.map((e) => e.toJson()).toList(),
  };
}

class SliderListItem {
  final String id;
  final String type;
  final String image;

  SliderListItem({this.id = "", this.type = "", this.image = ""});

  factory SliderListItem.fromJson(Map<String, dynamic>? json) => SliderListItem(
    id: asString(json, 'id'),
    type: asString(json, 'type'),
    image: asString(json, 'image'),
  );

  Map<String, dynamic> toJson() => {'id': id, 'type': type, 'image': image};
}

class PopupListItem {
  final String id;
  final String title;
  final String image;
  final String description;

  PopupListItem({
    this.id = "",
    this.title = "",
    this.image = "",
    this.description = "",
  });

  factory PopupListItem.fromJson(Map<String, dynamic>? json) => PopupListItem(
    id: asString(json, 'id'),
    title: asString(json, 'title'),
    image: asString(json, 'image'),
    description: asString(json, 'description'),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'image': image,
    'description': description,
  };
}
