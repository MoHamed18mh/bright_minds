import 'package:dartz/dartz.dart';
import 'package:bright_minds/features/course/models/course_model.dart';
import 'package:bright_minds/features/course/models/section_model.dart';
import 'package:bright_minds/features/course/models/video_model.dart';

abstract class CourseRepo {
  Future<Either<String, CourseModel>> getCourses();

  Future<Either<String, SectionModel>> getSections(int courseId);

  Future<Either<String, VideoModel>> getVideos(int sectionId);

  Future<Either<String, String>> submitFeedback({
    required int courseId,
    required String comment,
    required double rating,
  });
}
