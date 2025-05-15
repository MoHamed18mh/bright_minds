import 'package:bright_minds/core/functions/calc_padding.dart';
import 'package:bright_minds/core/functions/details_decoration.dart';
import 'package:bright_minds/core/functions/navigation.dart';
import 'package:bright_minds/core/functions/show_toast.dart';
import 'package:bright_minds/core/routes/route_keys.dart';
import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:bright_minds/core/utils/app_text_style.dart';
import 'package:bright_minds/core/widgets/back_button.dart';
import 'package:bright_minds/features/profile/cubit/profile_cubit.dart';
import 'package:bright_minds/features/profile/cubit/profile_state.dart';
import 'package:bright_minds/features/profile/presentation/widgets/forms/change_password_form.dart';
import 'package:bright_minds/features/profile/presentation/widgets/forms/edit_form.dart';
import 'package:bright_minds/features/profile/presentation/widgets/user_image_edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = calcPadding(context);
    final cubit = context.read<ProfileCubit>();

    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is EditUserSuccess) {
          showToast(msg: state.success);
          navigateAndRemoveUntil(context, RouteKeys.home);
        } else if (state is EditUserFailure) {
          showToast(msg: state.error);
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(
            margin: detailsMargin(padding),
            padding: detailsPadding(padding),
            decoration: detailsDecoration(),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      const BackButtonW(),
                      const Spacer(),

                      /// done edit button
                      BlocBuilder<ProfileCubit, ProfileState>(
                        builder: (_, state) {
                          if (state is EditUserLoading) {
                            return CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            );
                          }
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: InkWell(
                              onTap: () {
                                cubit.editUser();
                              },
                              child: Text(
                                AppStrings.done,
                                style: AppTextStyle.nunitoSansWhite,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 10)),

                /// user upload image
                const SliverToBoxAdapter(child: UserImageEdit()),
                const SliverToBoxAdapter(child: SizedBox(height: 18)),

                /// form of main user details
                const SliverToBoxAdapter(child: EditForm()),

                const SliverToBoxAdapter(child: Divider(thickness: 2)),
                const SliverToBoxAdapter(child: SizedBox(height: 10)),

                /// change password title section
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Text(
                        AppStrings.changePassword,
                        style: AppTextStyle.notoSerifPrimary
                            .copyWith(fontSize: 18),
                      ),
                      const Spacer(),
                      BlocBuilder<ProfileCubit, ProfileState>(
                        builder: (_, state) {
                          return IconButton(
                            onPressed: () => cubit.toggleMenu(),
                            icon: Icon(
                              (state is MenueVisible)
                                  ? Icons.expand_less
                                  : Icons.expand_more,
                              color: AppColors.primaryColor,
                              size: 33,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                /// change password fields
                SliverToBoxAdapter(
                  child: BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (_, state) {
                      final isVisible = state is MenueVisible;

                      return AnimatedSlide(
                          offset: isVisible ? Offset.zero : const Offset(-2, 0),
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeInOut,
                          child: const ChangePasswordForm());
                    },
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 8)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
