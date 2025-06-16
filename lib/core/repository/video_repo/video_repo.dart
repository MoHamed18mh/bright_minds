import 'package:bright_minds/features/video/models/evaluate_model.dart';
import 'package:bright_minds/features/video/models/quiz_model.dart';
import 'package:bright_minds/features/video/models/video_model.dart';
import 'package:dartz/dartz.dart';

abstract class VideoRepo {
  Future<Either<String, VideoModel>> getVideos(int sectionId);

  Future<Either<String, QuizModel>> getQuiz(int videoId);

  Future<Either<String, EvaluateModel>> postEvaluate(
      {required int quizId, required List<Map<String, dynamic>> answer});
}
