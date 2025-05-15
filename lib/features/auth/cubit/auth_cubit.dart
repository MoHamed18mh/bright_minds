import 'package:bright_minds/core/api/end_point.dart';
import 'package:bright_minds/core/database/cache_helper.dart';
import 'package:bright_minds/core/database/cache_key.dart';
import 'package:bright_minds/core/repository/auth_repo/auth_repo.dart';
import 'package:bright_minds/core/services/service_locator.dart';
import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:bright_minds/features/auth/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo repo;

  AuthCubit(this.repo) : super(AuthInitial());

  /// login keys
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  TextEditingController emailLoginController = TextEditingController();
  TextEditingController passwordLoginController = TextEditingController();

  // register keys
  GlobalKey<FormState> registerKey = GlobalKey<FormState>();
  TextEditingController firstNameRegController = TextEditingController();
  TextEditingController lastNameRegController = TextEditingController();
  TextEditingController emailRegController = TextEditingController();
  TextEditingController mobileRegController = TextEditingController();
  TextEditingController passRegController = TextEditingController();
  TextEditingController confirmRegController = TextEditingController();

  // forgot keys
  GlobalKey<FormState> forgotKey = GlobalKey<FormState>();
  TextEditingController emailForgotController = TextEditingController();

  // forgot keys
  GlobalKey<FormState> resetKey = GlobalKey<FormState>();
  TextEditingController passResetController = TextEditingController();
  TextEditingController confirmResetController = TextEditingController();

  Future<void> login() async {
    if (loginKey.currentState?.validate() != true) return;

    emit(LoginLoading());
    final result = await repo.login(
      email: emailLoginController.text.trim(),
      password: passwordLoginController.text.trim(),
    );

    result.fold(
      (error) => emit(LoginFailure(error: error)),
      (model) async {
        final decodedToken = JwtDecoder.decode(model.token);

        /// stord token and user id
        await getIt<CacheHelper>().saveData(
          key: CacheKey.token,
          value: model.token,
        );
        await getIt<CacheHelper>().saveData(
          key: CacheKey.userId,
          value: decodedToken[ApiKey.idSchema],
        );
        emit(LoginSuccess(
            success: '${AppStrings.wellcom} ${model.user.displayName}'));
      },
    );
  }

  Future<void> register() async {
    if (registerKey.currentState?.validate() != true) return;

    emit(RegisterLoading());
    final result = await repo.register(
      firstName: firstNameRegController.text.trim(),
      lastName: lastNameRegController.text.trim(),
      email: emailRegController.text.trim(),
      mobile: mobileRegController.text.trim(),
      password: passRegController.text.trim(),
      confirmPassword: confirmRegController.text.trim(),
    );

    await result.fold(
      (error) async => emit(RegisterFailure(error: error)),
      (_) async {
        final sendRes = await repo.sendVerificationEmail(
          email: emailRegController.text.trim(),
        );

        sendRes.fold(
          (error) => emit(RegisterFailure(error: error)),
          (success) => emit(RegisterSuccess(success: success)),
        );
      },
    );
  }

  Future<void> confirmEmail(String email, String token) async {
    emit(ConfirmLoading());
    final result = await repo.confirmEmail(email: email, token: token);
    result.fold(
      (error) => emit(ConfirmFailure(error: error)),
      (success) async {
        await getIt<CacheHelper>().saveData(key: CacheKey.token, value: token);
        emit(ConfirmSuccess(success: success));
      },
    );
  }

  Future<void> forgotPassword() async {
    if (forgotKey.currentState?.validate() != true) return;

    emit(ForgotLoading());
    final result =
        await repo.forgotPassword(email: emailForgotController.text.trim());
    result.fold(
      (error) => emit(ForgotFailure(error: error)),
      (success) => emit(ForgotSuccess(success: success)),
    );
  }

  Future<void> resetPass(String email, String token) async {
    if (resetKey.currentState?.validate() != true) return;

    emit(ResetLoading());
    final result = await repo.resetPassword(
      email: email,
      token: token,
      newPassword: passResetController.text.trim(),
      confirmPassword: confirmResetController.text.trim(),
    );
    result.fold(
      (error) => emit(ResetFailure(error: error)),
      (success) => emit(ResetSuccess(success: success)),
    );
  }

  /// prefill email field
  void prefillEmail(String email) {
    emailLoginController.text = email;
  }

  /// dispose controllers
  @override
  Future<void> close() {
    emailLoginController.dispose();
    passwordLoginController.dispose();
    firstNameRegController.dispose();
    lastNameRegController.dispose();
    emailRegController.dispose();
    mobileRegController.dispose();
    passRegController.dispose();
    confirmRegController.dispose();
    emailForgotController.dispose();
    passResetController.dispose();
    confirmResetController.dispose();
    return super.close();
  }
}
