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

final class EditUserSuccess extends ProfileState {}

final class EditUserFailure extends ProfileState {
  final String error;
  EditUserFailure({required this.error});
}

/// drop down menue
final class MenueVisible extends ProfileState {}

final class MenueNotVisible extends ProfileState {}
