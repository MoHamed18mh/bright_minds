// core/repository/auth_repo/auth_repo_impl.dart

import 'package:bright_minds/core/repository/auth_repo/auth_repo.dart';
import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:dartz/dartz.dart';
import 'package:bright_minds/core/api/api_consumer.dart';
import 'package:bright_minds/core/api/end_point.dart';
import 'package:bright_minds/core/api/errors/exception.dart';
import 'package:bright_minds/features/auth/models/login_model.dart';
import 'package:bright_minds/core/routes/deep_links.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiConsumer api;
  AuthRepoImpl({required this.api});

  @override
  Future<Either<String, LoginModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await api.post(
        EndPoint.postLogin,
        data: {ApiKey.email: email, ApiKey.password: password},
      );
      return Right(LoginModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errorModel.error);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String mobile,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      await api.post(
        EndPoint.postRegister,
        data: {
          ApiKey.rFirstName: firstName,
          ApiKey.rLastName: lastName,
          ApiKey.rEmail: email,
          ApiKey.rMobile: mobile,
          ApiKey.rPassword: password,
          ApiKey.rConfirmPass: confirmPassword,
        },
        isFormData: true,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(e.errorModel.errors.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> sendVerificationEmail({
    required String email,
  }) async {
    try {
      await api.post(
        EndPoint.postAuthentication,
        data: {
          ApiKey.email: email,
          ApiKey.clientUrl: DeepLinks.verify,
        },
      );
      return const Right(AppStrings.pleaseCheckEmail);
    } on ServerException catch (e) {
      return Left(e.errorModel.error);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> confirmEmail({
    required String email,
    required String token,
  }) async {
    try {
      await api.post(
        EndPoint.postConfirm,
        data: {
          ApiKey.email: email,
          ApiKey.token: token,
        },
      );
      return const Right(AppStrings.loginNow);
    } on ServerException catch (e) {
      return Left(e.errorModel.error);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> forgotPassword({
    required String email,
  }) async {
    try {
      await api.post(
        EndPoint.postForgotPass,
        data: {
          ApiKey.email: email,
          ApiKey.clientUrl: DeepLinks.resetPassword,
        },
      );
      return const Right(AppStrings.pleaseCheckEmail);
    } on ServerException catch (e) {
      return Left(e.errorModel.error);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> resetPassword({
    required String email,
    required String token,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      await api.post(
        EndPoint.postResetPass,
        data: {
          ApiKey.email: email,
          ApiKey.token: token,
          ApiKey.password: newPassword,
          ApiKey.confirmPass: confirmPassword,
        },
      );
      return const Right(AppStrings.loginNow);
    } on ServerException catch (e) {
      return Left(e.errorModel.error);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
