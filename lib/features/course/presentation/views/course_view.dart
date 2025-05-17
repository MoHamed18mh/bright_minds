import 'package:bright_minds/core/functions/calc_padding.dart';
import 'package:bright_minds/core/functions/show_toast.dart';
import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:bright_minds/core/widgets/back_button.dart';
import 'package:bright_minds/core/widgets/container_shimmer.dart';
import 'package:bright_minds/core/widgets/screen_overview.dart';
import 'package:bright_minds/features/course/cubit/course_cubit.dart';
import 'package:bright_minds/features/course/cubit/course_state.dart';
import 'package:bright_minds/features/course/presentation/views/course_search_delegate.dart';
import 'package:bright_minds/features/course/presentation/widgets/course_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseView extends StatelessWidget {
  const CourseView({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = calcPadding(context);

    return BlocListener<CourseCubit, CourseState>(
      listener: (context, state) {
        if (state is CourseFailure) {
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
                  backgroundColor: Colors.white,
                  leading: const BackButtonW(),

                  /// search
                  actions: [
                    BlocBuilder<CourseCubit, CourseState>(
                      builder: (context, state) {
                        return IconButton(
                          onPressed: () {
                            showSearch(
                              context: context,
                              delegate: CourseSearchDelegate(
                                list: (state is CourseSuccess)
                                    ? state.course.data.items
                                    : [],
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.search,
                            color: AppColors.primaryColor,
                          ),
                        );
                      },
                    ),
                  ],
                  floating: true,
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),

                /// screen title
                const SliverToBoxAdapter(
                  child: ScreenOverview(
                    title: AppStrings.courses,
                    subTitle: AppStrings.popularCourses,
                  ),
                ),

                /// courses
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
                      itemCount: (state is CourseSuccess)
                          ? state.course.data.items.length
                          : 3,
                      itemBuilder: (context, index) {
                        if (state is CourseSuccess) {
                          return CourseTile(
                            course: state.course.data.items[index],
                          );
                        }
                        return const ContainerShimmer();
                      },
                    );
                  },
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 30)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
