import 'package:bright_minds/core/api/api_consumer.dart';
import 'package:bright_minds/core/api/end_point.dart';
import 'package:bright_minds/core/api/errors/exception.dart';
import 'package:bright_minds/features/instructor/cubit/instructor_state.dart';
import 'package:bright_minds/features/instructor/models/instructor_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InstructorCubit extends Cubit<InstructorState> {
  final ApiConsumer api;

  InstructorCubit(this.api) : super(InstructorInitial());

  Future<void> getInstructors() async {
    emit(InstructorLoading());
    try {
      final response = await api.get(EndPoint.getInstructors);
      emit(InstructorSuccess(instructor: InstructorModel.fromJson(response)));
    } on ServerException catch (e) {
      emit(InstructorFailure(error: e.errorModel.error));
    } catch (e) {
      emit(InstructorFailure(error: e.toString()));
    }
  }
}
