import 'package:bright_minds/core/api/end_point.dart';

class LoginModel {
  final String message;
  final String token;
  final User user;

  LoginModel({
    required this.message,
    required this.token,
    required this.user,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      message: json[ApiKey.message],
      token: json[ApiKey.token],
      user: User.fromJson(json[ApiKey.user]),
    );
  }
}

class User {
  final String email;
  final String displayName;

  User({
    required this.email,
    required this.displayName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json[ApiKey.email],
      displayName: json[ApiKey.displayName],
    );
  }
}
