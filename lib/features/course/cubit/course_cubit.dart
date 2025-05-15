import 'package:android_intent_plus/android_intent.dart';
import 'package:bright_minds/core/repository/cart_repo/cart_repo.dart';
import 'package:bright_minds/core/repository/course_repo/course_repo.dart';
import 'package:bright_minds/features/course/cubit/course_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseCubit extends Cubit<CourseState> {
  final CourseRepo courseRepo;
  final CartRepo cartRepo;
  CourseCubit(this.courseRepo, this.cartRepo) : super(CourseInitial());

  Future<void> getCourses() async {
    emit(CourseLoading());
    final result = await courseRepo.getCourses();
    result.fold(
      (err) => emit(CourseFailure(error: err)),
      (model) => emit(CourseSuccess(course: model)),
    );
  }

  Future<void> getSections(int courseId) async {
    emit(SectionLoading());
    final result = await courseRepo.getSections(courseId);
    result.fold(
      (error) => emit(SectionFailure(error: error)),
      (model) => emit(SectionSuccess(section: model)),
    );
  }

  Future<void> getVideos(int sectionId) async {
    emit(VideoLoading());
    final result = await courseRepo.getVideos(sectionId);
    result.fold(
      (error) => emit(VideoFailure(error: error)),
      (model) => emit(VideoSuccess(video: model)),
    );
  }

  void playVideo(String url) {
    AndroidIntent(
      data: url,
      action: 'action_view',
      type: 'video/mp4',
    ).launch();
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
        await getSections(courseId);
      },
    );
  }
}
