import 'package:bright_minds/features/profile/models/cart_model.dart';
import 'package:bright_minds/features/profile/models/course_cart_model.dart';
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

/// cart state
final class CartLoading extends ProfileState {}

final class CartSuccess extends ProfileState {
  final CartModel cart;
  CartSuccess({required this.cart});
}

final class CartFailure extends ProfileState {
  final String error;
  CartFailure({required this.error});
}

/// delete cart state
final class DeleteCartLoading extends ProfileState {}

final class DeleteCartSuccess extends ProfileState {}

final class DeleteCartFailure extends ProfileState {
  final String error;
  DeleteCartFailure({required this.error});
}

/// course cart states
final class CourseCartLoading extends ProfileState {}

final class CourseCartSucces extends ProfileState {
  final CourseCartModel course;
  CourseCartSucces({required this.course});
}

final class CourseCartFailure extends ProfileState {
  final String error;
  CourseCartFailure({required this.error});
}
