import 'package:bright_minds/core/api/api_consumer.dart';
import 'package:bright_minds/core/api/end_point.dart';
import 'package:bright_minds/core/api/errors/exception.dart';
import 'package:bright_minds/core/database/cache_helper.dart';
import 'package:bright_minds/core/database/cache_key.dart';
import 'package:bright_minds/core/routes/deep_links.dart';
import 'package:bright_minds/core/services/service_locator.dart';
import 'package:bright_minds/features/auth/cubit/auth_state.dart';
import 'package:bright_minds/features/auth/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthCubit extends Cubit<AuthState> {
  final ApiConsumer api;

  AuthCubit(this.api) : super(AuthInitial());

  /// text form field password obscure
  bool obscurePasswordValue = true;

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

  ///  change the value of obscurePasswordValue
  void changeObscurePasswordValue() {
    obscurePasswordValue = !obscurePasswordValue;
    emit(ObscurePassword());
  }

  /// login function
  Future<void> login() async {
    emit(LoginLoading());
    try {
      final response = await api.post(
        EndPoint.postLogin,
        data: {
          ApiKey.email: emailLoginController.text,
          ApiKey.password: passwordLoginController.text,
        },
      );
      final loginModel = LoginModel.fromJson(response);
      final decodedToken = JwtDecoder.decode(loginModel.token);

      /// stord token
      await getIt<CacheHelper>()
          .saveData(key: CacheKey.token, value: loginModel.token);
      await getIt<CacheHelper>()
          .saveData(key: CacheKey.userId, value: decodedToken[ApiKey.idSchema]);

      emit(LoginSuccess());
    } on ServerException catch (e) {
      emit(LoginFailure(error: e.errorModel.error));
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }

  /// register function
  Future<void> register() async {
    emit(RegisterLoading());
    try {
      await api.post(
        EndPoint.postRegister,
        data: {
          ApiKey.rFirstName: firstNameRegController.text,
          ApiKey.rLastName: lastNameRegController.text,
          ApiKey.rEmail: emailRegController.text,
          ApiKey.rMobile: mobileRegController.text,
          ApiKey.rPassword: passRegController.text,
          ApiKey.rConfirmPass: confirmRegController.text,
        },
        isFormData: true,
      );

      await api.post(
        EndPoint.postAuthentication,
        data: {
          ApiKey.email: emailRegController.text,
          ApiKey.clientUrl: DeepLinks.verify,
        },
      );

      emit(RegisterSuccess());
    } on ServerException catch (e) {
      emit(RegisterFailure(error: e.errorModel.errors.toString()));
    } catch (e) {
      emit(RegisterFailure(error: e.toString()));
    }
  }

  /// confirm email
  Future<void> confirm(String email, String token) async {
    try {
      emit(ConfirmLoading());
      await api.post(
        EndPoint.postConfirm,
        data: {
          ApiKey.email: email,
          ApiKey.token: token,
        },
      );

      /// store token
      await getIt<CacheHelper>().saveData(key: CacheKey.token, value: token);

      emit(ConfirmSuccess());
    } on ServerException catch (e) {
      emit(ConfirmFailure(error: e.errorModel.error));
    } catch (e) {
      emit(ConfirmFailure(error: e.toString()));
    }
  }

  /// forgot password
  Future<void> forgotPassword() async {
    emit(ForgotLoading());
    try {
      await api.post(
        EndPoint.postForgotPass,
        data: {
          ApiKey.email: emailForgotController.text,
          ApiKey.clientUrl: DeepLinks.resetPassword,
        },
      );
      emit(ForgotSuccess());
    } on ServerException catch (e) {
      emit(ForgotFailure(error: e.errorModel.error));
    } catch (e) {
      emit(ForgotFailure(error: e.toString()));
    }
  }

  /// reset password
  Future<void> resetPass(String email, String token) async {
    emit(ResetLoading());
    try {
      await api.post(
        EndPoint.postResetPass,
        data: {
          ApiKey.email: email,
          ApiKey.token: token,
          ApiKey.password: passResetController.text,
          ApiKey.confirmPass: confirmResetController.text,
        },
      );
      emit(ResetSuccess());
    } on ServerException catch (e) {
      emit(ResetFailure(error: e.errorModel.error));
    } catch (e) {
      emit(ResetFailure(error: e.toString()));
    }
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
