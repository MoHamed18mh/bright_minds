import 'package:bright_minds/core/api/end_point.dart';
import 'package:bright_minds/core/utils/app_assets.dart';
import 'package:bright_minds/core/utils/app_colors.dart';
import 'package:bright_minds/core/widgets/container_shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  const UserImage({super.key, required this.imageCover});

  final String imageCover;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: (imageCover != ApiKey.imageNull)
            ? CachedNetworkImage(
                imageUrl: imageCover,
                fit: BoxFit.cover,
                memCacheHeight: 300,
                placeholder: (context, url) => const ContainerShimmer(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              )
            : Image.asset(
                Assets.assetsImagesUser,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
