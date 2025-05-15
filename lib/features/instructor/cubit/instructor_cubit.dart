import 'package:bright_minds/core/repository/instructor_repo/instructor_repo.dart';
import 'package:bright_minds/features/instructor/cubit/instructor_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InstructorCubit extends Cubit<InstructorState> {
  final InstructorRepo repo;
  InstructorCubit(this.repo) : super(InstructorInitial());

  Future<void> getInstructors() async {
    emit(InstructorLoading());
    final result = await repo.getInstructors();
    result.fold(
      (error) => emit(InstructorFailure(error: error)),
      (model) => emit(InstructorSuccess(instructor: model)),
    );
  }
}
