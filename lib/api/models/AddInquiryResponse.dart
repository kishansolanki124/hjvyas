import 'package:hjvyas/api/models/safe_convert.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AddInquiryResponse {
  final String status;
  final String message;

  AddInquiryResponse({this.status = "", this.message = ""});

  factory AddInquiryResponse.fromJson(Map<String, dynamic>? json) =>
      AddInquiryResponse(
        status: asString(json, 'status'),
        message: asString(json, 'message'),
      );

  Map<String, dynamic> toJson() => {'status': status, 'message': message};
}
