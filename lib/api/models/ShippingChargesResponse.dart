import 'package:hjvyas/api/models/safe_convert.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ShippingChargesResponse {
  final String status;
  final String message;
  final String shippingCharge;
  final String onlineCharge;
  final String finalCharge;
  final String finalAmount;

  ShippingChargesResponse({
    this.status = "",
    this.message = "",
    this.shippingCharge = "",
    this.onlineCharge = "",
    this.finalCharge = "",
    this.finalAmount = "",
  });

  factory ShippingChargesResponse.fromJson(Map<String, dynamic>? json) =>
      ShippingChargesResponse(
        status: asString(json, 'status'),
        message: asString(json, 'message'),
        shippingCharge: asString(json, 'shipping_charge'),
        onlineCharge: asString(json, 'online_charge'),
        finalCharge: asString(json, 'final_charge'),
        finalAmount: asString(json, 'final_amount'),
      );

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'shipping_charge': shippingCharge,
    'online_charge': onlineCharge,
    'final_charge': finalCharge,
    'final_amount': finalAmount,
  };
}
