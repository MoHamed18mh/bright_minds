import 'package:bright_minds/features/instructor/models/instructor_model.dart';

class InstructorState {}

final class InstructorInitial extends InstructorState {}

final class InstructorLoading extends InstructorState {}

final class InstructorSuccess extends InstructorState {
  final InstructorModel instructor;
  InstructorSuccess({required this.instructor});
}

final class InstructorFailure extends InstructorState {
  final String error;
  InstructorFailure({required this.error});
}
