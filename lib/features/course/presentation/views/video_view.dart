import 'package:bright_minds/core/functions/calc_padding.dart';
import 'package:bright_minds/core/functions/show_toast.dart';
import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:bright_minds/core/widgets/back_button.dart';
import 'package:bright_minds/core/widgets/container_shimmer.dart';
import 'package:bright_minds/features/course/cubit/course_cubit.dart';
import 'package:bright_minds/features/course/cubit/course_state.dart';
import 'package:bright_minds/features/course/presentation/widgets/video_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoView extends StatelessWidget {
  const VideoView({super.key, required this.sectionName});

  final String sectionName;

  @override
  Widget build(BuildContext context) {
    final padding = calcPadding(context);

    return BlocListener<CourseCubit, CourseState>(
      listener: (context, state) {
        if (state is VideoFailure) {
          showToast(msg: state.error);
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  leading: const BackButtonW(),
                  titleSpacing: 4,
                  title: Text(
                    sectionName,
                    style: AppTextStyle.nunitoSansBlack,
                  ),
                  backgroundColor: Colors.white,
                ),

                /// videos
                BlocBuilder<CourseCubit, CourseState>(
                  builder: (context, state) {
                    return SliverGrid.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 400,
                        mainAxisExtent: 110,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount:
                          (state is VideoSuccess) ? state.video.data.length : 3,
                      itemBuilder: (context, index) {
                        if (state is VideoSuccess) {
                          return VideoTile(video: state.video.data[index]);
                        }
                        return const ContainerShimmer();
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
