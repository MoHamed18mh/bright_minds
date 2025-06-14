import 'package:bright_minds/core/api/end_point.dart';

class InstructorModel {
  final bool success;
  final String message;
  final int statusCode;
  final InstructorData data;

  InstructorModel({
    required this.success,
    required this.message,
    required this.statusCode,
    required this.data,
  });

  factory InstructorModel.fromJson(Map<String, dynamic> json) {
    return InstructorModel(
      success: json[ApiKey.success] as bool? ?? false,
      message: json[ApiKey.message] as String? ?? '',
      statusCode: (json[ApiKey.statusCode] as num?)?.toInt() ?? 0,
      data: InstructorData.fromJson(json[ApiKey.data] as Map<String, dynamic>? ?? {}),
    );
  }
}

class InstructorData {
  final int pageSize;
  final int count;
  final int pageIndex;
  final List<InstructorItem> items;

  InstructorData({
    required this.pageSize,
    required this.count,
    required this.pageIndex,
    required this.items,
  });

  factory InstructorData.fromJson(Map<String, dynamic> json) {
    return InstructorData(
      pageSize: (json[ApiKey.pageSize] as num?)?.toInt() ?? 0,
      count: (json[ApiKey.count] as num?)?.toInt() ?? 0,
      pageIndex: (json[ApiKey.pageIndex] as num?)?.toInt() ?? 0,
      items: (json[ApiKey.items] as List<dynamic>? ?? [])
          .map((e) => InstructorItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class InstructorItem {
  final String userId;
  final String displayName;
  final String jobTitle;
  final String email;
  final String mobile;
  final String imageCover;
  final String qualifications;

  InstructorItem({
    required this.userId,
    required this.displayName,
    required this.jobTitle,
    required this.email,
    required this.mobile,
    required this.imageCover,
    required this.qualifications,
  });

  factory InstructorItem.fromJson(Map<String, dynamic> json) {
    return InstructorItem(
      userId: json[ApiKey.userId] as String? ?? '',
      displayName: json[ApiKey.displayName] as String? ?? '',
      jobTitle: json[ApiKey.jobTitle] as String? ?? '',
      email: json[ApiKey.email] as String? ?? '',
      mobile: json[ApiKey.mobile] as String? ?? '',
      imageCover: json[ApiKey.imageCover] as String? ?? '',
      qualifications: json[ApiKey.qualifications] as String? ?? '',
    );
  }
}
