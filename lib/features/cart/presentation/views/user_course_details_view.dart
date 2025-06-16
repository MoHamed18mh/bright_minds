import 'package:bright_minds/core/functions/calc_padding.dart';
import 'package:bright_minds/core/functions/navigation.dart';
import 'package:bright_minds/core/functions/show_toast.dart';
import 'package:bright_minds/core/routes/route_keys.dart';
import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:bright_minds/features/cart/model/user_course_model.dart';
import 'package:bright_minds/features/cart/presentation/widgets/show_feed_back_dialog.dart';
import 'package:bright_minds/features/course/cubit/course_cubit.dart';
import 'package:bright_minds/features/course/cubit/course_state.dart';
import 'package:bright_minds/features/course/presentation/widgets/chip.dart';
import 'package:bright_minds/features/course/presentation/widgets/course_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCourseDetailsView extends StatelessWidget {
  const UserCourseDetailsView({super.key, required this.course});

  final UserCourseItem course;

  @override
  Widget build(BuildContext context) {
    final padding = calcPadding(context);

    return BlocListener<CourseCubit, CourseState>(
      listener: (context, state) {
        if (state is FeedBackSuccess) {
          showToast(msg: state.success);
          navigatePop(context);
          navigateReplacement(context, RouteKeys.bag);
        } else if (state is FeedBackFailure) {
          showToast(msg: state.error);
          navigatePop(context);
          navigateReplacement(context, RouteKeys.bag);
        }
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: CustomScrollView(
            slivers: [
              /// course image
              SliverToBoxAdapter(
                child: CourseImage(
                  pictureUrl: course.pictureUrl,
                  courseName: course.name,
                  instructorName: course.instructorName,
                  rate: course.rate.toString(),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 22)),

              /// course description
              SliverToBoxAdapter(
                child: Text(
                  course.description,
                  style: AppTextStyle.nunitoSansBlack.copyWith(fontSize: 16),
                ),
              ),
              const SliverToBoxAdapter(
                child: Divider(
                  indent: 70,
                  endIndent: 70,
                  thickness: 2,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 22)),

              /// sections list
              BlocBuilder<CourseCubit, CourseState>(
                builder: (context, state) {
                  return SliverToBoxAdapter(
                    child: SizedBox(
                      height: 35,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: (state is SectionSuccess)
                            ? state.section.data.length
                            : 3,
                        itemBuilder: (context, index) {
                          if (state is SectionSuccess) {
                            return ChipW(
                              sectionName: state.section.data[index].name,
                              sectionId: state.section.data[index].id,
                            );
                          }
                          return Container();
                        },
                      ),
                    ),
                  );
                },
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 60)),
            ],
          ),
        ),

        /// feedback button
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(20),
          child: IconButton(
            onPressed: () {
              showFeedbackDialog(context, course.id);
            },
            icon: Icon(
              Icons.message_outlined,
              color: AppColors.primaryColor,
              size: 45,
            ),
          ),
        ),
      ),
    );
  }
}
