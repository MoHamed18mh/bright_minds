import 'package:bright_minds/features/video/models/evaluate_model.dart';
import 'package:bright_minds/features/video/models/quiz_model.dart';
import 'package:bright_minds/features/video/models/video_model.dart';
import 'package:chewie/chewie.dart';

class VideoState {}

final class VideoInitial extends VideoState {}

class VideoError extends VideoState {
  final String error;
  VideoError({required this.error});
}

class VideoChewieReady extends VideoState {
  final ChewieController chewieController;
  VideoChewieReady({required this.chewieController});
}

/// video state
final class VideoLoading extends VideoState {}

final class VideoFailure extends VideoState {
  final String error;
  VideoFailure({required this.error});
}

final class VideoSuccess extends VideoState {
  final VideoModel video;
  VideoSuccess({required this.video});
}

/// Quiz state
final class QuizLoading extends VideoState {}

final class QuizFailure extends VideoState {
  final String error;
  QuizFailure({required this.error});
}

final class QuizSuccess extends VideoState {
  final QuizModel quiz;
  QuizSuccess({required this.quiz});
}

/// evaluate state
class EvaluateLoading extends VideoState {}

class EvaluateSuccess extends VideoState {
  final EvaluateModel evaluate;
  EvaluateSuccess({required this.evaluate});
}

class EvaluateFailure extends VideoState {
  final String error;
  EvaluateFailure({required this.error});
}
