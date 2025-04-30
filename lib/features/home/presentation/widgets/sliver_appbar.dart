import 'package:bright_minds/core/utils/app_assets.dart';
import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/widgets/app_name.dart';
import 'package:flutter/material.dart';

class SliverAppBarW extends StatelessWidget {
  const SliverAppBarW({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: Image.asset(Assets.assetsImagesLogo),
      titleSpacing: 8,
      title: const AppName(alignment: Alignment.centerLeft),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.person,
            size: 50,
            color: AppColors.primaryColor,
          ),
        ),
      ],
      floating: true,
      backgroundColor: Colors.white,
    );
  }
}
