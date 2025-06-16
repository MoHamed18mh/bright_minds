import 'package:bright_minds/core/repository/cart_repo/cart_repo.dart';
import 'package:bright_minds/core/repository/course_repo/course_repo.dart';
import 'package:bright_minds/features/course/cubit/course_state.dart';
import 'package:bright_minds/features/course/models/course_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseCubit extends Cubit<CourseState> {
  final CourseRepo courseRepo;
  final CartRepo cartRepo;

  // page size for pagination
  static const int _pageSize = 10;

  CourseCubit(this.courseRepo, this.cartRepo) : super(CourseInitial());

  Future<void> getCourses() async {
    emit(CourseLoading());
    final result =
        await courseRepo.getCourses(pageIndex: 1, pageSize: _pageSize);
    result.fold(
      (error) {
        emit(CourseFailure(
          error: error,
          previousItems: const [],
          previousPageIndex: 0,
          hasReachedMax: false,
        ));
      },
      (course) {
        final items = course.data.items;
        final reachedMax = items.length < _pageSize;

        emit(CourseSuccess(
          items: items,
          pageIndex: 1,
          hasReachedMax: reachedMax,
          isLoadingMore: false,
        ));
      },
    );
  }

  Future<void> loadMoreCourses() async {
    final currentState = state;

    if (currentState is CourseSuccess &&
        !currentState.hasReachedMax &&
        !currentState.isLoadingMore) {
      int nextPage = currentState.pageIndex + 1;

      emit(currentState.copyWith(isLoadingMore: true));

      final result =
          await courseRepo.getCourses(pageIndex: nextPage, pageSize: _pageSize);

      result.fold((error) {
        emit(CourseFailure(
          error: error,
          previousItems: currentState.items,
          previousPageIndex: currentState.pageIndex,
          hasReachedMax: currentState.hasReachedMax,
        ));
      }, (course) {
        final newItems = course.data.items;
        final allItems = List<CourseItem>.from(currentState.items)
          ..addAll(newItems);
        final reachedMax = newItems.length < _pageSize;

        emit(CourseSuccess(
            items: allItems,
            pageIndex: nextPage,
            hasReachedMax: reachedMax,
            isLoadingMore: false));
      });
    }
  }

  Future<void> getSections({required int courseId}) async {
    emit(SectionLoading());
    final result = await courseRepo.getSections(courseId);
    result.fold(
      (error) => emit(SectionFailure(error: error)),
      (model) => emit(SectionSuccess(section: model)),
    );
  }

  Future<void> submitFeedback(int courseId, String comment, double rate) async {
    emit(FeedBackLoading());
    final result = await courseRepo.submitFeedback(
      courseId: courseId,
      comment: comment,
      rating: rate,
    );
    result.fold(
      (error) => emit(FeedBackFailure(error: error)),
      (success) => emit(FeedBackSuccess(success: success)),
    );
  }

  Future<void> addToCart(int courseId) async {
    emit(AddToCartLoading());
    final result = await cartRepo.addToCart(courseId);
    result.fold(
      (error) => emit(AddToCartFailure(error: error)),
      (success) async {
        emit(AddToCartSuccess(success: success));
        await getSections(courseId: courseId);
      },
    );
  }
}
