import 'package:bright_minds/features/course/models/course_model.dart';
import 'package:bright_minds/features/course/models/section_model.dart';
import 'package:bright_minds/features/course/models/video_model.dart';

class CourseState {}

final class CourseInitial extends CourseState {}

/// course states
final class CourseLoading extends CourseState {}

final class CourseSucces extends CourseState {
  final CourseModel course;
  CourseSucces({required this.course});
}

final class CourseFailure extends CourseState {
  final String error;
  CourseFailure({required this.error});
}

/// section states
final class SectionLoading extends CourseState {}

final class SectionSucces extends CourseState {
  final SectionModel section;
  SectionSucces({required this.section});
}

final class SectionFailure extends CourseState {
  final String error;
  SectionFailure({required this.error});
}

/// video states
final class VideoLoading extends CourseState {}

final class VideoSuccess extends CourseState {
  final VideoModel video;
  VideoSuccess({required this.video});
}

final class VideoFailure extends CourseState {
  final String error;
  VideoFailure({required this.error});
}
