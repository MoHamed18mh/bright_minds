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
  final String firstName;
  final String lastName;
  final String imageCover;
  final String mobile;
  final double? walletBalance;
  final List<String>? roles;

  UserData({
    required this.id,
    required this.email,
    required this.displayName,
    required this.firstName,
    required this.lastName,
    required this.imageCover,
    required this.mobile,
    this.walletBalance,
    this.roles,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json[ApiKey.id],
      email: json[ApiKey.email],
      displayName: json[ApiKey.displayName],
      firstName: json[ApiKey.firstName],
      lastName: json[ApiKey.lastName],
      imageCover: json[ApiKey.imageCover],
      mobile: json[ApiKey.mobile],
      walletBalance: json[ApiKey.walletBalance] != null
          ? (json[ApiKey.walletBalance] as num).toDouble()
          : null,
      roles: (json[ApiKey.roles] as List?)?.map((e) => e.toString()).toList(),
    );
  }
}
