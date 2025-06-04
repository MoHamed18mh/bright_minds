import 'package:bright_minds/core/repository/instructor_repo/instructor_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:bright_minds/core/api/api_consumer.dart';
import 'package:bright_minds/core/api/end_point.dart';
import 'package:bright_minds/core/api/errors/exception.dart';
import 'package:bright_minds/features/instructor/models/instructor_model.dart';

class InstructorRepoImpl implements InstructorRepo {
  final ApiConsumer api;

  InstructorRepoImpl({required this.api});

  @override
  Future<Either<String, InstructorModel>> getInstructors(
      {required int pageIndex, required int pageSize}) async {
    try {
      final response = await api.get(
        EndPoint.getInstructors,
        queryParameters: {
          ApiKey.qPageIndex: pageIndex,
          ApiKey.qPageSize: pageSize,
        },
      );
      return Right(InstructorModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errorModel.error);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
