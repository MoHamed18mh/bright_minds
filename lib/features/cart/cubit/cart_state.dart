import 'package:bright_minds/features/cart/model/cart_course_model.dart';
import 'package:bright_minds/features/cart/model/cart_model.dart';

class CartState {}

final class CartInitial extends CartState {}

/// cart state
final class CartLoading extends CartState {}

final class CartSuccess extends CartState {
  final CartModel cart;
  CartSuccess({required this.cart});
}

final class CartFailure extends CartState {
  final String error;
  CartFailure({required this.error});
}

/// delete cart state
final class DeleteCartLoading extends CartState {}

final class DeleteCartSuccess extends CartState {}

final class DeleteCartFailure extends CartState {
  final String error;
  DeleteCartFailure({required this.error});
}

/// course cart states
final class CartCourseLoading extends CartState {}

final class CartCourseSucces extends CartState {
  final CartCourseModel course;
  CartCourseSucces({required this.course});
}

final class CartCourseFailure extends CartState {
  final String error;
  CartCourseFailure({required this.error});
}

/// course cart states
final class CheckoutLoading extends CartState {}

final class CheckoutSucces extends CartState {}

final class CheckoutFailure extends CartState {
  final String error;
  CheckoutFailure({required this.error});
}

/// feed back states
final class FeedBackLoading extends CartState {}

final class FeedBackSuccess extends CartState {
  final String success;
  FeedBackSuccess({required this.success});
}

final class FeedBackFailure extends CartState {
  final String error;
  FeedBackFailure({required this.error});
}
