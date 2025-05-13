import 'package:android_intent_plus/android_intent.dart';
import 'package:bright_minds/core/api/api_consumer.dart';
import 'package:bright_minds/core/api/end_point.dart';
import 'package:bright_minds/core/api/errors/exception.dart';
import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:bright_minds/features/course/cubit/course_state.dart';
import 'package:bright_minds/features/course/models/course_model.dart';
import 'package:bright_minds/features/course/models/section_model.dart';
import 'package:bright_minds/features/course/models/video_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseCubit extends Cubit<CourseState> {
  final ApiConsumer api;

  CourseCubit(this.api) : super(CourseInitial());

  Future<void> getCourses() async {
    emit(CourseLoading());
    try {
      final response = await api.get(EndPoint.getCourses);
      emit(CourseSucces(course: CourseModel.fromJson(response)));
    } on ServerException catch (e) {
      emit(CourseFailure(error: e.errorModel.error));
    } catch (e) {
      emit(CourseFailure(error: e.toString()));
    }
  }

  Future<void> getSections(int courseId) async {
    emit(SectionLoading());
    try {
      final response = await api.get(EndPoint.getSections(courseId));

      emit(SectionSucces(section: SectionModel.fromJson(response)));
    } on ServerException catch (e) {
      emit(SectionFailure(error: e.errorModel.error));
    } catch (e) {
      emit(SectionFailure(error: e.toString()));
    }
  }

  Future<void> getVideos(int sectionId) async {
    emit(VideoLoading());
    try {
      final response = await api.get(EndPoint.getVideos(sectionId));

      emit(VideoSuccess(video: VideoModel.fromJson(response)));
    } on ServerException catch (e) {
      emit(VideoFailure(error: e.errorModel.error));
    } catch (e) {
      emit(VideoFailure(error: e.toString()));
    }
  }

  void playVideo(String url) {
    AndroidIntent(
      data: url,
      action: 'action_view',
      type: 'video/mp4',
    ).launch();
  }

  Future<void> submitFeedBack(int courseId, String comment, double rate) async {
    emit(FeedBackLoading());
    try {
      await api.post(
        EndPoint.postFeedBack,
        data: {
          ApiKey.courseId: courseId,
          ApiKey.content: comment,
          ApiKey.rating: rate,
        },
      );
      emit(FeedBackSuccess(success: AppStrings.done));
    } on ServerException catch (e) {
      emit(FeedBackFailure(error: e.errorModel.errors.toString()));
    } catch (e) {
      emit(FeedBackFailure(error: e.toString()));
    }
  }

  Future<void> postAddCart(int courseId) async {
    emit(AddToCartLoading());
    try {
      await api.post(
        EndPoint.postAddToCart,
        data: {ApiKey.courseId: courseId},
      );
      emit(AddToCartSuccess(success: AppStrings.compleatPurchase));

      await getSections(courseId);
    } on ServerException catch (e) {
      emit(AddToCartFailure(error: e.errorModel.error));
    } catch (e) {
      emit(AddToCartFailure(error: e.toString()));
    }
  }
}
