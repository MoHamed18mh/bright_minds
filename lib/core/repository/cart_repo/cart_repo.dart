import 'package:bright_minds/features/cart/model/cart_model.dart';
import 'package:bright_minds/features/cart/model/user_course_model.dart';
import 'package:dartz/dartz.dart';

abstract class CartRepo {
  Future<Either<String, String>> addToCart(int courseId);

  Future<Either<String, CartModel>> getCart();

  Future<Either<String, void>> deleteFromCart(int courseId);

  Future<Either<String, String>> checkOut(int cartId);

  Future<Either<String, UserCoursesModel>> getUserCourses();
}
