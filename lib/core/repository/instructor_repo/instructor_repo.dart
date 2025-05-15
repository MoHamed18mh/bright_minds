import 'package:dartz/dartz.dart';
import 'package:bright_minds/features/instructor/models/instructor_model.dart';

abstract class InstructorRepo {
  Future<Either<String, InstructorModel>> getInstructors();
}
