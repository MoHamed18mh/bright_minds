import 'package:bright_minds/core/functions/calc_padding.dart';
import 'package:bright_minds/core/functions/show_toast.dart';
import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:bright_minds/core/widgets/back_button.dart';
import 'package:bright_minds/core/widgets/container_shimmer.dart';
import 'package:bright_minds/features/profile/cubit/profile_cubit.dart';
import 'package:bright_minds/features/profile/cubit/profile_state.dart';
import 'package:bright_minds/features/profile/presentation/widgets/cart_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = calcPadding(context);

    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is CartFailure) {
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
                ),

                /// my courses
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    return SliverGrid.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 400,
                        mainAxisExtent: 110,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: (state is CartSuccess)
                          ? state.cart.data.items.length
                          : 3,
                      itemBuilder: (context, index) {
                        if (state is CartSuccess) {
                          return CartTile(course: state.cart.data.items[index]);
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
