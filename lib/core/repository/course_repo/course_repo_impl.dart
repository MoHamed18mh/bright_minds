import 'package:bright_minds/core/repository/course_repo/course_repo.dart';
import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:dartz/dartz.dart';
import 'package:bright_minds/core/api/api_consumer.dart';
import 'package:bright_minds/core/api/end_point.dart';
import 'package:bright_minds/core/api/errors/exception.dart';
import 'package:bright_minds/features/course/models/course_model.dart';
import 'package:bright_minds/features/course/models/section_model.dart';

class CourseRepoImpl implements CourseRepo {
  final ApiConsumer api;
  CourseRepoImpl({required this.api});

  @override
  Future<Either<String, CourseModel>> getCourses(
      {required int pageIndex, required int pageSize}) async {
    try {
      final response = await api.get(EndPoint.getCourses, queryParameters: {
        ApiKey.qPageIndex: pageIndex,
        ApiKey.qPageSize: pageSize,
      });
      return Right(CourseModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errorModel.error);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, SectionModel>> getSections(int courseId) async {
    try {
      final response = await api.get(EndPoint.getSections(courseId));
      return Right(SectionModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errorModel.error);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> submitFeedback({
    required int courseId,
    required String comment,
    required double rating,
  }) async {
    try {
      await api.post(
        EndPoint.postFeedBack,
        data: {
          ApiKey.courseId: courseId,
          ApiKey.content: comment,
          ApiKey.rating: rating,
        },
      );
      return const Right(AppStrings.done);
    } on ServerException catch (e) {
      return Left(e.errorModel.errors.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }
}
