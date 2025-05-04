import 'package:bright_minds/core/api/end_point.dart';
import 'package:bright_minds/core/functions/calc_padding.dart';
import 'package:bright_minds/core/functions/details_decoration.dart';
import 'package:bright_minds/core/functions/navigation.dart';
import 'package:bright_minds/core/routes/route_keys.dart';
import 'package:bright_minds/core/utils/app_assets.dart';
import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:bright_minds/core/widgets/back_button.dart';
import 'package:bright_minds/core/widgets/container_shimmer.dart';
import 'package:bright_minds/features/profile/cubit/profile_cubit.dart';
import 'package:bright_minds/features/profile/cubit/profile_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyDetailsView extends StatelessWidget {
  const MyDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = calcPadding(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: detailsMargin(padding),
          padding: detailsPadding(padding),
          decoration: detailsDecoration(),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: BackButtonW()),
              const SliverToBoxAdapter(child: SizedBox(height: 12)),

              /// main details
              SliverToBoxAdapter(
                child: BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    if (state is UserSuccess) {
                      return Column(
                        children: [
                          /// user image
                          Container(
                            height: 140,
                            width: 140,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryColor,
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: (state.user.data.imageCover !=
                                      ApiKey.imageNull)
                                  ? CachedNetworkImage(
                                      imageUrl: state.user.data.imageCover,
                                      fit: BoxFit.cover,
                                      memCacheHeight: 300,
                                      placeholder: (context, url) =>
                                          const ContainerShimmer(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    )
                                  : Image.asset(
                                      Assets.assetsImagesUser,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          const SizedBox(height: 40),

                          /// user name
                          Text(
                            state.user.data.displayName,
                            style: AppTextStyle.nunitoSansBlack
                                .copyWith(fontSize: 22),
                          ),
                          const SizedBox(height: 10),

                          /// user email
                          Text(
                            state.user.data.email,
                            style: AppTextStyle.nunitoSansBlack
                                .copyWith(fontSize: 14),
                          ),
                          const SizedBox(height: 7),

                          /// user phone
                          Text(
                            state.user.data.mobile,
                            style: AppTextStyle.nunitoSansBlack
                                .copyWith(fontSize: 14),
                          ),
                          const SizedBox(height: 60),

                          /// edit button
                          Align(
                            alignment: Alignment.centerRight,
                            child: MaterialButton(
                              onPressed: () => navigate(
                                context,
                                RouteKeys.editProfile,
                                extra: state.user.data,
                              ),
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(16),
                              color: AppColors.primaryColor,
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      );
                    } else if (state is UserFailure) {
                      return Text(
                        state.error,
                        style: AppTextStyle.notoSerifPrimary
                            .copyWith(fontSize: 18),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    );
                  },
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 30)),
            ],
          ),
        ),
      ),
    );
  }
}
