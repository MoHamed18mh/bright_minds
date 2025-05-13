import 'package:bright_minds/core/functions/calc_padding.dart';
import 'package:bright_minds/core/functions/show_toast.dart';
import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:bright_minds/core/widgets/back_button.dart';
import 'package:bright_minds/core/widgets/container_shimmer.dart';
import 'package:bright_minds/features/cart/cubit/cart_cubit.dart';
import 'package:bright_minds/features/cart/cubit/cart_state.dart';
import 'package:bright_minds/features/cart/presentation/widgets/cart_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = calcPadding(context);
    int cartId = 0;

    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        if (state is CartFailure) {
          showToast(msg: state.error);
        } else if (state is CheckoutFailure) {
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
                    AppStrings.myCrt,
                    style: AppTextStyle.nunitoSansBlack,
                  ),
                  actions: [
                    /// total price of courses
                    BlocBuilder<CartCubit, CartState>(
                      builder: (context, state) {
                        if (state is CartSuccess) {
                          return Text(
                            '${state.cart.data.totalPrice}\$',
                            style: AppTextStyle.notoSerifPrimary
                                .copyWith(fontSize: 18),
                          );
                        }
                        return CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        );
                      },
                    ),
                  ],
                ),

                /// my courses
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
                      itemCount: (state is CartSuccess)
                          ? state.cart.data.items.length
                          : 3,
                      itemBuilder: (context, index) {
                        if (state is CartSuccess) {
                          final cart = state.cart.data;
                          cartId = cart.id;

                          return CartTile(cartCourse: cart.items[index]);
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

          /// buy button
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(20),
            child: BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                if (state is CheckoutLoading) {
                  return CircularProgressIndicator(
                      color: AppColors.primaryColor);
                }
                return FloatingActionButton.extended(
                  onPressed: () {
                    context.read<CartCubit>().checkOut(cartId);
                  },
                  backgroundColor: AppColors.primaryColor,
                  shape: const CircleBorder(),
                  label: Text(
                    AppStrings.buy,
                    style: AppTextStyle.nunitoSansWhite,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
