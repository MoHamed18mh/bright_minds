import 'package:bright_minds/core/api/end_point.dart';

class VideoModel {
  final bool success;
  final String message;
  final int statusCode;
  final List<VideoData> data;

  VideoModel({
    required this.success,
    required this.message,
    required this.statusCode,
    required this.data,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      success: json[ApiKey.success] as bool? ?? false,
      message: json[ApiKey.message] as String? ?? '',
      statusCode: (json[ApiKey.statusCode] as num?)?.toInt() ?? 0,
      data: (json[ApiKey.data] as List<dynamic>? ?? [])
          .map((e) => VideoData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class VideoData {
  final int id;
  final String name;
  final int sectionId;
  final String sectionName;
  final String videoUrl;
  final String coverUrl;
  final double duration;
  final String description;
  final bool isPaid;
  final int order;
  final String createdDate;
  final String updatedDate;

  VideoData({
    required this.id,
    required this.name,
    required this.sectionId,
    required this.sectionName,
    required this.videoUrl,
    required this.coverUrl,
    required this.duration,
    required this.description,
    required this.isPaid,
    required this.order,
    required this.createdDate,
    required this.updatedDate,
  });

  factory VideoData.fromJson(Map<String, dynamic> json) {
    return VideoData(
      id: (json[ApiKey.id] as num?)?.toInt() ?? 0,
      name: json[ApiKey.name] as String? ?? '',
      sectionId: (json[ApiKey.sectionId] as num?)?.toInt() ?? 0,
      sectionName: json[ApiKey.sectionName] as String? ?? '',
      videoUrl: json[ApiKey.videoUrl] as String? ?? '',
      coverUrl: json[ApiKey.coverUrl] as String? ?? '',
      duration: (json[ApiKey.duration] as num?)?.toDouble() ?? 0.0,
      description: json[ApiKey.description] as String? ?? '',
      isPaid: json[ApiKey.isPaid] as bool? ?? false,
      order: (json[ApiKey.order] as num?)?.toInt() ?? 0,
      createdDate: json[ApiKey.createdDate] as String? ?? '',
      updatedDate: json[ApiKey.updatedDate] as String? ?? '',
    );
  }
}
