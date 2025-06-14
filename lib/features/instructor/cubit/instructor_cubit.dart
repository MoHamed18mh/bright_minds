import 'package:bright_minds/core/repository/instructor_repo/instructor_repo.dart';
import 'package:bright_minds/features/instructor/cubit/instructor_state.dart';
import 'package:bright_minds/features/instructor/models/instructor_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InstructorCubit extends Cubit<InstructorState> {
  final InstructorRepo repo;

  // page size for pagination
  static const int _pageSize = 10;

  InstructorCubit(this.repo) : super(InstructorInitial());

  Future<void> getInstructors() async {
    emit(InstructorLoading());

    final result = await repo.getInstructors(pageIndex: 1, pageSize: _pageSize);

    result.fold(
      (error) {
        emit(InstructorFailure(
          error: error,
          previousItems: const [],
          previousPageIndex: 0,
          hasReachedMax: false,
        ));
      },
      (instructor) {
        final items = instructor.data.items;
        final reachedMax = items.length < _pageSize;

        emit(InstructorSuccess(
          items: items,
          pageIndex: 1,
          hasReachedMax: reachedMax,
          isLoadingMore: false,
        ));
      },
    );
  }

  Future<void> loadMoreInstructors() async {
    final currentState = state;

    if (currentState is InstructorSuccess &&
        !currentState.hasReachedMax &&
        !currentState.isLoadingMore) {
      int nextPage = currentState.pageIndex + 1;

      emit(currentState.copyWith(isLoadingMore: true));

      final result =
          await repo.getInstructors(pageIndex: nextPage, pageSize: _pageSize);

      result.fold(
        (error) {
          emit(InstructorFailure(
            error: error,
            previousItems: currentState.items,
            previousPageIndex: currentState.pageIndex,
            hasReachedMax: currentState.hasReachedMax,
          ));
        },
        (instructor) {
          final newItems = instructor.data.items;
          final allItems = List<InstructorItem>.from(currentState.items)
            ..addAll(newItems);
          final reachedMax = newItems.length < _pageSize;

          emit(InstructorSuccess(
            items: allItems,
            pageIndex: nextPage,
            hasReachedMax: reachedMax,
            isLoadingMore: false,
          ));
        },
      );
    }
  }
}
