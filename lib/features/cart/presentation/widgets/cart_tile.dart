import 'package:bright_minds/core/functions/show_toast.dart';
import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:bright_minds/core/widgets/container_shimmer.dart';
import 'package:bright_minds/features/cart/cubit/cart_cubit.dart';
import 'package:bright_minds/features/cart/cubit/cart_state.dart';
import 'package:bright_minds/features/cart/model/cart_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartTile extends StatelessWidget {
  const CartTile({super.key, required this.cartCourse});
  final CartItem cartCourse;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();

    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        if (state is DeleteCartFailure) {
          showToast(msg: state.error);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryHighLight,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(width: 1, color: AppColors.primaryColor),
        ),
        child: Row(
          children: [
            /// course image
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl: cartCourse.imageUrl,
                height: 120,
                width: 100,
                memCacheHeight: 300,
                fit: BoxFit.cover,
                placeholder: (context, url) => const ContainerShimmer(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// course name
                    SelectableText(
                      cartCourse.courseName,
                      style:
                          AppTextStyle.nunitoSansBlack.copyWith(fontSize: 22),
                      maxLines: 1,
                    ),

                    /// course price
                    Text(
                      '${cartCourse.price} \$',
                      style:
                          AppTextStyle.notoSerifPrimary.copyWith(fontSize: 20),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),

                    /// delete button
                    BlocBuilder<CartCubit, CartState>(
                      builder: (context, state) {
                        if (state is DeleteCartLoading) {
                          return CircularProgressIndicator(
                              color: AppColors.primaryColor);
                        }
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            onTap: () => cubit.deleteFromCart(cartCourse.id),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                AppStrings.delete,
                                style: AppTextStyle.nunitoSansWhite
                                    .copyWith(fontSize: 14),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
