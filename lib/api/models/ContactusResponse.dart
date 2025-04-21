

import 'package:hjvyas/api/models/safe_convert.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ContactusResponse {
  final String status;
  final String message;
  final List<ContactListItem> contactList;

  ContactusResponse({
    this.status = "",
    this.message = "",
    this.contactList = const [],
  });

  factory ContactusResponse.fromJson(Map<String, dynamic>? json) => ContactusResponse(
    status: asString(json, 'status'),
    message: asString(json, 'message'),
    contactList: asList(json, 'contact_list').map((e) => ContactListItem.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'contact_list': contactList.map((e) => e.toJson()).toList(),
  };
}

class ContactListItem {
  final String name;
  final String address;
  final String mobile1;
  final String mobile2;
  final String whatsappNo;
  final String timing;
  final String email;
  final String googleMap;
  final String inquiryType;

  ContactListItem({
    this.name = "",
    this.address = "",
    this.mobile1 = "",
    this.mobile2 = "",
    this.whatsappNo = "",
    this.timing = "",
    this.email = "",
    this.googleMap = "",
    this.inquiryType = "",
  });

  factory ContactListItem.fromJson(Map<String, dynamic>? json) => ContactListItem(
    name: asString(json, 'name'),
    address: asString(json, 'address'),
    mobile1: asString(json, 'mobile1'),
    mobile2: asString(json, 'mobile2'),
    whatsappNo: asString(json, 'whatsapp_no'),
    timing: asString(json, 'timing'),
    email: asString(json, 'email'),
    googleMap: asString(json, 'google_map'),
    inquiryType: asString(json, 'inquiry_type'),
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'address': address,
    'mobile1': mobile1,
    'mobile2': mobile2,
    'whatsapp_no': whatsappNo,
    'timing': timing,
    'email': email,
    'google_map': googleMap,
    'inquiry_type': inquiryType,
  };
}

