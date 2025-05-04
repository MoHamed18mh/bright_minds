import 'package:bright_minds/core/functions/calc_padding.dart';
import 'package:bright_minds/core/functions/navigation.dart';
import 'package:bright_minds/core/routes/route_keys.dart';
import 'package:bright_minds/core/utils/app_strings.dart';
import 'package:bright_minds/core/widgets/back_button.dart';
import 'package:bright_minds/features/profile/presentation/widgets/profile_tile.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = calcPadding(context);

    return SafeArea(
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
              const SliverToBoxAdapter(
                child: ProfileTile(
                  iconData: Icons.logout_rounded,
                  itemTitle: AppStrings.logOut,
                ),
              ),

              // delete account button
              const SliverToBoxAdapter(
                child: ProfileTile(
                  iconData: Icons.delete_outline,
                  itemTitle: AppStrings.deleteAccount,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
