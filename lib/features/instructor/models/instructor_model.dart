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
      success: json[ApiKey.success],
      message: json[ApiKey.message],
      statusCode: json[ApiKey.statusCode],
      data: InstructorData.fromJson(json[ApiKey.data]),
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
      pageSize: json[ApiKey.pageSize],
      count: json[ApiKey.count],
      pageIndex: json[ApiKey.pageIndex],
      items: List<InstructorItem>.from(
        json[ApiKey.items].map((item) => InstructorItem.fromJson(item)),
      ),
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
      userId: json[ApiKey.userId],
      displayName: json[ApiKey.displayName],
      jobTitle: json[ApiKey.jobTitle],
      email: json[ApiKey.email],
      mobile: json[ApiKey.mobile],
      imageCover: json[ApiKey.imageCover],
      qualifications: json[ApiKey.qualifications],
    );
  }
}
