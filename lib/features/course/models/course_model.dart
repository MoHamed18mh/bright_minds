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
      success: json[ApiKey.success] ?? false,
      message: json[ApiKey.message] ?? '',
      statusCode: json[ApiKey.statusCode] ?? 0,
      data: CourseData.fromJson(json[ApiKey.data] ?? {}),
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
      pageSize: json[ApiKey.pageSize] ?? 0,
      count: json[ApiKey.count] ?? 0,
      pageIndex: json[ApiKey.pageIndex] ?? 0,
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
      id: json[ApiKey.id] ?? 0,
      name: json[ApiKey.name] ?? '',
      price: json[ApiKey.price] ?? 0.0,
      categoryId: json[ApiKey.categoryId] ?? 0,
      categoryName: json[ApiKey.categoryName] ?? '',
      description: json[ApiKey.description] ?? '',
      instructorName: json[ApiKey.instructorName] ?? '',
      pictureUrl: json[ApiKey.pictureUrl] ?? '',
      createdDate: json[ApiKey.createdDate] ?? '',
      updatedDate: json[ApiKey.updatedDate] ?? '',
      rate: json[ApiKey.rate] ?? 0.0,
    );
  }
}
