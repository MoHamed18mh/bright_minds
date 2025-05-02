import 'package:bright_minds/core/api/end_point.dart';

class SectionModel {
  final bool success;
  final String message;
  final int statusCode;
  final List<SectionData> data;

  SectionModel({
    required this.success,
    required this.message,
    required this.statusCode,
    required this.data,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      success: json[ApiKey.success],
      message: json[ApiKey.message],
      statusCode: json[ApiKey.statusCode],
      data: List<SectionData>.from(
          json[ApiKey.data].map((e) => SectionData.fromJson(e))),
    );
  }
}

class SectionData {
  final int id;
  final String name;
  final int courseId;
  final String description;
  final int order;
  final String createdDate;
  final String updatedDate;

  SectionData({
    required this.id,
    required this.name,
    required this.courseId,
    required this.description,
    required this.order,
    required this.createdDate,
    required this.updatedDate,
  });

  factory SectionData.fromJson(Map<String, dynamic> json) {
    return SectionData(
      id: json[ApiKey.id],
      name: json[ApiKey.name],
      courseId: json[ApiKey.courseId],
      description: json[ApiKey.description],
      order: json[ApiKey.order],
      createdDate: json[ApiKey.createdDate],
      updatedDate: json[ApiKey.updatedDate],
    );
  }
}
