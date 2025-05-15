import 'package:bright_minds/core/api/dio_consumer.dart';
import 'package:bright_minds/core/repository/auth_repo/auth_repo_impl.dart';
import 'package:bright_minds/core/repository/cart_repo/cart_repo_impl.dart';
import 'package:bright_minds/core/repository/course_repo/course_repo_impl.dart';
import 'package:bright_minds/core/repository/instructor_repo/instructor_repo_impl.dart';
import 'package:bright_minds/core/repository/profile_repo/profile_repo_impl.dart';
import 'package:bright_minds/core/services/service_locator.dart';
import 'package:bright_minds/features/auth/cubit/auth_cubit.dart';
import 'package:bright_minds/features/cart/cubit/cart_cubit.dart';
import 'package:bright_minds/features/course/cubit/course_cubit.dart';
import 'package:bright_minds/features/instructor/cubit/instructor_cubit.dart';
import 'package:bright_minds/features/profile/cubit/profile_cubit.dart';

final DioConsumer _dio = getIt<DioConsumer>();

AuthCubit createAuth() => AuthCubit(AuthRepoImpl(api: _dio));

CourseCubit createCourse() =>
    CourseCubit(CourseRepoImpl(api: _dio), CartRepoImpl(api: _dio));

InstructorCubit createInst() => InstructorCubit(InstructorRepoImpl(api: _dio));

ProfileCubit createProf() => ProfileCubit(ProfileRepoImpl(api: _dio));

CartCubit createCart() => CartCubit(CartRepoImpl(api: _dio));
