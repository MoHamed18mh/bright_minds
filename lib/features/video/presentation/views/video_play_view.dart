import 'package:bright_minds/core/functions/show_toast.dart';
import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/widgets/back_button.dart';
import 'package:bright_minds/features/video/cubit/video_cubit.dart';
import 'package:bright_minds/features/video/cubit/video_state.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoPlayView extends StatelessWidget {
  const VideoPlayView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// video player
          Padding(
            padding: const EdgeInsets.all(10),
            child: BlocConsumer<VideoCubit, VideoState>(
              listener: (context, state) {
                if (state is VideoError) {
                  showToast(msg: 'can not play on this device');
                }
              },
              builder: (context, state) {
                if (state is VideoChewieReady) {
                  return Chewie(controller: state.chewieController);
                }

                return Center(
                  child:
                      CircularProgressIndicator(color: AppColors.primaryColor),
                );
              },
            ),
          ),
          const Positioned(
            top: 15,
            left: 15,
            child: BackButtonW(),
          ),
        ],
      ),
    );
  }
}
