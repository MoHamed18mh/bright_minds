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
      success: json[ApiKey.success],
      message: json[ApiKey.message],
      statusCode: json[ApiKey.statusCode],
      data: List<VideoData>.from(
          json[ApiKey.data].map((e) => VideoData.fromJson(e))),
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
    required this.createdDate,
    required this.updatedDate,
  });

  factory VideoData.fromJson(Map<String, dynamic> json) {
    return VideoData(
      id: json[ApiKey.id],
      name: json[ApiKey.name],
      sectionId: json[ApiKey.sectionId],
      sectionName: json[ApiKey.sectionName],
      videoUrl: json[ApiKey.videoUrl],
      coverUrl: json[ApiKey.coverUrl],
      duration: json[ApiKey.duration],
      description: json[ApiKey.description],
      createdDate: json[ApiKey.createdDate],
      updatedDate: json[ApiKey.updatedDate],
    );
  }
}
