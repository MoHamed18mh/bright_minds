import 'package:bright_minds/core/functions/calc_padding.dart';
import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:bright_minds/core/widgets/material_button.dart';
import 'package:bright_minds/features/course/presentation/widgets/chip.dart';
import 'package:bright_minds/features/course/presentation/widgets/course_image.dart';
import 'package:bright_minds/features/profile/cubit/profile_cubit.dart';
import 'package:bright_minds/features/profile/cubit/profile_state.dart';
import 'package:bright_minds/features/profile/models/course_cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCourseView extends StatelessWidget {
  const CartCourseView({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = calcPadding(context);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is CourseCartSucces) {
                final CourseDetail course = state.course.data;

                return CustomScrollView(
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
                        style:
                            AppTextStyle.nunitoSansBlack.copyWith(fontSize: 16),
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
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 35,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: course.sections.length,
                          itemBuilder: (context, index) {
                            return ChipW(
                              sectionName: course.sections[index].name,
                              sectionId: course.id,
                            );
                          },
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 60)),

                    /// price
                    SliverToBoxAdapter(
                      child: Text.rich(
                        TextSpan(
                          text: '${AppStrings.price}:',
                          style: AppTextStyle.nunitoSansBlack
                              .copyWith(fontSize: 22),
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
                    const SliverToBoxAdapter(child: SizedBox(height: 10)),

                    /// buy button
                    SliverToBoxAdapter(
                      child: MaterialButtonW(
                        text: AppStrings.buyNow,
                        onPressed: () {},
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 7)),
                  ],
                );
              }
              return Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              );
            },
          ),
        ),
      ),
    );
  }
}
