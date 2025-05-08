
import 'package:hjvyas/api/models/safe_convert.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ShippingStatusResponse {
  final String status;
  final String message;
  final List<ShippingStatusListItem> shippingStatusList;
  final List<StateListItem> stateList;
  List<CountryListItem> countryList;

  ShippingStatusResponse({
    this.status = "",
    this.message = "",
    this.shippingStatusList = const [],
    this.stateList = const [],
    this.countryList = const [],
  });

  factory ShippingStatusResponse.fromJson(Map<String, dynamic>? json) => ShippingStatusResponse(
    status: asString(json, 'status'),
    message: asString(json, 'message'),
    shippingStatusList: asList(json, 'shipping_status_list').map((e) => ShippingStatusListItem.fromJson(e)).toList(),
    stateList: asList(json, 'state_list').map((e) => StateListItem.fromJson(e)).toList(),
    countryList: asList(json, 'country_list').map((e) => CountryListItem.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'shipping_status_list': shippingStatusList.map((e) => e.toJson()).toList(),
    'state_list': stateList.map((e) => e.toJson()).toList(),
    'country_list': countryList.map((e) => e.toJson()).toList(),
  };
}

class ShippingStatusListItem {
  final String gujaratStatus;
  final String outofgujaratStatus;
  final String outsideindiaStatus;
  final String gujaratMsg;
  final String outofgujaratMsg;
  final String outsideindiaMsg;
  final String razorpayGateway;
  final String ccavenueGateway;
  final String paypalGateway;
  final String shippingTerms;
  final String rupeeExchangeRate;

  ShippingStatusListItem({
    this.gujaratStatus = "",
    this.outofgujaratStatus = "",
    this.outsideindiaStatus = "",
    this.gujaratMsg = "",
    this.outofgujaratMsg = "",
    this.outsideindiaMsg = "",
    this.razorpayGateway = "",
    this.ccavenueGateway = "",
    this.paypalGateway = "",
    this.shippingTerms = "",
    this.rupeeExchangeRate = "",
  });

  factory ShippingStatusListItem.fromJson(Map<String, dynamic>? json) => ShippingStatusListItem(
    gujaratStatus: asString(json, 'gujarat_status'),
    outofgujaratStatus: asString(json, 'outofgujarat_status'),
    outsideindiaStatus: asString(json, 'outsideindia_status'),
    gujaratMsg: asString(json, 'gujarat_msg'),
    outofgujaratMsg: asString(json, 'outofgujarat_msg'),
    outsideindiaMsg: asString(json, 'outsideindia_msg'),
    razorpayGateway: asString(json, 'razorpay_gateway'),
    ccavenueGateway: asString(json, 'ccavenue_gateway'),
    paypalGateway: asString(json, 'paypal_gateway'),
    shippingTerms: asString(json, 'shipping_terms'),
    rupeeExchangeRate: asString(json, 'rupee_exchange_rate'),
  );

  Map<String, dynamic> toJson() => {
    'gujarat_status': gujaratStatus,
    'outofgujarat_status': outofgujaratStatus,
    'outsideindia_status': outsideindiaStatus,
    'gujarat_msg': gujaratMsg,
    'outofgujarat_msg': outofgujaratMsg,
    'outsideindia_msg': outsideindiaMsg,
    'razorpay_gateway': razorpayGateway,
    'ccavenue_gateway': ccavenueGateway,
    'paypal_gateway': paypalGateway,
    'shipping_terms': shippingTerms,
    'rupee_exchange_rate': rupeeExchangeRate,
  };
}


class StateListItem {
  final String id;
  final String stateName;

  StateListItem({
    this.id = "",
    this.stateName = "",
  });

  factory StateListItem.fromJson(Map<String, dynamic>? json) => StateListItem(
    id: asString(json, 'id'),
    stateName: asString(json, 'state_name'),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'state_name': stateName,
  };
}


class CountryListItem {
  final String id;
  final String countryName;

  CountryListItem({
    this.id = "",
    this.countryName = "",
  });

  factory CountryListItem.fromJson(Map<String, dynamic>? json) => CountryListItem(
    id: asString(json, 'id'),
    countryName: asString(json, 'country_name'),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'country_name': countryName,
  };
}

