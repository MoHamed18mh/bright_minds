import 'package:bright_minds/core/repository/cart_repo/cart_repo.dart';
import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:bright_minds/features/cart/cubit/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo repo;

  CartCubit(this.repo) : super(CartInitial());

  Future<void> getCart() async {
    emit(CartLoading());
    final result = await repo.getCart();
    result.fold(
      (error) => emit(CartFailure(error: error)),
      (model) => emit(CartSuccess(cart: model)),
    );
  }

  Future<void> deleteFromCart(int courseId) async {
    emit(DeleteCartLoading());
    final result = await repo.deleteFromCart(courseId);
    result.fold(
      (error) => emit(DeleteCartFailure(error: error)),
      (_) async {
        emit(DeleteCartSuccess());
        await getCart();
      },
    );
  }

  Future<void> checkOut(int cartId) async {
    emit(CheckoutLoading());
    final result = await repo.checkOut(cartId);
    await result.fold(
      (error) async {
        emit(CheckoutFailure(error: error));
        getCart();
      },
      (url) async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
          emit(CheckoutSuccess());
        } else {
          emit(CheckoutFailure(error: '${AppStrings.couldNotLaunch} $uri'));
        }
        await getCart();
      },
    );
  }

  Future<void> getUserCourses() async {
    emit(UserCourseLoading());
    final result = await repo.getUserCourses();
    result.fold(
      (error) => emit(UserCourseFailure(error: error)),
      (model) => emit(UserCourseSuccess(course: model)),
    );
  }
}
