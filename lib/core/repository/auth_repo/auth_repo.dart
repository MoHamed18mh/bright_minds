import 'package:dartz/dartz.dart';
import 'package:bright_minds/features/auth/models/login_model.dart';

abstract class AuthRepo {
  Future<Either<String, LoginModel>> login({
    required String email,
    required String password, 
  });

  Future<Either<String, void>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String mobile,
    required String password,
    required String confirmPassword,
  });

  Future<Either<String, String>> sendVerificationEmail({
    required String email,
  });

  Future<Either<String, String>> confirmEmail({
    required String email,
    required String token,
  });

  Future<Either<String, String>> forgotPassword({
    required String email,
  });

  Future<Either<String, String>> resetPassword({
    required String email,
    required String token,
    required String newPassword,
    required String confirmPassword,
  });
}
