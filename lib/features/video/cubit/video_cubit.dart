import 'package:bright_minds/core/api/end_point.dart';
import 'package:bright_minds/core/repository/video_repo/video_repo.dart';
import 'package:bright_minds/features/video/cubit/video_state.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class VideoCubit extends Cubit<VideoState> {
  final VideoRepo repo;

  VideoCubit(this.repo) : super(VideoInitial());

  late VideoPlayerController _videoController;
  late ChewieController _chewieController;
  final Map<int, String> selectedAnswers = {};

  Future<void> getVideos({required int sectionId}) async {
    emit(VideoLoading());
    final result = await repo.getVideos(sectionId);
    result.fold(
      (error) => emit(VideoFailure(error: error)),
      (video) => emit(VideoSuccess(video: video)),
    );
  }

  Future<void> initializeVideo(String url) async {
    try {
      _videoController = VideoPlayerController.networkUrl(Uri.parse(url));
      await _videoController.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoController,
        autoPlay: true,
        looping: false,
        allowFullScreen: true,
        allowPlaybackSpeedChanging: true,
      );

      emit(VideoChewieReady(
        chewieController: _chewieController,
      ));
    } catch (e) {
      emit(VideoError(error: e.toString()));
    }
  }

  Future<void> getQuiz({required int videoId}) async {
    emit(QuizLoading());
    final result = await repo.getQuiz(videoId);
    result.fold((error) => emit(QuizFailure(error: error)),
        (quiz) => emit(QuizSuccess(quiz: quiz)));
  }

  Future<void> submitAnswers(int quizId) async {
    emit(EvaluateLoading());

    final answersJson = selectedAnswers.entries
        .map((e) => {
              ApiKey.questionId: e.key,
              ApiKey.studentAnswer: e.value,
            })
        .toList();
    final result = await repo.postEvaluate(quizId: quizId, answer: answersJson);
    result.fold(
      (err) => emit(EvaluateFailure(error: err)),
      (evaluate) => emit(EvaluateSuccess(evaluate: evaluate)),
    );
  }

  void pauseVideo() {
    if (_videoController.value.isPlaying) {
      _videoController.pause();
    }
  }

  @override
  Future<void> close() {
    _chewieController.dispose();
    _videoController.dispose();
    return super.close();
  }
}
