import 'package:hjvyas/api/models/safe_convert.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class NotificationListResponse {
  final String status;
  final String message;
  final List<NotificationListItem> notificationList;

  NotificationListResponse({
    this.status = "",
    this.message = "",
    this.notificationList = const [],
  });

  factory NotificationListResponse.fromJson(Map<String, dynamic>? json) =>
      NotificationListResponse(
        status: asString(json, 'status'),
        message: asString(json, 'message'),
        notificationList:
            asList(
              json,
              'notification_list',
            ).map((e) => NotificationListItem.fromJson(e)).toList(),
      );

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'notification_list': notificationList.map((e) => e.toJson()).toList(),
  };
}

class NotificationListItem {
  final String id;
  final String name;
  final String description;
  final String pdate;

  NotificationListItem({
    this.id = "",
    this.name = "",
    this.description = "",
    this.pdate = "",
  });

  factory NotificationListItem.fromJson(Map<String, dynamic>? json) =>
      NotificationListItem(
        id: asString(json, 'id'),
        name: asString(json, 'name'),
        description: asString(json, 'description'),
        pdate: asString(json, 'pdate'),
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'pdate': pdate,
  };
}
