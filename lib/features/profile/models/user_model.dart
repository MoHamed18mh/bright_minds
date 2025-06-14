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
      message: json[ApiKey.messaget] as String? ?? '',
      data: UserData.fromJson(json[ApiKey.data] as Map<String, dynamic>? ?? {}),
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
  final double walletBalance;
  final List<String> roles;

  UserData({
    required this.id,
    required this.email,
    required this.displayName,
    required this.firstName,
    required this.lastName,
    required this.imageCover,
    required this.mobile,
    required this.walletBalance,
    required this.roles,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json[ApiKey.id] as String? ?? '',
      email: json[ApiKey.email] as String? ?? '',
      displayName: json[ApiKey.displayName] as String? ?? '',
      firstName: json[ApiKey.firstName] as String? ?? '',
      lastName: json[ApiKey.lastName] as String? ?? '',
      imageCover: json[ApiKey.imageCover] as String? ?? '',
      mobile: json[ApiKey.mobile] as String? ?? '',
      walletBalance: (json[ApiKey.walletBalance] as num?)?.toDouble() ?? 0.0,
      roles: (json[ApiKey.roles] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }
}
