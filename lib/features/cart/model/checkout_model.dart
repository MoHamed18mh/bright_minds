import 'package:bright_minds/core/api/end_point.dart';

class CheckoutModel {
  final String message;
  final String url;

  CheckoutModel({
    required this.message,
    required this.url,
  });

  factory CheckoutModel.fromJson(Map<String, dynamic> json) {
    return CheckoutModel(
      message: json[ApiKey.message] as String,
      url: json[ApiKey.url] as String,
    );
  }
}
