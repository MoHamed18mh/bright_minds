import 'package:bright_minds/core/api/end_point.dart';

class CourseModel {
  final bool success;
  final String message;
  final int statusCode;
  final CourseData data;

  CourseModel({
    required this.success,
    required this.message,
    required this.statusCode,
    required this.data,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      success: json[ApiKey.success] as bool? ?? false,
      message: json[ApiKey.message] as String? ?? '',
      statusCode: (json[ApiKey.statusCode] as num?)?.toInt() ?? 0,
      data:
          CourseData.fromJson(json[ApiKey.data] as Map<String, dynamic>? ?? {}),
    );
  }
}

class CourseData {
  final int pageSize;
  final int count;
  final int pageIndex;
  final List<CourseItem> items;

  CourseData({
    required this.pageSize,
    required this.count,
    required this.pageIndex,
    required this.items,
  });

  factory CourseData.fromJson(Map<String, dynamic> json) {
    return CourseData(
      pageSize: (json[ApiKey.pageSize] as num?)?.toInt() ?? 0,
      count: (json[ApiKey.count] as num?)?.toInt() ?? 0,
      pageIndex: (json[ApiKey.pageIndex] as num?)?.toInt() ?? 0,
      items: (json[ApiKey.items] as List<dynamic>? ?? [])
          .map((e) => CourseItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class CourseItem {
  final int id;
  final String name;
  final double price;
  final int categoryId;
  final String categoryName;
  final String description;
  final String instructorName;
  final String pictureUrl;
  final String createdDate;
  final String updatedDate;
  final double rate;

  CourseItem({
    required this.id,
    required this.name,
    required this.price,
    required this.categoryId,
    required this.categoryName,
    required this.description,
    required this.instructorName,
    required this.pictureUrl,
    required this.createdDate,
    required this.updatedDate,
    required this.rate,
  });

  factory CourseItem.fromJson(Map<String, dynamic> json) {
    return CourseItem(
      id: (json[ApiKey.id] as num?)?.toInt() ?? 0,
      name: json[ApiKey.name] as String? ?? '',
      price: (json[ApiKey.price] as num?)?.toDouble() ?? 0.0,
      categoryId: (json[ApiKey.categoryId] as num?)?.toInt() ?? 0,
      categoryName: json[ApiKey.categoryName] as String? ?? '',
      description: json[ApiKey.description] as String? ?? '',
      instructorName: json[ApiKey.instructorName] as String? ?? '',
      pictureUrl: json[ApiKey.pictureUrl] as String? ?? '',
      createdDate: json[ApiKey.createdDate] as String? ?? '',
      updatedDate: json[ApiKey.updatedDate] as String? ?? '',
      rate: (json[ApiKey.rate] as num?)?.toDouble() ?? 0.0,
    );
  }
}
