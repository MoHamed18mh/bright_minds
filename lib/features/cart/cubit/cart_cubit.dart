import 'package:bright_minds/core/api/api_consumer.dart';
import 'package:bright_minds/core/api/end_point.dart';
import 'package:bright_minds/core/api/errors/exception.dart';
import 'package:bright_minds/core/routes/deep_links.dart';
import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:bright_minds/features/cart/cubit/cart_state.dart';
import 'package:bright_minds/features/cart/model/cart_course_model.dart';
import 'package:bright_minds/features/cart/model/cart_model.dart';
import 'package:bright_minds/features/cart/model/checkout_model.dart';
import 'package:bright_minds/features/course/models/course_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class CartCubit extends Cubit<CartState> {
  final ApiConsumer api;

  CartCubit(this.api) : super(CartInitial());

  Future<void> getCart() async {
    emit(CartLoading());
    try {
      final response = await api.get(EndPoint.getCart);

      emit(CartSuccess(cart: CartModel.fromJson(response)));
    } on ServerException catch (e) {
      emit(CartFailure(error: e.errorModel.error));
    } catch (e) {
      emit(CartFailure(error: e.toString()));
    }
  }

  Future<void> deleteCart(int courseId) async {
    emit(DeleteCartLoading());
    try {
      await api.delete(EndPoint.deleteFromCart(courseId));
      emit(DeleteCartSuccess());

      await getCart();
    } on ServerException catch (e) {
      emit(DeleteCartFailure(error: e.errorModel.error));
    } catch (e) {
      emit(DeleteCartFailure(error: e.toString()));
    }
  }

  Future<void> getCartCourses(String courseId) async {
    emit(CartCourseLoading());
    try {
      final response = await api.get(EndPoint.getCourseWhitId(courseId));
      emit(CartCourseSucces(course: CartCourseModel.fromJson(response)));
    } on ServerException catch (e) {
      emit(CartCourseFailure(error: e.errorModel.error));
    } catch (e) {
      emit(CartCourseFailure(error: e.toString()));
    }
  }

  Future<void> checkOut(int cartId) async {
    emit(CheckoutLoading());
    try {
      final response = await api.post(
        EndPoint.postCheckOut,
        data: {
          ApiKey.basketId: cartId,
          ApiKey.paymentFailedUrl: DeepLinks.paymentFailure,
          ApiKey.paymentSucessUrl: DeepLinks.paymentSuccess,
        },
      );

      final checkout = CheckoutModel.fromJson(response);
      final uri = Uri.parse(checkout.url);

      /// open browser
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        emit(CheckoutFailure(error: '${AppStrings.couldNotLaunch} $uri'));
      }

      emit(CheckoutSucces());
      getCart();
    } on ServerException catch (e) {
      emit(CheckoutFailure(error: e.errorModel.error));
      getCart();
    } catch (e) {
      emit(CheckoutFailure(error: e.toString()));
      getCart();
    }
  }

  Future<void> getUserCourses() async {
    emit(UserCourseLoading());
    try {
      final response = await api.get(EndPoint.getUserCourses);

      emit(UserCourseSuccess(course: CourseModel.fromJson(response)));
    } on ServerException catch (e) {
      emit(UserCourseFailure(error: e.errorModel.error));
    } catch (e) {
      emit(UserCourseFailure(error: e.toString()));
    }
  }

  void submitFeedBack(int courseId, String trim, double rate) {}
}
