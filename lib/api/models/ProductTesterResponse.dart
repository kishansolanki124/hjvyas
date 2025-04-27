import 'package:hjvyas/api/models/safe_convert.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ProductTesterResponse {
  final String status;
  final String message;
  final List<ProductTesterListItem> productTesterList;
  final String productTesterStatus;
  final String productTesterMsg;

  ProductTesterResponse({
    this.status = "",
    this.message = "",
    this.productTesterList = const [],
    this.productTesterStatus = "",
    this.productTesterMsg = "",
  });

  factory ProductTesterResponse.fromJson(Map<String, dynamic>? json) =>
      ProductTesterResponse(
        status: asString(json, 'status'),
        message: asString(json, 'message'),
        productTesterList:
            asList(
              json,
              'product_tester_list',
            ).map((e) => ProductTesterListItem.fromJson(e)).toList(),
        productTesterStatus: asString(json, 'product_tester_status'),
        productTesterMsg: asString(json, 'product_tester_msg'),
      );

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'product_tester_list': productTesterList.map((e) => e.toJson()).toList(),
    'product_tester_status': productTesterStatus,
    'product_tester_msg': productTesterMsg,
  };
}

class ProductTesterListItem {
  final String testerId;
  final String testerName;
  final String testerImage;

  ProductTesterListItem({
    this.testerId = "",
    this.testerName = "",
    this.testerImage = "",
  });

  factory ProductTesterListItem.fromJson(Map<String, dynamic>? json) =>
      ProductTesterListItem(
        testerId: asString(json, 'tester_id'),
        testerName: asString(json, 'tester_name'),
        testerImage: asString(json, 'tester_image'),
      );

  Map<String, dynamic> toJson() => {
    'tester_id': testerId,
    'tester_name': testerName,
    'tester_image': testerImage,
  };
}
