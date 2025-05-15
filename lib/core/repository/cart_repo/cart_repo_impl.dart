import 'package:bright_minds/core/api/api_consumer.dart';
import 'package:bright_minds/core/api/end_point.dart';
import 'package:bright_minds/core/api/errors/exception.dart';
import 'package:bright_minds/core/repository/cart_repo/cart_repo.dart';
import 'package:bright_minds/core/routes/deep_links.dart';
import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:bright_minds/features/cart/model/cart_course_model.dart';
import 'package:bright_minds/features/cart/model/cart_model.dart';
import 'package:bright_minds/features/cart/model/checkout_model.dart';
import 'package:bright_minds/features/course/models/course_model.dart';
import 'package:dartz/dartz.dart';

class CartRepoImpl implements CartRepo {
  final ApiConsumer api;
  CartRepoImpl({required this.api});

  @override
  Future<Either<String, String>> addToCart(int courseId) async {
    try {
      await api.post(
        EndPoint.postAddToCart,
        data: {ApiKey.courseId: courseId},
      );
      return const Right(AppStrings.compleatPurchase);
    } on ServerException catch (e) {
      return Left(e.errorModel.error);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, CartModel>> getCart() async {
    try {
      final response = await api.get(EndPoint.getCart);
      return Right(CartModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errorModel.error);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> deleteFromCart(int courseId) async {
    try {
      await api.delete(EndPoint.deleteFromCart(courseId));
      return const Right(null);
    } on ServerException catch (e) {
      return Left(e.errorModel.error);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, CartCourseModel>> getCartCourseById(
      String courseId) async {
    try {
      final response = await api.get(EndPoint.getCourseWhitId(courseId));
      return Right(CartCourseModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errorModel.error);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> checkOut(int cartId) async {
    try {
      final response = await api.post(
        EndPoint.postCheckOut,
        data: {
          ApiKey.basketId: cartId,
          ApiKey.paymentFailedUrl: DeepLinks.paymentFailure,
          ApiKey.paymentSucessUrl: DeepLinks.paymentSuccess,
        },
      );
      final model = CheckoutModel.fromJson(response);
      return Right(model.url);
    } on ServerException catch (e) {
      return Left(e.errorModel.error);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, CourseModel>> getUserCourses() async {
    try {
      final response = await api.get(EndPoint.getUserCourses);
      return Right(CourseModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errorModel.error);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
