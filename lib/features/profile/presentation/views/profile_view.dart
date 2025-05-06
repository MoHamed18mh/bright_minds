import 'package:bright_minds/core/functions/calc_padding.dart';
import 'package:bright_minds/core/functions/navigation.dart';
import 'package:bright_minds/core/functions/show_toast.dart';
import 'package:bright_minds/core/routes/route_keys.dart';
import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:bright_minds/core/widgets/back_button.dart';
import 'package:bright_minds/features/profile/cubit/profile_cubit.dart';
import 'package:bright_minds/features/profile/cubit/profile_state.dart';
import 'package:bright_minds/features/profile/presentation/widgets/profile_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = calcPadding(context);
    final cubit = context.read<ProfileCubit>();

    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is LogOutSuccess) {
          navigateAndRemoveUntil(context, RouteKeys.login);
        } else if (state is LogOutFailure) {
          showToast(msg: state.error);
        } else if (state is DeleteSuccess) {
          navigateAndRemoveUntil(context, RouteKeys.register);
        } else if (state is DeleteFailure) {
          showToast(msg: state.error);
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(child: BackButtonW()),
                const SliverToBoxAdapter(child: SizedBox(height: 70)),

                /// details screen
                SliverToBoxAdapter(
                  child: ProfileTile(
                    iconData: Icons.badge_outlined,
                    itemTitle: AppStrings.myDetails,
                    onTap: () => navigate(context, RouteKeys.myDetails),
                  ),
                ),

                // cart screen
                SliverToBoxAdapter(
                  child: ProfileTile(
                    iconData: Icons.backpack_outlined,
                    itemTitle: AppStrings.myBag,
                    onTap: () => navigate(context, RouteKeys.cart),
                  ),
                ),

                // log out button
                SliverToBoxAdapter(
                  child: ProfileTile(
                    iconData: Icons.logout_rounded,
                    itemTitle: AppStrings.logOut,
                    onTap: () => cubit.logOut(),
                  ),
                ),

                // delete account button
                SliverToBoxAdapter(
                  child: BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      return ProfileTile(
                        iconData: (state is DeleteLoading)
                            ? Icons.autorenew
                            : Icons.delete_outline,
                        itemTitle: AppStrings.deleteAccount,
                        onTap: () => cubit.deletAccount(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
