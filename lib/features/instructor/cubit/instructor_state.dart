import 'package:bright_minds/features/instructor/models/instructor_model.dart';
import 'package:equatable/equatable.dart';

abstract class InstructorState extends Equatable {
  const InstructorState();

  @override
  List<Object?> get props => [];
}

final class InstructorInitial extends InstructorState {}

final class InstructorLoading extends InstructorState {}

final class InstructorSuccess extends InstructorState {
  final List<InstructorItem> items;
  final int pageIndex;
  final bool hasReachedMax;
  final bool isLoadingMore;

  const InstructorSuccess({
    required this.items,
    required this.pageIndex,
    required this.hasReachedMax,
    required this.isLoadingMore,
  });

  InstructorSuccess copyWith({
    List<InstructorItem>? items,
    int? pageIndex,
    bool? hasReachedMax,
    bool? isLoadingMore,
  }) {
    return InstructorSuccess(
      items: items ?? this.items,
      pageIndex: pageIndex ?? this.pageIndex,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [items, pageIndex, hasReachedMax, isLoadingMore];
}

final class InstructorFailure extends InstructorState {
  final String error;
  final List<InstructorItem> previousItems;
  final int previousPageIndex;
  final bool hasReachedMax;

  const InstructorFailure({
    required this.error,
    required this.previousItems,
    required this.previousPageIndex,
    required this.hasReachedMax,
  });

  @override
  List<Object?> get props =>
      [error, previousItems, previousPageIndex, hasReachedMax];
}
