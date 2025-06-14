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
      success: json[ApiKey.success] as bool? ?? false,
      message: json[ApiKey.message] as String? ?? '',
      statusCode: (json[ApiKey.statusCode] as num?)?.toInt() ?? 0,
      data: (json[ApiKey.data] as List<dynamic>? ?? [])
          .map((e) => SectionData.fromJson(e as Map<String, dynamic>))
          .toList(),
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
      id: (json[ApiKey.id] as num?)?.toInt() ?? 0,
      name: json[ApiKey.name] as String? ?? '',
      courseId: (json[ApiKey.courseId] as num?)?.toInt() ?? 0,
      description: json[ApiKey.description] as String? ?? '',
      order: (json[ApiKey.order] as num?)?.toInt() ?? 0,
      createdDate: json[ApiKey.createdDate] as String? ?? '',
      updatedDate: json[ApiKey.updatedDate] as String? ?? '',
    );
  }
}
