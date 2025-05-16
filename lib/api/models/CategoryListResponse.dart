import 'package:hjvyas/api/models/safe_convert.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CategoryListResponse {
  final String status;
  final String message;
  final List<CategoryListItem> categoryList;

  CategoryListResponse({
    this.status = "",
    this.message = "",
    this.categoryList = const [],
  });

  factory CategoryListResponse.fromJson(Map<String, dynamic>? json) =>
      CategoryListResponse(
        status: asString(json, 'status'),
        message: asString(json, 'message'),
        categoryList:
            asList(
              json,
              'category_list',
            ).map((e) => CategoryListItem.fromJson(e)).toList(),
      );

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'category_list': categoryList.map((e) => e.toJson()).toList(),
  };
}

class CategoryListItem {
  final String categoryId;
  final String categoryName;
  final String categoryImage;
  final String categoryIcon;

  CategoryListItem({
    this.categoryId = "",
    this.categoryName = "",
    this.categoryImage = "",
    this.categoryIcon = "",
  });

  factory CategoryListItem.fromJson(Map<String, dynamic>? json) =>
      CategoryListItem(
        categoryId: asString(json, 'category_id'),
        categoryName: asString(json, 'category_name'),
        categoryImage: asString(json, 'category_image'),
        categoryIcon: asString(json, 'category_icon'),
      );

  Map<String, dynamic> toJson() => {
    'category_id': categoryId,
    'category_name': categoryName,
    'category_image': categoryImage,
    'category_icon': categoryIcon,
  };
}
