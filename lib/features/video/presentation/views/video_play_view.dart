import 'package:bright_minds/core/functions/calc_padding.dart';
import 'package:bright_minds/core/functions/navigation.dart';
import 'package:bright_minds/core/functions/show_toast.dart';
import 'package:bright_minds/core/routes/route_keys.dart';
import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:bright_minds/core/widgets/back_button.dart';
import 'package:bright_minds/core/widgets/material_button.dart';
import 'package:bright_minds/features/video/cubit/video_cubit.dart';
import 'package:bright_minds/features/video/cubit/video_state.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoPlayView extends StatelessWidget {
  final int videoId;

  const VideoPlayView({super.key, required this.videoId});

  @override
  Widget build(BuildContext context) {
    final padding = calcPadding(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              leading: BackButtonW(),
              floating: true,
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            BlocConsumer<VideoCubit, VideoState>(
              listener: (context, state) {
                if (state is VideoError) {
                  showToast(msg: 'error, try later');
                }
              },
              builder: (context, state) {
                if (state is VideoChewieReady) {
                  return SliverToBoxAdapter(
                    child: AspectRatio(
                        aspectRatio: state.chewieController
                            .videoPlayerController.value.aspectRatio,
                        child: Chewie(controller: state.chewieController)),
                  );
                }

                return SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ),
                );
              },
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 200)),
            SliverToBoxAdapter(
              child: MaterialButtonW(
                text: AppStrings.takeQuiz,
                onPressed: () {
                  context.read<VideoCubit>().pauseVideo();
                  navigate(context, RouteKeys.quiz, extra: videoId);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
