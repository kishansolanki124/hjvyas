import 'package:hjvyas/api/models/safe_convert.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AddOrderResponse {
  final String status;
  final String message;
  final int orderId;
  final String orderNo;
  final String razorpayOrderid;
  final String keyId;
  final String workingKey;
  final String accessCode;

  AddOrderResponse({
    this.status = "",
    this.message = "",
    this.orderId = 0,
    this.orderNo = "",
    this.razorpayOrderid = "",
    this.keyId = "",
    this.workingKey = "",
    this.accessCode = "",
  });

  factory AddOrderResponse.fromJson(Map<String, dynamic>? json) =>
      AddOrderResponse(
        status: asString(json, 'status'),
        message: asString(json, 'message'),
        orderId: asInt(json, 'order_id'),
        orderNo: asString(json, 'order_no'),
        razorpayOrderid: asString(json, 'razorpay_orderid'),
        keyId: asString(json, 'keyId'),
        workingKey: asString(json, 'working_key'),
        accessCode: asString(json, 'access_code'),
      );

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'order_id': orderId,
    'order_no': orderNo,
    'razorpay_orderid': razorpayOrderid,
    'keyId': keyId,
    'working_key': workingKey,
    'access_code': accessCode,
  };
}
