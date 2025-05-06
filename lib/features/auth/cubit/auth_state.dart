class AuthState {}

final class AuthInitial extends AuthState {}

/// password field state
final class ObscurePassword extends AuthState {}

/// login states
final class LoginLoading extends AuthState {}

final class LoginSuccess extends AuthState {}

final class LoginFailure extends AuthState {
  final String error;
  LoginFailure({required this.error});
}

/// register states
final class RegisterLoading extends AuthState {}

final class RegisterSuccess extends AuthState {}

final class RegisterFailure extends AuthState {
  final String error;
  RegisterFailure({required this.error});
}

/// confirm states
final class ConfirmLoading extends AuthState {}

final class ConfirmSuccess extends AuthState {}

final class ConfirmFailure extends AuthState {
  final String error;
  ConfirmFailure({required this.error});
}

/// Forgot states
final class ForgotLoading extends AuthState {}

final class ForgotSuccess extends AuthState {}

final class ForgotFailure extends AuthState {
  final String error;
  ForgotFailure({required this.error});
}

/// Reset states
final class ResetLoading extends AuthState {}

final class ResetSuccess extends AuthState {}

final class ResetFailure extends AuthState {
  final String error;
  ResetFailure({required this.error});
}
