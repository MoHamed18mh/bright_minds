import 'package:bright_minds/core/api/end_point.dart';

class UserCoursesModel {
  final bool success;
  final String message;
  final int statusCode;
  final UserCoursesData data;

  UserCoursesModel({
    required this.success,
    required this.message,
    required this.statusCode,
    required this.data,
  });

  factory UserCoursesModel.fromJson(Map<String, dynamic> json) {
    return UserCoursesModel(
      success: json[ApiKey.success] as bool? ?? false,
      message: json[ApiKey.message] as String? ?? '',
      statusCode: (json[ApiKey.statusCode] as num?)?.toInt() ?? 0,
      data: UserCoursesData.fromJson(
        json[ApiKey.data] as Map<String, dynamic>? ?? {},
      ),
    );
  }
}

class UserCoursesData {
  final int pageSize;
  final int count;
  final int pageIndex;
  final List<UserCourseItem> items;

  UserCoursesData({
    required this.pageSize,
    required this.count,
    required this.pageIndex,
    required this.items,
  });

  factory UserCoursesData.fromJson(Map<String, dynamic> json) {
    return UserCoursesData(
      pageSize: (json[ApiKey.pageSize] as num?)?.toInt() ?? 0,
      count: (json[ApiKey.count] as num?)?.toInt() ?? 0,
      pageIndex: (json[ApiKey.pageIndex] as num?)?.toInt() ?? 0,
      items: (json[ApiKey.items] as List<dynamic>? ?? [])
          .map(
            (e) => UserCourseItem.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}

class UserCourseItem {
  final int id;
  final String name;
  final double price;
  final int categoryId;
  final String categoryName;
  final String description;
  final String instructorName;
  final String pictureUrl;
  final DateTime createdDate;
  final DateTime updatedDate;
  final double rate;

  UserCourseItem({
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

  factory UserCourseItem.fromJson(Map<String, dynamic> json) {
    return UserCourseItem(
      id: (json[ApiKey.id] as num?)?.toInt() ?? 0,
      name: json[ApiKey.name] as String? ?? '',
      price: (json[ApiKey.price] as num?)?.toDouble() ?? 0.0,
      categoryId: (json[ApiKey.categoryId] as num?)?.toInt() ?? 0,
      categoryName: json[ApiKey.categoryName] as String? ?? '',
      description: json[ApiKey.description] as String? ?? '',
      instructorName: json[ApiKey.instructorName] as String? ?? '',
      pictureUrl: json[ApiKey.pictureUrl] as String? ?? '',
      createdDate: DateTime.tryParse(
            json[ApiKey.createdDate] as String? ?? '',
          ) ??
          DateTime.fromMillisecondsSinceEpoch(0),
      updatedDate: DateTime.tryParse(
            json[ApiKey.updatedDate] as String? ?? '',
          ) ??
          DateTime.fromMillisecondsSinceEpoch(0),
      rate: (json[ApiKey.rate] as num?)?.toDouble() ?? 0.0,
    );
  }
}
