import 'package:bright_minds/features/course/models/course_model.dart';
import 'package:bright_minds/features/course/models/section_model.dart';
import 'package:equatable/equatable.dart';

abstract class CourseState extends Equatable {
  const CourseState();

  @override
  List<Object?> get props => [];
}

final class CourseInitial extends CourseState {}

/// course states
final class CourseLoading extends CourseState {}

final class CourseSuccess extends CourseState {
  final List<CourseItem> items;
  final int pageIndex;
  final bool hasReachedMax;
  final bool isLoadingMore;

  const CourseSuccess({
    required this.items,
    required this.pageIndex,
    required this.hasReachedMax,
    required this.isLoadingMore,
  });

  CourseSuccess copyWith({
    List<CourseItem>? items,
    int? pageIndex,
    bool? hasReachedMax,
    bool? isLoadingMore,
  }) {
    return CourseSuccess(
      items: items ?? this.items,
      pageIndex: pageIndex ?? this.pageIndex,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [items, pageIndex, hasReachedMax, isLoadingMore];
}

final class CourseFailure extends CourseState {
  final String error;
  final List<CourseItem> previousItems;
  final int previousPageIndex;
  final bool hasReachedMax;

  const CourseFailure({
    required this.error,
    required this.previousItems,
    required this.previousPageIndex,
    required this.hasReachedMax,
  });

  @override
  List<Object?> get props =>
      [error, previousItems, previousPageIndex, hasReachedMax];
}

/// section states
final class SectionLoading extends CourseState {}

final class SectionSuccess extends CourseState {
  final SectionModel section;
  const SectionSuccess({required this.section});
}

final class SectionFailure extends CourseState {
  final String error;
  const SectionFailure({required this.error});
}

/// Cart states
final class AddToCartLoading extends CourseState {}

final class AddToCartSuccess extends CourseState {
  final String success;
  const AddToCartSuccess({required this.success});
}

final class AddToCartFailure extends CourseState {
  final String error;
  const AddToCartFailure({required this.error});
}

/// Cart states
final class FeedBackLoading extends CourseState {}

final class FeedBackSuccess extends CourseState {
  final String success;
  const FeedBackSuccess({required this.success});
}

final class FeedBackFailure extends CourseState {
  final String error;
  const FeedBackFailure({required this.error});
}
