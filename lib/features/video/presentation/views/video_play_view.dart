import 'package:bright_minds/core/functions/calc_padding.dart';
import 'package:bright_minds/core/functions/show_toast.dart';
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
            const SliverToBoxAdapter(child: SizedBox(height: 70)),
            SliverToBoxAdapter(
              child: BlocConsumer<VideoCubit, VideoState>(
                listener: (context, state) {
                  if (state is VideoError) {
                    showToast(msg: 'error, try later');
                  }
                },
                builder: (context, state) {
                  if (state is VideoChewieReady) {
                    return Chewie(controller: state.chewieController);
                  }

                  return Center(
                    child: Container(
                      color: Colors.grey,
                      width: double.infinity,
                      height: 250,
                    ),
                    // CircularProgressIndicator(color: AppColors.primaryColor),
                  );
                },
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 50)),

            
          ],
        ),
      ),
    );
  }
}
