import 'package:bright_minds/core/functions/calc_padding.dart';
import 'package:bright_minds/core/functions/navigation.dart';
import 'package:bright_minds/core/functions/show_toast.dart';
import 'package:bright_minds/core/routes/route_keys.dart';
import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:bright_minds/features/cart/cubit/cart_cubit.dart';
import 'package:bright_minds/features/cart/cubit/cart_state.dart';
import 'package:bright_minds/features/course/presentation/widgets/chip.dart';
import 'package:bright_minds/features/course/presentation/widgets/course_image.dart';
import 'package:bright_minds/features/cart/model/cart_course_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCourseView extends StatelessWidget {
  const CartCourseView({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = calcPadding(context);

    return SafeArea(
      child: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is FeedBackSuccess) {
            showToast(msg: state.success);
            navigatePop(context);
            navigateReplacement(context, RouteKeys.cart);
          } else if (state is FeedBackFailure) {
            showToast(msg: state.error);
            navigatePop(context);
            navigateReplacement(context, RouteKeys.cart);
          }
        },
        builder: (context, state) {
          if (state is CartCourseSucces) {
            final CartCourseData course = state.course.data;

            return Scaffold(
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
                              sectionId: course.sections[index].id,
                            );
                          },
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 50)),

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
                  ],
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        },
      ),
    );
  }
}
