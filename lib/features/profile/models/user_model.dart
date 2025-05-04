import 'package:bright_minds/core/api/end_point.dart';

class UserModel {
  final String message;
  final UserData data;

  UserModel({
    required this.message,
    required this.data,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      message: json[ApiKey.messaget],
      data: UserData.fromJson(json[ApiKey.data]),
    );
  }
}

class UserData {
  final String id;
  final String email;
  final String displayName;
  final String imageCover;
  final String mobile;
  final double waletBalance;
  final List<String>? roles;

  UserData({
    required this.id,
    required this.email,
    required this.displayName,
    required this.imageCover,
    required this.mobile,
    required this.waletBalance,
    this.roles,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json[ApiKey.id],
      email: json[ApiKey.email],
      displayName: json[ApiKey.displayName],
      imageCover: json[ApiKey.imageCover],
      mobile: json[ApiKey.mobile],
      waletBalance: (json[ApiKey.walletBalance] as num).toDouble(),
      roles: (json[ApiKey.roles] as List?)?.map((e) => e.toString()).toList(),
    );
  }
}
