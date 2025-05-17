import 'package:bright_minds/core/functions/calc_padding.dart';
import 'package:bright_minds/core/functions/navigation.dart';
import 'package:bright_minds/core/functions/show_toast.dart';
import 'package:bright_minds/core/routes/route_keys.dart';
import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:bright_minds/core/widgets/back_button.dart';
import 'package:bright_minds/core/widgets/container_shimmer.dart';
import 'package:bright_minds/features/cart/cubit/cart_cubit.dart';
import 'package:bright_minds/features/cart/cubit/cart_state.dart';
import 'package:bright_minds/features/cart/presentation/widgets/user_course_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BagView extends StatelessWidget {
  const BagView({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = calcPadding(context);

    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        if (state is UserCourseFailure) {
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
                  title: Text(
                    AppStrings.myBag,
                    style: AppTextStyle.nunitoSansBlack,
                  ),
                  actions: [
                    /// cart button
                    IconButton(
                      onPressed: () => navigate(context, RouteKeys.cart),
                      icon: Icon(
                        Icons.shopping_cart_outlined,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),

                /// user courses
                BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    return SliverGrid.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 400,
                        mainAxisExtent: 110,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: (state is UserCourseSuccess)
                          ? state.course.data.items.length
                          : 3,
                      itemBuilder: (context, index) {
                        if (state is UserCourseSuccess) {
                          return UserCourseTile(
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
