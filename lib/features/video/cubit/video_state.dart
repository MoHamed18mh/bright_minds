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
