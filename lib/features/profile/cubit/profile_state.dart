import 'package:bright_minds/features/profile/models/user_model.dart';

class ProfileState {}

final class ProfileInitial extends ProfileState {}

///
final class ObscurePassword extends ProfileState {}

final class UpLoadUserImage extends ProfileState {}

/// user state
final class UserLoading extends ProfileState {}

final class UserSuccess extends ProfileState {
  final UserModel user;
  UserSuccess({required this.user});
}

final class UserFailure extends ProfileState {
  final String error;
  UserFailure({required this.error});
}

/// edit user state
final class EditUserLoading extends ProfileState {}

final class EditUserSuccess extends ProfileState {
  final String success;
  EditUserSuccess({required this.success});
}

final class EditUserFailure extends ProfileState {
  final String error;
  EditUserFailure({required this.error});
}

/// drop down menue
final class MenueVisible extends ProfileState {}

final class MenueNotVisible extends ProfileState {}

/// Delet states
final class DeleteLoading extends ProfileState {}

final class DeleteSuccess extends ProfileState {}

final class DeleteFailure extends ProfileState {
  final String error;
  DeleteFailure({required this.error});
}

/// Log out states
final class LogOutLoading extends ProfileState {}

final class LogOutSuccess extends ProfileState {}

final class LogOutFailure extends ProfileState {
  final String error;
  LogOutFailure({required this.error});
}
