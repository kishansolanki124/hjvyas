
import 'package:hjvyas/api/models/safe_convert.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class LogoResponse {
  final String status;
  final String message;
  final List<LogoListItem> logoList;

  LogoResponse({
    this.status = "",
    this.message = "",
    this.logoList = const [],
  });

  factory LogoResponse.fromJson(Map<String, dynamic>? json) => LogoResponse(
    status: asString(json, 'status'),
    message: asString(json, 'message'),
    logoList: asList(json, 'logo_list').map((e) => LogoListItem.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'logo_list': logoList.map((e) => e.toJson()).toList(),
  };
}

class LogoListItem {
  final String id;
  final String name;
  final String image;

  LogoListItem({
    this.id = "",
    this.name = "",
    this.image = "",
  });

  factory LogoListItem.fromJson(Map<String, dynamic>? json) => LogoListItem(
    id: asString(json, 'id'),
    name: asString(json, 'name'),
    image: asString(json, 'image'),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image': image,
  };
}

