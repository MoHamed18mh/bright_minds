import 'package:bright_minds/core/api/end_point.dart';

class CartCourseModel {
  final bool success;
  final String message;
  final int statusCode;
  final CartCourseData data;

  CartCourseModel({
    required this.success,
    required this.message,
    required this.statusCode,
    required this.data,
  });

  factory CartCourseModel.fromJson(Map<String, dynamic> json) {
    return CartCourseModel(
      success: json[ApiKey.success] as bool,
      message: json[ApiKey.message] as String,
      statusCode: json[ApiKey.statusCode] as int,
      data: CartCourseData.fromJson(json[ApiKey.data] as Map<String, dynamic>),
    );
  }
}

class CartCourseData {
  final int id;
  final String name;
  final double price;
  final String description;
  final String instructorName;
  final String pictureUrl;
  final DateTime createdDate;
  final DateTime updatedDate;
  final List<CartCourseSection> sections;

  CartCourseData({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.instructorName,
    required this.pictureUrl,
    required this.createdDate,
    required this.updatedDate,
    required this.sections,
  });

  factory CartCourseData.fromJson(Map<String, dynamic> json) {
    return CartCourseData(
      id: json[ApiKey.id] as int,
      name: json[ApiKey.name] as String,
      price: (json[ApiKey.price] as num).toDouble(),
      description: json[ApiKey.description] as String,
      instructorName: json[ApiKey.instructorName] as String,
      pictureUrl: json[ApiKey.pictureUrl] as String,
      createdDate: DateTime.parse(json[ApiKey.createdDate] as String),
      updatedDate: DateTime.parse(json[ApiKey.updatedDate] as String),
      sections: (json[ApiKey.sections] as List<dynamic>)
          .map((e) => CartCourseSection.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class CartCourseSection {
  final int id;
  final String name;
  final int courseId;
  final String description;
  final int order;
  final String createdDate;
  final String updatedDate; 

  CartCourseSection({
    required this.id,
    required this.name,
    required this.courseId,
    required this.description,
    required this.order,
    required this.createdDate,
    required this.updatedDate, 
  });

  factory CartCourseSection.fromJson(Map<String, dynamic> json) {
    return CartCourseSection(
      id: json[ApiKey.id] as int,
      name: json[ApiKey.name] as String,
      courseId: json[ApiKey.courseId] as int,
      description: json[ApiKey.description] as String,
      order: json[ApiKey.order] as int,
      createdDate: (json[ApiKey.createdDate] as String), 
      updatedDate: (json[ApiKey.updatedDate] as String),
    );
  }
}
