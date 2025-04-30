import 'package:bright_minds/core/api/end_point.dart';

class ErrorModel {
  final List<String>? errors;
  final int statusCode;
  final String error;

  ErrorModel({
    this.errors,
    required this.statusCode,
    required this.error,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      errors: json[ApiKey.errors] != null
          ? List<String>.from(json[ApiKey.errors])
          : null,
      statusCode: json[ApiKey.statusCode],
      error: json[ApiKey.message],
    );
  }
}
