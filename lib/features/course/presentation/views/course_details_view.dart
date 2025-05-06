import 'package:bright_minds/core/functions/calc_padding.dart';
import 'package:bright_minds/core/functions/show_toast.dart';
import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:bright_minds/core/widgets/material_button.dart';
import 'package:bright_minds/features/course/cubit/course_cubit.dart';
import 'package:bright_minds/features/course/cubit/course_state.dart';
import 'package:bright_minds/features/course/models/course_model.dart';
import 'package:bright_minds/features/course/presentation/widgets/chip.dart';
import 'package:bright_minds/features/course/presentation/widgets/course_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseDetailsView extends StatelessWidget {
  const CourseDetailsView({super.key, required this.course});

  final CourseItem course;

  @override
  Widget build(BuildContext context) {
    final padding = calcPadding(context);
    final cubit = context.read<CourseCubit>();

    return BlocListener<CourseCubit, CourseState>(
      listener: (context, state) {
        if (state is CartSuccess) {
          showToast(msg: AppStrings.done);
        } else if (state is CartFailure) {
          showToast(msg: state.error);
        }
      },
      child: SafeArea(
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
                          itemCount: (state is SectionSucces)
                              ? state.section.data.length
                              : 3,
                          itemBuilder: (context, index) {
                            if (state is SectionSucces) {
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

                /// price
                SliverToBoxAdapter(
                  child: Text.rich(
                    TextSpan(
                      text: '${AppStrings.price}: ',
                      style:
                          AppTextStyle.nunitoSansBlack.copyWith(fontSize: 22),
                      children: [
                        TextSpan(
                          text: '${course.price} \$',
                          style: AppTextStyle.notoSerifPrimary
                              .copyWith(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 12)),

                /// bag button
                SliverToBoxAdapter(
                  child: BlocBuilder<CourseCubit, CourseState>(
                    builder: (context, state) {
                      if (state is CartLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                              color: AppColors.primaryColor),
                        );
                      }
                      return MaterialButtonW(
                        text: AppStrings.addToBag,
                        onPressed: () => cubit.postAddCart(course.id),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
