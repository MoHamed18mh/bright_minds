import 'package:bright_minds/core/api/api_consumer.dart';
import 'package:bright_minds/core/api/end_point.dart';
import 'package:bright_minds/core/api/errors/exception.dart';
import 'package:bright_minds/core/repository/video_repo/video_repo.dart';
import 'package:bright_minds/features/video/models/evaluate_model.dart';
import 'package:bright_minds/features/video/models/quiz_model.dart';
import 'package:bright_minds/features/video/models/video_model.dart';
import 'package:dartz/dartz.dart';

class VideoRepoImpl extends VideoRepo {
  final ApiConsumer api;
  VideoRepoImpl({required this.api});

  @override
  Future<Either<String, VideoModel>> getVideos(int sectionId) async {
    try {
      final response = await api.get(EndPoint.getVideos(sectionId));
      return Right(VideoModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errorModel.error);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, QuizModel>> getQuiz(int videoId) async {
    try {
      final response = await api.post(EndPoint.postQuiz, data: {
        ApiKey.title: videoId.toString(),
        ApiKey.videoId: videoId,
      });
      return Right(QuizModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errorModel.error);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, EvaluateModel>> postEvaluate(
      {required int quizId, required List<Map<String, dynamic>> answer}) async {
    try {
      final response = await api.post(EndPoint.postEvaluate, data: {
        ApiKey.quizId: quizId,
        ApiKey.quizAnswers: answer,
      });

      return Right(EvaluateModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.toString());
    } catch (e) {
      return const Left('eror');
    }
  }
}
