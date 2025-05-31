import 'package:bright_minds/features/video/cubit/video_state.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class VideoCubit extends Cubit<VideoState> {
  final String url;

  VideoCubit(this.url) : super(VideoInitial()) {
    initialize();
  }

  late VideoPlayerController _videoController;
  late ChewieController _chewieController;

  Future<void> initialize() async {
    try {
      _videoController = VideoPlayerController.networkUrl(Uri.parse(url));
      await _videoController.initialize();

      // إنشاء ChewieController بعد تهيئة VideoPlayerController
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

  @override
  Future<void> close() {
    _chewieController.dispose();
    _videoController.dispose();
    return super.close();
  }
}
