import 'package:hjvyas/api/models/safe_convert.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class StaticPageResponse {
  final String status;
  final String message;
  final List<StaticpageListItem> staticpageList;

  StaticPageResponse({
    this.status = "",
    this.message = "",
    this.staticpageList = const [],
  });

  factory StaticPageResponse.fromJson(Map<String, dynamic>? json) =>
      StaticPageResponse(
        status: asString(json, 'status'),
        message: asString(json, 'message'),
        staticpageList:
            asList(
              json,
              'staticpage_list',
            ).map((e) => StaticpageListItem.fromJson(e)).toList(),
      );

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'staticpage_list': staticpageList.map((e) => e.toJson()).toList(),
  };
}

class StaticpageListItem {
  final String id;
  final String name;
  final String description;

  StaticpageListItem({this.id = "", this.name = "", this.description = ""});

  factory StaticpageListItem.fromJson(Map<String, dynamic>? json) =>
      StaticpageListItem(
        id: asString(json, 'id'),
        name: asString(json, 'name'),
        description: asString(json, 'description'),
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
  };
}
